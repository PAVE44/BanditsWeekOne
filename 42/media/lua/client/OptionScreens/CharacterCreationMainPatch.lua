require "CharacterCreationMain"

local characterCreationMainCreate = CharacterCreationMain.create

function CharacterCreationMain:create()
    characterCreationMainCreate(self)
    
    self.playButton.title = getText("UI_btn_next")
    self.playButton.internal = "VARIANT"
    self.playButton:setSound("activate", "UIActivateButton")



end

local characterCreationMainOnOptionMouseDown = CharacterCreationMain.onOptionMouseDown

function CharacterCreationMain:onOptionMouseDown(button, x, y)
    characterCreationMainOnOptionMouseDown(self, button, x, y)
    if button.internal == "VARIANT" then
        
        self:setVisible(false)

        self:initPlayer()
        if isClient() and getCore():getAccountUsed() then
            getCore():getAccountUsed():setPlayerFirstAndLastName(self.forenameEntry:getText() .. " " .. self.surnameEntry:getText())
            updateAccountToAccountList(getCore():getAccountUsed())
            getCore():setAccountUsed(nil)
        end

		MainScreen.instance.variantMain:setVisible(true, joypadData)
    end
end
