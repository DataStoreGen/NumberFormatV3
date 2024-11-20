local Replicated = game:GetService('ReplicatedStorage')
local Number = require(Replicated:WaitForChild('NumberFormat'))

local Clicks = Number.GetValue('Clicks')
local ClickText = script.Parent.TextLabel
local ClickPlus = Number.GetValue('ClickPlus')
local ClickButton = script.Parent.TextButton

Clicks:OnChanged(function(newValue, canNotation, canRound)
	ClickText.Text = 'Clicks: ' .. Number.shortE(newValue, canRound, canNotation)
end, ClickText, 1e3, true)

ClickPlus:OnChanged(function(newValue, canNotation, canRound)
	ClickButton.Text = 'Clicks +' .. Number.shortE(newValue, canRound, canNotation)
end, ClickButton, 1e3, true)

-- this script is an example to push for example
-- it will autopreset CanNotatoin but if u want to use custom Notation set u would need to set for ex

--this right here can help u setup ur own Notatoin and will autoRound
--OnChanged(function(newValue, canNotatoin, canRound)

--end, label, 1e50, true)

--[[ another examle if u want to preserver automation for Notation and also canRound
local Replicated = game:GetService('ReplicatedStorage')
local Number = require(Replicated:WaitForChild('NumberFormat'))
local Players = game:GetService('Players')
local Player = Players.LocalPlayer

local Clicks = Number.GetValue('Clicks')
local ClickText = script.Parent.TextLabel
local ClickPlus = Number.GetValue('ClickPlus')
local ClickButton = script.Parent.TextButton

Clicks:OnChanged(function(newValue, canNotation, canRound)
	ClickText.Text = 'Clicks: ' .. Number.shortE(newValue, canRound)
end, ClickText)

ClickPlus:OnChanged(function(newValue, canNotation, canRound)
	ClickButton.Text = 'Clicks +' .. Number.shortE(newValue, canRound)
end, ClickButton)

]]