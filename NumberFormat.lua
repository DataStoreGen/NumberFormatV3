local first = {"", "U","D","T","Qd","Qn","Sx","Sp","Oc","No"}
local second = {"", "De","Vt","Tg","qg","Qg","sg","Sg","Og","Ng"}
local third = {'', 'Ce'}
local CustomSuffix = require(script.CustonSuffix)
local Number = {}

function Number.eq(val1: number, val2: number)
	return val1 == val2
end

function Number.me(val1: number, val2: number)
	return val1 > val2
end

function Number.le(val1: number, val2: number)
	return val1 < val2
end

function Number.meeq(val1: number, val2: number)
	return (val1 > val2) or (val1 == val2)
end

function Number.leeq(val1: number, val2: number)
	return (val1 < val2) or (val1 == val2)
end

function Number.floor(val1)
	return math.floor(val1 * 100 + 0.001) / 100
end

function Number.add(val1, val2, canRound: boolean?)
	local value = val1+val2
	if canRound then	return Number.floor(value)	end
	return value
end

function Number.div(val1, val2, canRound: boolean?)
	local value = val1/val2
	if canRound then	return Number.floor(value)end
	return value
end

function Number.mul(val1, val2, canRound: boolean?)
	local value = val1*val2
	if canRound then	return Number.floor(value) end
	return value
end

function Number.sub(val1, val2, canRound: boolean?)
	val1 = val1 - val2
	if val1 <= 0 then return 0 end
	if canRound then	return Number.floor(val1) end
	return val1
end

function Number.log(value, canRound: boolean?)
	value = math.log(value)
	if canRound then	return Number.floor(value) end
	return value
end

function Number.logx(val1, val2, canRound: boolean?)
	local value = math.log(val1, val2)
	if canRound then	return Number.floor(value) end
	return value
end

function Number.log10(val1, canRound: boolean?)
	return Number.logx(val1, 10, canRound)
end

function Number.pow(val1, val2, canRound: boolean?)
	val1 = val1^val2
	if canRound then return Number.floor(val1) end return val1
end

function Number.clamp(value: number, min: number, max: number)
	if Number.me(min, max) then min, max = max, min end
	if Number.le(value, min) then return min elseif Number.me(value, max) then return max end
	return value
end

function Number.min(val1, val2)
	return val1 < val2 and val1 or val2
end

function Number.max(val1, val2)
	return val1 > val2 and val1 or val2
end

function Number.mod(val1, val2, canRound: boolean?)
	local value = val1 % val2
	if canRound then	return Number.floor(value) end
	return value
end

function Number.factorial(val1)
	if val1 == 0 then return 1 end
	local result = 1
	for i = 2, val1 do
		result = result * i
	end
	return result
end

function Number.Comma(value)
	if value >= 1e3 then
		value = math.floor(value)
		local format = tostring(value)
		format = format:reverse():gsub('(%d%d%d)', '%1,'):reverse()
		if format:sub(1, 1) == ',' then format = format:sub(2) end return format
	end
	return value
end

function Number.toTable(value)
	if value == 0 then return {0, 0} end
	local exp = math.floor(math.log10(math.abs(value)))
	return {value / 10^exp, exp}
end

function Number.toNumber(value)
	return (value[1] * (10^value[2]))
end

function Number.toNotation(value, canRound: boolean?)
	local toTable = Number.toTable(value)
	local man, exp = toTable[1], toTable[2]
	if canRound then	return Number.floor(man) .. 'e' .. exp end
	return man .. 'e' .. exp
end

function suffixPart(index)
	local hun = math.floor(index/100)
	index = index%100
	local ten, one = math.floor(index/10), index % 10
	return (first[one+1] or '') ..(second[ten+1] or '') .. (third[hun+1] or '')
end

function Number.short(value)
	local toTable = Number.toTable(value)
	local exp, man = toTable[2], toTable[1]
	if exp < 3 then return math.floor(value * 100 + 0.001)/100 end
	local ind = math.floor(exp/3)-1
	if ind > 101 then return 'inf' end
	local rm = exp%3
	man = math.floor(man*10^rm * 100 + 0.001) / 100
	if ind == 0 then return string.format('%dk', man)	elseif ind == 1 then	return string.format('%dm', man) elseif ind == 2 then return string.format('%db', man)	end
	return man .. suffixPart(ind)
end

function Number.shortE(value: number, canRound: boolean?, canNotation: number?): 'Notation will automatic preset but if u want one smaller do it as 1e3'
	canNotation = canNotation or 1e6
	if math.abs(value) >= canNotation then return Number.toNotation(value, canRound):gsub('nane','')	end
	return Number.short(value)
end

function Number.maxBuy(c, b, r, k)
	local en = Number
	local max = en.div(math.log(en.add(en.div(en.mul(c , en.sub(r , 1)) , en.mul(b , en.pow(r,k))) , 1)) , en.log(r))
	local cost =  en.mul(b , en.div(en.mul(en.pow(r,k) , en.sub(en.pow(r,max) , 1)), en.sub(r , 1)))
	local nextCost = en.mul(b, en.pow(r,max))
	return max, cost, nextCost
end

function Number.CorrectTime(value: number)
	local days = math.floor(value / 86400)
	local hours = math.floor((value % 86400) / 3600)
	local minutes = math.floor((value % 3600) / 60)
	local seconds = value % 60
	local result = ""
	local function appendTime(unit, label)
		if unit > 0 then	result = result .. string.format(':%d%s', unit, label)	end
	end
	if days > 0 then
		result = string.format('%dd', days) appendTime(hours, 'h')	appendTime(minutes, 'm') appendTime(seconds, 's') 
	elseif hours > 0 then
		result = string.format('%dh', hours)	appendTime(minutes, 'm') appendTime(seconds, 's')
	elseif minutes > 0 then
		result = string.format('%dm', minutes) 	appendTime(seconds, 's')
	else
		result = string.format('%ds', seconds)
	end
	return result
end

function Number.percent(part, total, canRound: boolean?)
	local value = (part / total) * 100
	if canRound then	return Number.floor(value) end
	if value < 0.001 then return '0%' end
	return value .. '%'
end

function Number.Changed(value, callBack: (property: string) -> ())
	value.Changed:Connect(callBack)
end

function Number.Concat(value, canRound: boolean?, canNotation: number?)
	canNotation = canNotation or 1e6
	if value >= canNotation then return Number.shortE(value, canRound, canNotation) end
	return Number.Comma(value)
end

Number.__index = Number
function Number.GetValue(valueName, Player: Player)
	local self = setmetatable({}, Number)
	for _, names in pairs(Player:GetDescendants()) do
		if names.Name == valueName then
			self.Instance = names
			self.Name = names.Name :: string
			self.Value = names.Value :: number
		end
	end
	return self
end

type labels = TextLabel|TextButton
function Number:OnChanged(callBack: (property: string, canRound: boolean?, canNotation: number?) -> (), label: labels?, canNotation: number?, canRound: boolean?)
	canRound = canRound or true
	Number.Changed(self.Instance, function(property)
		callBack(property, canRound, canNotation)
	end)
	if label then
		local valueText = self.Name
		if valueText:find('Plus') then
			label.Text = valueText:gsub('Plus', ''):gsub(':','') ..' +' .. Number.shortE(self.Value, canRound, canNotation)
		else
			label.Text = valueText .. ': ' .. Number.shortE(self.Value, canRound, canNotation)
		end
	end
end

return Number