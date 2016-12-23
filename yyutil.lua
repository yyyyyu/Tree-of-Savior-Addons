_G.ADDONS = _G.ADDONS or {};
_G.ADDONS.YYU = _G.ADDONS.YYU or {};
_G.ADDONS.YYU.Util = _G.ADDONS.YYU.Util or {};

(function(yyutil)
	-----------
	-- proxy --
	-----------
	function yyutil.intercept(obj, key, prev, post)
		local fn = obj[key];
		obj[key] = function(...)
			if type(prev) == 'function' and prev(...) then
				-- ignore original function if prev returns true
				return;
			end
			local ret = fn(...);
			if type(post) == 'function' then
				post(...);
			end
			return ret;
		end
	end

	function yyutil.hook(obj, key, prev, post)
		if type(prev) == 'function' then
			local a = obj[key];
			obj[key] = function(...)
				return a(prev(...))
			end
		end
		
		if type(post) == 'function' then
			local b = obj[key];
			obj[key] = function(...)
				return post(b(...));
			end
		end
	end

	-------------------
	-- slashCommands --
	-------------------
	if yyutil.slashCommands == nil then

		yyutil.slashCommands = {};

		if pcall(function() require('acutil') end) then
			yyutil.slashCommand = function(cmd, fn)
				require('acutil').slashCommand(cmd, fn);
			end
		else
			yyutil.slashCommand = function(cmd, fn)
				if cmd:sub(1,1) ~= "/" then cmd = "/" .. cmd end
				yyutil.slashCommands[cmd] = fn;
			end
		end

		yyutil.UI_CHAT_HOOKED = function(msg)
			-- reference: https://github.com/Tree-of-Savior-Addon-Community/AC-Util/blob/master/src/cwapi.lua
			local words = {};
			for w in msg:gmatch('%S+') do table.insert(words, w) end
			
			local fn = yyutil.slashCommands[table.remove(words, 1)];
			if fn == nil then
				yyutil.UI_CHAT_ORIGINAL(msg);
			else
				fn(words);
			
				-- close chat
				local chatFrame = GET_CHATFRAME();
				local edit = chatFrame:GetChild('mainchat');
				chatFrame:ShowWindow(0);
				edit:ShowWindow(0);
				ui.CloseFrame("chat_option");
				ui.CloseFrame("chat_emoticon");
			end
		end

		-- hook
		yyutil.UI_CHAT_ORIGINAL = _G.UI_CHAT;
		_G.UI_CHAT = yyutil.UI_CHAT_HOOKED;
	end
end)(_G.ADDONS.YYU.Util);
