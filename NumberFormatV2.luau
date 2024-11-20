local suffixes = {
	'', "k", "m", "b", "t", "qd", "qn", "sx", "sp",
	"oc", "No", "De", "UDe", "DDe", "TDe", "QdDe", "QnDe", "SxDe",
	"SpDe", "OcDe", "NoDe", "Vt", "UVt", "DVt", "TVt", "QdVt", "QnVt",
	"SxVt", "SpVt", "OcVt", "NoVt", "Tg", "UTg", "DTg", "TTg", "QdTg",
	"QnTg", "SxTg", "SpTg", "OcTg", "NoTg", "qg", "Uqg", "Dqg", "Tqg",
	"Qdqg", "Qnqg", "Sxqg", "Spqg", "Ocqg", "Noqg", "Qg", "UQg", "DQg",
	"TQg", "QdQg", "QnQg", "SxQg", "SpQg", "OcQg", "NoQg", "sg", "Usg",
	"Dsg", "Tsg", "Qdsg", "Qnsg", "Sxsg", "Spsg", "Ocsg", "Nosg", "Sg",
	"USg", "DSg", "TSg", "QdSg", "QnSg", "SxSg", "SpSg", "OcSg", "NoSg",
	"Og", "UOg", "DOg", "TOg", "QdOg", "QnOg", "SxOg", "SpOg", "OcOg",
	"NoOg", "Ng", "UNg", "DNg", "QdNg", "QnNg", "SxNg", "SpNg", "OcNg",
	"NoNg", "Ce", "UCe"
}

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
	if canRound then
		return Number.floor(value)
	end
	return value
end

function Number.div(val1, val2, canRound: boolean?)
	local value = val1/val2
	if canRound then
		return Number.floor(value)
	end
	return value
end

function Number.mul(val1, val2, canRound: boolean?)
	local value = val1*val2
	if canRound then
		return Number.floor(value)
	end
	return value
end

function Number.sub(val1, val2, canRound: boolean?)
	val1 = val1 - val2
	if val1 <= 0 then return 0 end
	if canRound then
		return Number.floor(val1)
	end
	return val1
end

function Number.log(value, canRound: boolean?)
	value = math.log(value)
	if canRound then
		return Number.floor(value)
	end
	return value
end

function Number.logx(val1, val2, canRound: boolean?)
	local value = math.log(val1, val2)
	if canRound then
		return Number.floor(value)
	end
	return value
end

function Number.log10(val1)
	return Number.logx(val1, 10)
end

function Number.pow(val1, val2, canRound: boolean?)
	val1 = val1^val2
	if canRound then return Number.floor(val1) end
	return val1
end

function Number.clamp(value: number, min: number, max: number)
	if min > max then
		min, max = max, min
	end
	if value < min then return min
	elseif value > max then return max end
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
	if canRound then
		return Number.floor(value)
	end
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
		if format:sub(1, 1) == ',' then format = format:sub(2) end
		return format
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

function Number.toNotation(value)
	local toTable = Number.toTable(value)
	local man, exp = toTable[1], toTable[2]
	return man .. 'e' .. exp
end

function Number.short(value)
	local toTable = Number.toTable(value)
	local man, exp = toTable[1], toTable[2]
	local SNum = math.floor(exp/3)
	local suffix = suffixes[SNum+1]
	if SNum == 0 then return tostring(math.floor(man * 100 + 0.001)/100)
	elseif SNum == 1 then return Number.Comma(value) end
	if SNum >= #suffixes then return 'inf' end
	man = man * 10 ^(exp%3)
	man = Number.floor(man)
	return man .. suffix
end
	
function Number.shortE(value: number, canNotation: number?): 'Notation will automatic preset but if u want one smaller do it as 1e3'
	canNotation = canNotation or 1e6
	value = Number.clamp(value, -canNotation, canNotation)
	if math.abs(value) >= canNotation then
		return Number.toNotation(value)
	end
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

	if days > 0 then
		result = string.format('%dd', days)
		if hours > 0 then
			result = result .. string.format(':%dh', hours)
		end
		if minutes > 0 then
			result = result .. string.format(':%dm', minutes)
		end
		if seconds > 0 then
			result = result .. string.format(':%ds', seconds)
		end
	elseif hours > 0 then
		result = string.format('%dh', hours)
		if minutes > 0 then
			result = result .. string.format(':%dm', minutes)
		end
		if seconds > 0 then
			result = result .. string.format(':%ds', seconds)
		end
	elseif minutes > 0 then
		result = string.format('%dm', minutes)
		if seconds > 0 then
			result = result .. string.format(':%ds', seconds)
		end
	else
		result = string.format('%ds', seconds)
	end
	return result
end


return Number