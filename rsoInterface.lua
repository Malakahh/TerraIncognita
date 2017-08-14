local rso = {}
rso.isAvailable = false
rso.interfaceName = "RSO"

function rso:Error(func)
	error("Could not find function " .. func .. " in interface " .. self.interfaceName .. ". Do you have the latest version of RSO and TerraIncognita?")
end

function rso:ValidateExistence(func)
	if not self.isAvailable then return false end
	if remote.interfaces[self.interfaceName][func] == nil then 		
		self:Error(func) 
	end

	return true
end

function rso:Init()
	if remote.interfaces[self.interfaceName] ~= nil then
		self.isAvailable = true
	end		
end

function rso:DisableChunkHandler()
	if not self:ValidateExistence("disableChunkHandler") then return end
	remote.call(self.interfaceName, "disableChunkHandler")
end

function rso:GenerateChunk(event)
	if not self:ValidateExistence("generateChunk") then return end
	remote.call(self.interfaceName, "generateChunk", event)
end

function rso:Regenerate(new_seed)
	if not self:ValidateExistence("regenerate") then return end
	remote.call(self.interfaceName, "regenerate", new_seed)
end

return rso