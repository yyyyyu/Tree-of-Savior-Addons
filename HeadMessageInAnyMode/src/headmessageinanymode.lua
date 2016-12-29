_G.ADDONS = _G.ADDONS or {};
_G.ADDONS.YYU = _G.ADDONS.YYU or {};
_G.ADDONS.YYU.HeadMessageInAnyMode = _G.ADDONS.YYU.HeadMessageInAnyMode or {};
_G.ADDONS.YYU.HeadMessageInAnyMode.Version = '1.0.0';
(function(g)
	function g.hook(msg)
		return string.find(msg, '^/[gprswy] !!') == 1 and string.sub(msg, 4) or msg;
	end

	function g.init(addon, frame)
		if not g.loaded then
			_G.ADDONS.YYU.Util.hook(_G, 'UI_CHAT', g.hook);
			g.loaded = true;
			CHAT_SYSTEM('Head Message In Any Mode loaded.' .. g.Version .. ' loaded.');
		end
	end

	_G.HEADMESSAGEINANYMODE_ON_INIT = g.init;
end)(_G.ADDONS.YYU.HeadMessageInAnyMode);
