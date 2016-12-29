------------------
-- test utility --
------------------
function tosunit()
	local ret = {};

	ret.tests = {};
	
	ret.setup = function(fn)
		assert(type(fn) == 'function', 'fn must be function');
		ret.setupFunc = fn;
	end
	
	ret.cleanup = function(fn)
		assert(type(fn) == 'function', 'fn must be function');
		ret.cleanupFunc = fn;
	end

	ret.add = function(name, fn)
		assert(type(name) == 'string', 'name must be string');
		assert(type(fn) == 'function', 'fn must be function');
		ret.tests[#ret.tests + 1] = { name = name, fn = fn };
	end

	ret.run = function()
		(ret.setupFunc or function() end)();
		local ok = {};
		local ng = {};
		for i = 1, #ret.tests do
			local test = ret.tests[i];
			if type(test.fn) == 'function' then
				print('\n===== ' .. test.name .. ' =====');
				local succeeded, result = pcall(test.fn);
				if succeeded then
					ok[#ok + 1] = test.name;
				else
					ng[#ng + 1] = '*** ' .. test.name .. '\n' .. result;
				end
			end
		end
		(ret.cleanupFunc or function() end)();
		
		print('\n##### TEST RESULTS #####');
		print('OK: ' .. #ok);
		
		local msg = 'NG: ' .. #ng;
		for i = 1, #ng do
			msg = msg .. '\n\n' .. ng[i];
		end
		
		if #ng == 0 then
			print(msg);
		else
			io.stderr:write(msg);
		end
		
		return ok, ng;
	end
	
	return ret;
end

-----------------
-- local stubs --
-----------------
local Window = {};
Window.new = function(name)
	return {
		name = name,
		GetChild = function(self, name)
			return Window.new(name);
		end,
		ShowWindow = function(self, flag)
			print('[Window:ShowWindow(' .. flag .. ')] ' .. self.name);
		end
	}
end

------------------
-- global stubs --
------------------
CHAT_SYSTEM = function(msg)
	print('[CHAT_SYSTEM] ' .. msg);
end

function GET_CHATFRAME()
	return Window.new('CHATFRAME');
end

UI_CHAT = function(msg)
	print('[UI_CHAT_ORIGINAL] ' .. msg);
end

info = {};
info.GetBuffCount = function(handle)
	return #handle.buffs;
end
info.GetBuffIndexed = function(handle, index)
	return handle.buffs[index + 1];
end

packet = {};
packet.ReqRemoveBuff = function(buffID)
	local buffs = session.__handle.buffs;
	for i = #buffs, 1, -1 do
		if buffs[i].buffID == buffID then
			table.remove(buffs, i);
		end
	end
end

session = {}
session.__handle = {};
session.__handle.buffs = {};
session.__handle.addBuff = function(buffID)
	local buffs = session.__handle.buffs;
	for k,v in pairs(buffs) do
		if v.buffID == buffID then return end;
	end
	buffs[#buffs + 1] = { buffID = buffID };
end
session.GetMyHandle = function()
	return session.__handle;
end

ui = {}
ui.Chat = function(msg)
	print('[ui.Chat] ' .. msg);
end
ui.CloseFrame = function(name)
	print('[ui.CloseFrame] ' .. name);
end

