--!strict
local first = {"", "U","D","T","Qd","Qn","Sx","Sp","Oc","No"}
local second = {"", "De","Vt","Tg","qg","Qg","sg","Sg","Og","Ng"}
local third = {'', 'Ce'}
local Number = {}

function Number.eq(val1: number, val2: number): boolean
	return val1 == val2
end

function Number.me(val1: number, val2: number): boolean
	return val1 > val2
end

function Number.le(val1: number, val2: number): boolean
	return val1 < val2
end

function Number.meeq(val1: number, val2: number): boolean
	return (val1 > val2) or (val1 == val2)
end

function Number.leeq(val1: number, val2: number): boolean
	return (val1 < val2) or (val1 == val2)
end

function Number.floor(val1: number): number
	return math.floor(val1 * 100 + 0.001):: number / 100
end

function Number.add(val1: number, val2: number, canRound: boolean?): number
	local value = val1+val2
	if canRound then	return Number.floor(value)	end
	return value
end

function Number.div(val1: number, val2: number, canRound: boolean?)
	local value = val1/val2
	if canRound then	return Number.floor(value)end
	return value
end

function Number.mul(val1: number, val2: number, canRound: boolean?)
	local value = val1*val2
	if canRound then	return Number.floor(value) end
	return value
end

function Number.sub(val1: number, val2: number, canRound: boolean?)
	val1 = val1 - val2
	if val1 <= 0 then return 0 end
	if canRound then	return Number.floor(val1) end
	return val1
end

function Number.log(value: number, canRound: boolean?)
	value = math.log(value)
	if canRound then	return Number.floor(value) end
	return value
end

function Number.logx(val1: number, val2: number, canRound: boolean?)
	local value = math.log(val1, val2)
	if canRound then	return Number.floor(value) end
	return value
end

function Number.log10(val1: number, canRound: boolean?)
	return Number.logx(val1, 10, canRound)
end

function Number.pow(val1: number, val2: number, canRound: boolean?)
	val1 = val1^val2
	if canRound then return Number.floor(val1) end return val1
end

function Number.clamp(value: number, min: number, max: number)
	if Number.me(min, max) then min, max = max, min end
	if Number.le(value, min) then return min elseif Number.me(value, max) then return max end
	return value
end

function Number.min(val1: number, val2: number): number
	return val1 < val2 and val1 or val2
end

function Number.max(val1: number, val2: number): number
	return val1 > val2 and val1 or val2
end

function Number.mod(val1: number, val2: number , canRound: boolean?): number
	local value = val1 % val2
	if canRound then	return Number.floor(value) end
	return value
end

function Number.factorial(val1: number): number
	if val1 == 0 then return 1 end
	local result = 1
	for i = 2, val1 do
		result = result * i
	end
	return result
end

function Number.Comma(value: number): string
	if value >= 1e3 then
		value = math.floor(value)
		local format = tostring(value)
		format = format:reverse():gsub('(%d%d%d)', '%1,'):reverse()
		if format:sub(1, 1) == ',' then format = format:sub(2) end return format
	end
	return tostring(value)
end

function Number.toTable(value: number): {number}
	if value == 0 then return {0, 0} end
	local exp = math.floor(math.log10(math.abs(value)))
	return {value / 10^exp, exp}
end

function Number.toNumber(value: {number}): number
	return (value[1] * (10^value[2]))
end

function Number.toNotation(value: number, canRound: boolean?): string
	local toTable = Number.toTable(value)
	local man, exp = toTable[1], toTable[2]
	if canRound then	return tostring(Number.floor(man)) .. 'e' .. tostring(exp) end
	return tostring(man) .. 'e' .. tostring(exp)
end

function suffixPart(index: number): string
	local hun = math.floor(index/100)
	index = index%100
	local ten, one = math.floor(index/10), index % 10
	return (first[one+1] or '') ..(second[ten+1] or '') .. (third[hun+1] or '')
end

function Number.between(value1: number, value2: number, value3: number): boolean
	return Number.me(value1, value2) and Number.le(value1, value3)
end

function Number.short(value: number): string
	local toTable = Number.toTable(value)
	local exp, man = toTable[2], toTable[1]
	if Number.between(value, 0, 1) then
		local abs = math.abs(exp)
		if abs < 3 then
			return tostring(math.floor(value * 10^abs * 100 + 0.001) / 100)
		else
			local ind = math.floor(abs / 3) - 1
			if ind > 101 then return 'inf' end
			local rm = abs % 3
			man = math.floor(man * 10^rm * 100 + 0.001) / 100
			if ind == 0 then return '1/' .. tostring(man) .. 'k' 
			elseif ind == 1 then return '1/' .. tostring(man) .. 'm' 
			elseif ind == 2 then return '1/' .. tostring(man) .. 'b' 
			end
			return '1/' .. tostring(man) .. suffixPart(ind)
		end
	else
		if exp < 3 then return tostring(math.floor(value * 100 + 0.001)/100) end
		local ind = math.floor(exp/3)-1
		if ind > 101 then return 'inf' end
		local rm = exp%3
		man = math.floor(man*10^rm * 100 + 0.001) / 100
		if ind == 0 then return tostring(man) ..'k' elseif ind == 1 then return tostring(man) ..'m' elseif ind == 2 then return tostring(man) ..'b' end
		return tostring(man) .. suffixPart(ind)
	end
end

function Number.shortE(value: number, canRound: boolean?, canNotation: number?): string
	canNotation = canNotation or 1e6
	if math.abs(value) >= canNotation then return Number.toNotation(value, canRound):gsub('nane',''):: string	end
	return Number.short(value)
end

function Number.maxBuy(c: number, b: number, r: number, k: number): (number, number, number)
	local en = Number
	local max = en.div(math.log(en.add(en.div(en.mul(c , en.sub(r , 1)) , en.mul(b , en.pow(r,k))) , 1)) , en.log(r))
	local cost =  en.mul(b , en.div(en.mul(en.pow(r,k) , en.sub(en.pow(r,max) , 1)), en.sub(r , 1)))
	local nextCost = en.mul(b, en.pow(r,max))
	return max, cost, nextCost
end

function Number.CorrectTime(value: number): string
	local days = math.floor(value / 86400)
	local hours = math.floor((value % 86400) / 3600)
	local minutes = math.floor((value % 3600) / 60)
	local seconds = value % 60
	local result: string = ""
	local function appendTime(unit, label)
		if unit > 0 then	result = result :: string .. string.format(':%d%s', unit, label) :: string end
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

function Number.percent(part: number, total: number, canRound: boolean?): string
	local value = (part / total) * 100
	if canRound then	return tostring(Number.floor(value)) .. '%' end
	if value < 0.001 then return '0%' end
	return tostring(value) .. '%'
end

function Number.Changed(value, callBack: (property: string) -> ())
	value.Changed:Connect(callBack)
end

function Number.Concat(value: number, canRound: boolean?, canNotation: number?): string
	canNotation = canNotation or 1e6
	if value >= canNotation then return Number.shortE(value, canRound, canNotation) end
	return Number.Comma(value)
end

function Number.lbencode(value: number): number
	local toTable = Number.toTable(value)
	local man, exp = toTable[1], toTable[2]
	if man == 0 then return 4e18 end
	local mode = 0
	if man < 0 then
		mode = 1
	elseif man > 0 then
		mode = 2
	end
	local val = mode * 1e18
	if mode == 2 then
		val += (exp * 1e14) + (math.log10(math.abs(man))*1e13)
	elseif mode == 1 then
		val += (exp * 1e14) + (math.log10(math.abs(man))*1e13)
		val = 1e17 - val
	end
	return val
end

function Number.lbdecode(value: number): number 
	if value == 4e18 then return 0 end
	local mode = math.floor(value/1e18)
	if mode == 1 then
		local v = 1e18 - value
		local exp = math.floor(v/1e14)
		local man = 10^((v%1e14)/1e13)
		return Number.toNumber({-man, exp})
	elseif mode == 2 then
		local v = value - 2e18
		local exp: number = math.floor(v/1e14)
		local man: number = 10^((v%1e14)/1e13)
		return Number.toNumber({man, exp})
	end
	return math.huge
end

function Number.Roman(value: number): string
	local toRoman = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1}
	local suffix = {"M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"}
	local rom = ''
	for i, val in ipairs(toRoman) do
		while Number.meeq(value, val) do
			rom = rom .. suffix[i]
			value = value - val
		end
	end
	return rom
end

function Number.getCurrentData(value: number, oldValue: number)
	local new = value
	if oldValue then
		local old = Number.lbdecode(oldValue)
		new = Number.max(new, old)
	end
	return Number.lbencode(new)
end

return Number