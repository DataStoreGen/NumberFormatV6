--!optimize 2
--!native
local Numv6 = {}
type num = number
local set = {'k', 'm', 'b'}
local first = {"", "U","D","T","Qd","Qn","Sx","Sp","Oc","No"}
local second = {"", "De","Vt","Tg","qg","Qg","sg","Sg","Og","Ng"}
local third = {'', 'Ce'}

function Numv6.add(val1: num, val2: num): num
	return val1+val2
end

function Numv6.sub(val1: num, val2: num): num
	local result = val1-val2
	if result < 0 then return 0 end return result
end

function Numv6.div(val1: num, val2: num): num
	return val1/val2
end

function Numv6.mul(val1: num, val2: num): num
	return val1*val2
end

function Numv6.pow(val1: num, val2: num): num
	return val1^val2
end

function Numv6.sqrt(val1: num): num
	return val1^0.5
end

function Numv6.root(val1: num, root: num): num
	return val1^(1/root)
end

function Numv6.floor(val1: num): num
	return val1-(val1%1)
end

function Numv6.floord(val1: num, decimal: num?): num
	decimal = decimal or 2
	local factor = 10^decimal:: num
	local scale = val1*factor
	local floor = scale-(scale%1)
	return floor/factor
end

function Numv6.log(val1: num, val2: num)
	return math.log(val1, val2)
end

function Numv6.log10(val1: num): num
	return math.log10(val1)
end

function Numv6.lbencode(val1: num): num
	if val1 == 0 then return 4e18 end
	local exp = math.floor(math.log10(math.abs(val1)))
	local man = val1/10^exp
	local sign = (man< 0) and 1 or 2
	local val = sign*1e18
	local fact1 = exp*1e14
	local log = math.log10(math.abs(man)) * 1e13
	if sign == 2 then
		val += fact1 + log
	elseif sign == 1 then
		val += fact1 + log
		val = 1e17 - val
	end
	return val
end

function Numv6.lbdecode(val1: num): num
	if val1 == 4e18 then return 0 end
	local sign = math.floor(val1/1e18)
	local v = (sign==1) and (1e18-val1) or (val1-2e18)
	local exp = math.floor(v/1e14)
	local man = 10^((v%1e14)/1e13)
	if sign == 1 then
		return man * 10^exp*-1
	elseif sign == 2 then
		return man*10^exp
	end
	return math.huge
end

function Numv6.cutDigits(val: num, digit: num): num
	digit = digit or 2
	local fact = 10^digit
	return math.floor(val*fact)/fact
end

function suffixPart(index: num): string
	local hun = math.floor(index/100)
	index %= 100
	local ten, one = math.floor(index/10), index %10
	return  (first[one+1] or '') ..(second[ten+1] or '') .. (third[hun+1] or '')
end

function Numv6.short(val: num, digit: num?): string
	local exp = math.floor(math.log10(math.abs(val)))
	local man = val/10^exp
	local index = math.floor(exp/3)-1
	local lf = math.fmod(exp, 3)
	if index <= -1 then return tostring(val) end
	man = Numv6.cutDigits(man * (10^lf) + 0.001, digit:: num)
	if index < 3 then
		return man .. set[index+1] or ''
	end
	return man .. suffixPart(index)
end

function Numv6.me(val1: num, val2: num): boolean
	return val1>val2
end

function Numv6.le(val1:num, val2: num): boolean
	return val1<val2
end

function Numv6.eq(val1: num, val2: num): boolean
	return val1 == val2
end

function Numv6.meeq(val1: num, val2: num): boolean
	return val1 >= val2
end

function Numv6.leeq(val1: num, val2:num): boolean
	return val1 <= val2
end

function Numv6.between(val1: num, val2: num, val3: num)
	return val1 > val2 or val1 < val3
end

function Numv6.fshort(val: num, digit: num?): string
	if val > 0 or val < 1 then
		return '1/' .. Numv6.short(1/val, digit)
	end
	return Numv6.short(val, digit)
end

function Numv6.toScience(val: num, digit: num?): string
	local fact = math.floor(math.log10(math.abs(val)))
	local man = val/10^fact
	local lf = math.fmod(fact, 3)
	man = Numv6.cutDigits(man * (10^lf), digit::num)
	return man .. 'e' .. fact
end

function Numv6.buyPercent(value: num, percent: num): num
	local a = value*percent
	local b = value-a
	return b
end

function Numv6.Onep(val: num): num
	return Numv6.buyPercent(val, 0.01)
end

function Numv6.Fivep(val: num): num
	return Numv6.buyPercent(val, 0.05)
end

function Numv6.Tenp(val: num): num
	return Numv6.buyPercent(val, 0.1)
end

function Numv6.Twentyp(val: num): num
	return Numv6.buyPercent(val, 0.2)
end

function Numv6.Twenty5p(val: num): num
	return Numv6.buyPercent(val, 0.25)
end

function Numv6.Fiftyp(val: num): num
	return Numv6.buyPercent(val, 0.5)
end

function Numv6.SeventyFivep(val: num)
	return Numv6.buyPercent(val, 0.75)
end

function Numv6.hundp(val: num): num
	return Numv6.buyPercent(val, 1)
end

function Numv6.sqrtN(val: num, iterations: num): num
	for _=1,iterations do
		val = Numv6.sqrt(val)
	end
	return val
end

function Numv6.sqrt10(val: num): num
	return Numv6.sqrtN(val, 10)
end

function Numv6.sqrt5(val: num): num
	return Numv6.sqrtN(val, 5)
end

function Numv6.sqrt2(val: num): num
	return Numv6.sqrtN(val, 2)
end

function Numv6.min(val1: num, val2: num): num
	return (val1 < val2) and val1 or val2
end

function Numv6.max(val1: num, val2: num): num
	return (val1 > val2) and val1 or val2
end

function Numv6.clamp(val1: num, val2: num, clamp: num): num
	if val1 < val2 then return val2 end
	if val1 > clamp then return clamp end
	return val1
end

function Numv6.encodeData(val: num, oldData: num): num
	local new = val
	if oldData then
		local old = Numv6.lbdecode(oldData)
		new = Numv6.max(new, old)
	end
	return Numv6.lbencode(new)
end

function Numv6.mod(val1: num, val2: num): num
	return val1 - Numv6.floor(val1/val2)*val2
end

function Numv6.ceil(val: num): num
	return (val%1==0) and val or (val-(val%1)+1)
end

function Numv6.modf(val: num): (num, num)
	local int = val - (val%1)
	local frac = val - int
	return int, frac
end

return Numv6
