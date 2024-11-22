local ReplicatedStorage = game:GetService('ReplicatedStorage')
local NumberFormat = require(ReplicatedStorage:FindFirstChild('NumberFormat'))

local first = NumberFormat.add(1.16518, 1.84894)
print(first) -- output is just 3.01412
--local first = NumberFormat.add(1.16518, 1.84894, true) -- output is 3.01
--same with other calculations
local shortE = NumberFormat.shortE(12345, true) -- non-canNotation will preset toNotation at 1e6 which is 1,000*1,000
--new push is canNotation on the shortE so u can correct 1.2345e4 to 1.23e4
--and also shortE setup for short without calling short but if u want a good Notation set Notation past 1e100
print(shortE)-- also pre-formats Comma if its under 1m so output is 12,000 if u want to do 1m after Comma set the canNotation to 1e30
--thats pretty much it
local Concat = NumberFormat.Concat(1000) -- makes it so its 1,000
print(Concat) -- should be able todo short then Notation