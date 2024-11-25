local CustomSuffix = {}
CustomSuffix.__index = CustomSuffix

function CustomSuffix.toTable(value)
	if value == 0 then return {0, 0} end
	local exp = math.floor(math.log10(math.abs(value)))
	return {value / 10^exp, exp}
end

function CustomSuffix.new(customSuffix: {string})
	local self = setmetatable({customSuffix = customSuffix}, CustomSuffix)
	return self
end

function CustomSuffix:cshort(value)
	local toTable = CustomSuffix.toTable(value)
	local exp, man = toTable[2], toTable[1]
	if exp < 3 then return math.floor(self.Value * 100 + 0.001)/100 end
	local ind = math.floor(exp/3)-1
	if ind >= #self.customSuffix then return string.format('%de%d', man, exp):gsub('+', '') end
	local rm = exp%3
	man = man*10^rm
	return man .. self.customSuffix[ind + 1]
end

return CustomSuffix