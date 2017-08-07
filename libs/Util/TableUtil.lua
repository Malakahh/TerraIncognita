local tableUtil = {}

function tableUtil.Merge(t1, t2)
	local t = {}

	for k,v in pairs(t1) do
		t[k] = v
	end

	for k,v in pairs(t2) do
		if t[k] == nil then
			t[k] = v
		end
	end

	return t
end



return tableUtil