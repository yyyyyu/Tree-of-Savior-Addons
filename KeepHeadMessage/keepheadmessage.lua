_G.ADDONS = _G.ADDONS or {};
_G.ADDONS.YYU = _G.ADDONS.YYU or {};
_G.ADDONS.YYU.KeepHeadMessage = _G.ADDONS.YYU.KeepHeadMessage or {};

(function(g)
	function g.commandHandler(commands)
		local command = string.lower(commands[1] or '');
		
		if command == 'on' then
			g.store.set('disabled', '');
		elseif command == 'off' then
			g.store.set('disabled', '1');
		elseif command == 'lazysaveon' then
			g.store.set('lazysave', '1');
			g.lazysave = true;
		elseif command == 'lazysaveoff' then
			g.store.set('lazysave', '');
			g.lazysave = false;
		end
	end
	
	function g.intercept(msg)
		if string.find(msg, '!!') == 1 then
			g.store.set(g.msgKey, msg, g.lazysave);
		end
	end

	function g.init(addon, frame)
		local YYUtil = _G.ADDONS.YYU.Util;
		YYUtil.slashCommand('/keepheadmessage', g.commandHandler);
		YYUtil.slashCommand('/khm', g.commandHandler);

		g.store = g.store or YYUtil.File.createSimpleStore('keepheadmessage');
		g.store.flush();
		g.lazysave = g.store.get('lazysave') == '1';
		g.msgKey = 'm' .. session.GetMySession():GetCID();

		if g.store.get('disabled') ~= '1' then
			local msg = g.store.get(g.msgKey);
			if string.find(msg, '!!') == 1 then
				UI_CHAT(msg);
			end
		end
	
		if not g.loaded then
			YYUtil.intercept(_G, 'UI_CHAT', g.intercept);

			g.loaded = true;
			CHAT_SYSTEM('Keep Head Message 1.1.0 loaded.');
		end
	end

	_G.KEEPHEADMESSAGE_ON_INIT = g.init;
end)(_G.ADDONS.YYU.KeepHeadMessage);
