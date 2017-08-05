local MathUtil = {}

function MathUtil.Clamp(val, clampMin, clampMax)
	if val == nil then return end
	clampMin = clampMin or 0
	clampMax = clampMax or 1

	if val < clampMin then
		x = clampMin
	elseif val > clampMax then
		x = clampMax
	else
		return val
	end
end

function MathUtil:Lerp(a, b, weight)
	weight = self.Clamp(weight)

	return (1 - weight) * a + weight * b
end

return MathUtil