--[[	*** LibMVC ***
Written by : Thaoky, EU-Marécages de Zangar
April 30th, 2017

License: Public Domain

This library provides a light way to implement the MVC pattern in an add-on.

The goal is to provide an easy way to manage views (= frames defined in XML) via controllers.
The Model part, which is supposed to provide the data to the controller is up to the developer, 
but in a way similar to AngularJS, it is possible to define services, and to inject them into the controller.

See example.xml & example.lua for usage (in the same directory as this file)

No data binding is implemented at this point, maybe later.

--]]

local LIB_VERSION_MAJOR, LIB_VERSION_MINOR = "LibMVC-1.0", 4
local lib = LibStub:NewLibrary(LIB_VERSION_MAJOR, LIB_VERSION_MINOR)

if not lib then return end -- No upgrade needed

lib.embeds = lib.embeds or {} -- what objects embed this lib

local registeredServices = {}
local registeredControllers = {}

local TEAL = "|cFF00FF9A"
local WHITE = "|cFFFFFFFF"

local function Print(text)
	print(format("%sLibMVC|r%s: %s", TEAL, WHITE, text))
end

local function GetDependencies(name, objectArgs)
	-- objectArgs: The expected format is { "data2", "data3", function(data2, data3) ... end }
	-- so an array where all elements are strings (service names), except the last element which is a function
	local dependencies = {}

	for i = 1, #objectArgs - 1 do
		local dependencyName = objectArgs[i]
		local service = registeredServices[dependencyName]
		
		if service then
			table.insert(dependencies, service)
		else
			Print(format("Service %s could not be injected in %s.", dependencyName, name))
			Print(format("Possible cause: %s is loaded after %s", dependencyName, name))
		end
	end
	
	return dependencies
end

local function GetProvider(objectArgs)
	-- The expected format is { "data2", "data3", function(data2, data3) ... end }
	-- so an array, where the last element is a function
	return objectArgs[#objectArgs]
end

local function RegisterObject(name, args, storage)
	-- This function will register a controller or a service, and deal with injecting dependencies
	assert(type(name) == "string")
	assert(type(storage) == "table")
	
	-- The easy case (no injection)
	--		addon:Service("Equipment", { registeredObject })
	--		addon:Controller("MessageBox", { registeredObject })
	local registeredObject = args
	
	if type(args) == "function" then 
		-- addon:Service("formatter",  function() return { *stuff* } end
		registeredObject = args()
	
	elseif args[1] then
		-- The complex case
		-- 	if there is something in the first element of the array part of the table,	we have dependencies to inject
		--		addon:Controller("MessageBox", { "data2", "data3", function(data2, data3) ... end })
	
		local services = GetDependencies(name, args)
		local provider = GetProvider(args)
	
		if type(provider) ~= "function" then
			Print(format("No valid provider found for %s.", name))
			return
		end
	
		-- call the provider to get the object
		registeredObject = provider(unpack(services))
	end
		
	if type(registeredObject) ~= "table" then
		Print(format("No object to register in for %s.", name))
		return
	end
	
	if storage[name] then
		Print(format("Object %s already registered.", name))
		return
	end
	
	storage[name] = registeredObject
end

-- *** Model ***
function lib:Service(name, args)
	RegisterObject(name, args, registeredServices)
end

function lib:GetService(name)
	return registeredServices[name]
end

-- *** View ***
local function SetViewMethods(frame, controller)
	-- simply assign all of the controller's methods to the frame
	for methodName, method in pairs(controller) do
		frame[methodName] = method
	end
end

function lib:BindViewToController(frame, controller, inherits)
	-- controller: (must be string)
	--		single controller (ex: "MessageBox")
	-- inherits: (string or nil)
	--		multiple controllers (ex: "Button,ClassIcon"), this covers a pseudo-inheritance.
	--			the goal is mostly to run the "OnBind" of the controllers to initialize them in a specific order (left to right)
	--
	-- Ex: addon:BindViewToController(self, "RealmPicker", "Frame,DropDownMenu" )
	-- This binds the frame to the "RealmPicker", and will run the 'OnBind' methods of "Frame" then "DropDownMenu" then "RealmPicker"
	
	local controllers = registeredControllers
	if not controllers[controller] then 
		Print(format("BindViewToController() Controller %s does not exist.", controller))
		return 
	end
	
	SetViewMethods(frame, controllers[controller])
	
	-- This controller's OnBind will be overwritten by the inherited ones, save it for now.
	local saveOnBind = frame.OnBind
	
	-- execute the OnBind methods
	-- .. first the inherited ones (if any), from left to right
	if inherits then
		for item in inherits:gmatch("([^,]+)") do
			local c = controllers[item]	-- dereference inherited controller
			
			if c then
				SetViewMethods(frame, c)
			
				if c.OnBind then
					c.OnBind(frame)
				end
			end
		end
	end
	
	-- Restore the saved OnBind
	frame.OnBind = saveOnBind
	
	-- .. then the actual controller's OnBind
	if frame.OnBind then
		frame:OnBind()
	end
end

function lib:UnbindViewFromController(frame, controller)
	for methodName, _ in pairs(registeredControllers[controller]) do
		frame[methodName] = nil
	end
end

-- *** Controller ***
--[[
Note : 
	(30/04/2017)
	Each frame's new method contain a pointer to the actual function in memory.
	I tried an approach that used a metatable, it worked, but since it's called for EVERY method of the frame (Show, Hide, ..), the risk
	of tainting/conflicting is real, so I did not go through with it. Better keep a simple method that works (function pointers) rather than 
	a more complex (yet more direct) method that could cause troubles. 

	The previous approach using class extensions did almost the same, but did not support inheritance of the OnBind method, which I often needed in the past.
--]]

function lib:Controller(name, args)
	RegisterObject(name, args, registeredControllers)
end

local mixins = {
	"Service",
	"Controller",
	"BindViewToController",
	"UnbindViewFromController",
} 

function lib:Embed(target)
	for _, v in pairs(mixins) do
		target[v] = self[v]
	end
	self.embeds[target] = true
	return target
end

for target, _ in pairs(lib.embeds) do
	lib:Embed(target)
end
