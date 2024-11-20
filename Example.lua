local ReplicatedStorage = game:GetService('ReplicatedStorage')
local NumberFormat = require(ReplicatedStorage:FindFirstChild('NumberFormat'))

local first = NumberFormat.add(1.16518, 1.84894)
print(first) -- output is just 3.01412
--local first = NumberFormat.add(1.16518, 1.84894, true) -- output is 3.01
--same with other calculations
local shortE = NumberFormat.shortE(12000) -- non-canNotation will preset toNotation at 1e6 which is 1,000*1,000
print(shortE)-- also pre-formats Comma if its under 1m so output is 12,000 if u want to do 1m after Comma set the canNotation to 1e30
--thats pretty much it