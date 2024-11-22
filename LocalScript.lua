local Replicated = game:GetService('ReplicatedStorage')
local Number = require(Replicated:WaitForChild('Number'))

local Clicks = Number.GetValue('Clicks')
local ClickText = script.Parent.TextLabel
local ClickPlus = Number.GetValue('ClickPlus')
local ClickButton = script.Parent.TextButton

Clicks:OnChanged(function(newValue, canNotation, canRound)
	ClickText.Text = 'Clicks: ' .. Number.shortE(newValue, canRound, canNotation)
end, ClickText)

ClickPlus:OnChanged(function(newValue, canNotation, canRound)
	ClickButton.Text = 'Clicks +' .. Number.shortE(newValue, canRound, canNotation)
end, ClickButton)

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
local startNotation = 1e50

Clicks:OnChanged(function(newValue, canNotation, canRound)
	ClickText.Text = 'Clicks: ' .. Number.Concat(newValue, canNotation, canRound)
end, ClickText, startNotation, true) to setup Notation to start at 1e50

ClickPlus:OnChanged(function(newValue, canNotation, canRound)
	ClickButton.Text = 'Clicks +' .. Number.shortE(newValue, canNotation, canRound)
end, ClickButton, startNotation, true)
]]