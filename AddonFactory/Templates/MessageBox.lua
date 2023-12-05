local MVC = LibStub("LibMVC-1.0")

MVC:Controller("AddonFactory.MessageBox", {
	SetText = function(frame, text)
		frame.Text:SetText(text)
	end,
	
	Ask = function(frame, text, onClickButton1, onClickButton2)
		frame.UserInput:Hide()
		frame.UserInput:SetText("")
		frame.Button1:SetText(YES)
		frame.Button2:SetText(NO)
		
		frame.Text:SetText(text)
		frame.onClickButton1 = onClickButton1		-- callback on "Yes"
		frame.onClickButton2 = onClickButton2		-- callback on "No"
		frame:Show()
	end,

	AskWithInput = function(frame, text, onClickButton1, onClickButton2)
		frame.UserInput:Show()
		frame.UserInput:SetText("")
		frame.Button1:SetText(OKAY)
		frame.Button2:SetText(CANCEL)
		
		frame.Text:SetText(text)
		frame.onClickButton1 = onClickButton1		-- callback on "Okay"
		frame.onClickButton2 = onClickButton2		-- callback on "Cancel"
		frame:Show()
	end,
	
	Button_OnClick = function(frame, button)
		if button == 1 and frame.onClickButton1 then
			-- Callback if button 1 was clicked
			frame.onClickButton1(frame.UserInput:GetText())
			
		elseif button == 2 and frame.onClickButton2 then
			-- Callback if button 2 was clicked
			frame.onClickButton2()
		end
		
		frame:Hide()
		frame:SetHeight(120)
		frame.Text:SetHeight(28)	
	end,
})
