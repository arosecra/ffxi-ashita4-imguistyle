--[[
* Addons - Copyright (c) 2021 Ashita Development Team
* Contact: https://www.ashitaxi.com/
* Contact: https://discord.gg/Ashita
*
* This file is part of Ashita.
*
* Ashita is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Ashita is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Ashita.  If not, see <https://www.gnu.org/licenses/>.
--]]

-- inspired/ported from https://git.ashitaxi.com/Addons/imguistyle/src/branch/master/imguistyle.lua

addon.name      = 'imguistyle';                 
addon.author    = 'atom0s / ported by arosecra';
addon.version   = '1.0';                        
addon.desc      = 'imgui style editor';         
addon.link      = 'TBD';

local imgui = require('imgui');
local common = require('common');

local runtime_config = {
	show = false
}

local function save_imgui_style()
	local configMgr = AshitaCore:GetConfigurationManager();
	local player = GetPlayerEntity();
	
	if player == nil or player.Name == nil then
		return;
	end
	
	local s = AshitaCore:GetGuiManager():GetStyle();
	configMgr:SetValue(addon.name, "1", "Alpha", tostring(s.Alpha));
	configMgr:SetValue(addon.name, "1", "WindowPadding.x", tostring(s.WindowPadding.x));
	configMgr:SetValue(addon.name, "1", "WindowPadding.y", tostring(s.WindowPadding.y));
	configMgr:SetValue(addon.name, "1", "WindowRounding", tostring(s.WindowRounding));
	configMgr:SetValue(addon.name, "1", "WindowBorderSize", tostring(s.WindowBorderSize));
	configMgr:SetValue(addon.name, "1", "WindowMinSize.x", tostring(s.WindowMinSize.x));
	configMgr:SetValue(addon.name, "1", "WindowMinSize.y", tostring(s.WindowMinSize.y));
	configMgr:SetValue(addon.name, "1", "WindowTitleAlign.x", tostring(s.WindowTitleAlign.x));
	configMgr:SetValue(addon.name, "1", "WindowTitleAlign.y", tostring(s.WindowTitleAlign.y));
	--skipping WindowMenuButtonPosition
	configMgr:SetValue(addon.name, "1", "ChildRounding", tostring(s.ChildRounding));
	configMgr:SetValue(addon.name, "1", "ChildBorderSize", tostring(s.ChildBorderSize));
	configMgr:SetValue(addon.name, "1", "PopupRounding", tostring(s.PopupRounding));
	configMgr:SetValue(addon.name, "1", "PopupBorderSize", tostring(s.PopupBorderSize));
	configMgr:SetValue(addon.name, "1", "FramePadding.x", tostring(s.FramePadding.x));
	configMgr:SetValue(addon.name, "1", "FramePadding.y", tostring(s.FramePadding.y));
	configMgr:SetValue(addon.name, "1", "FrameRounding", tostring(s.FrameRounding));
	configMgr:SetValue(addon.name, "1", "FrameBorderSize", tostring(s.FrameBorderSize));
	configMgr:SetValue(addon.name, "1", "ItemSpacing.x", tostring(s.ItemSpacing.x));
	configMgr:SetValue(addon.name, "1", "ItemSpacing.y", tostring(s.ItemSpacing.y));
	configMgr:SetValue(addon.name, "1", "ItemInnerSpacing.x", tostring(s.ItemInnerSpacing.x));
	configMgr:SetValue(addon.name, "1", "ItemInnerSpacing.y", tostring(s.ItemInnerSpacing.y));
	configMgr:SetValue(addon.name, "1", "CellPadding.x", tostring(s.CellPadding.x));
	configMgr:SetValue(addon.name, "1", "CellPadding.y", tostring(s.CellPadding.y));
	configMgr:SetValue(addon.name, "1", "TouchExtraPadding.x", tostring(s.TouchExtraPadding.x));
	configMgr:SetValue(addon.name, "1", "TouchExtraPadding.y", tostring(s.TouchExtraPadding.y));
	configMgr:SetValue(addon.name, "1", "IndentSpacing", tostring(s.IndentSpacing));
	configMgr:SetValue(addon.name, "1", "ColumnsMinSpacing", tostring(s.ColumnsMinSpacing));
	configMgr:SetValue(addon.name, "1", "ScrollbarSize", tostring(s.ScrollbarSize));
	configMgr:SetValue(addon.name, "1", "ScrollbarRounding", tostring(s.ScrollbarRounding));
	configMgr:SetValue(addon.name, "1", "GrabMinSize", tostring(s.GrabMinSize));
	configMgr:SetValue(addon.name, "1", "GrabRounding", tostring(s.GrabRounding));
	configMgr:SetValue(addon.name, "1", "LogSliderDeadzone", tostring(s.LogSliderDeadzone));
	configMgr:SetValue(addon.name, "1", "TabRounding", tostring(s.TabRounding));
	configMgr:SetValue(addon.name, "1", "TabBorderSize", tostring(s.TabBorderSize));
	configMgr:SetValue(addon.name, "1", "TabMinWidthForCloseButton", tostring(s.TabMinWidthForCloseButton));
	--skipping ColorButtonPosition
	configMgr:SetValue(addon.name, "1", "ButtonTextAlign.x", tostring(s.ButtonTextAlign.x));
	configMgr:SetValue(addon.name, "1", "ButtonTextAlign.y", tostring(s.ButtonTextAlign.y));
	configMgr:SetValue(addon.name, "1", "SelectableTextAlign.x", tostring(s.SelectableTextAlign.x));
	configMgr:SetValue(addon.name, "1", "SelectableTextAlign.y", tostring(s.SelectableTextAlign.y));
	configMgr:SetValue(addon.name, "1", "DisplayWindowPadding.x", tostring(s.DisplayWindowPadding.x));
	configMgr:SetValue(addon.name, "1", "DisplayWindowPadding.y", tostring(s.DisplayWindowPadding.y));
	configMgr:SetValue(addon.name, "1", "DisplaySafeAreaPadding.x", tostring(s.DisplaySafeAreaPadding.x));
	configMgr:SetValue(addon.name, "1", "MouseCursorScale", tostring(s.MouseCursorScale));
	configMgr:SetValue(addon.name, "1", "AntiAliasedLines", tostring(s.AntiAliasedLines));
	configMgr:SetValue(addon.name, "1", "AntiAliasedLinesUseTex", tostring(s.AntiAliasedLinesUseTex));
	configMgr:SetValue(addon.name, "1", "AntiAliasedFill", tostring(s.AntiAliasedFill));
	configMgr:SetValue(addon.name, "1", "CurveTessellationTol", tostring(s.CurveTessellationTol));
	configMgr:SetValue(addon.name, "1", "CircleSegmentMaxError", tostring(s.CircleSegmentMaxError));
	
	configMgr:SetValue(addon.name, "2", "Colors.Size", tostring(ImGuiCol_COUNT));
	
	if s.Colors ~= nil then
		for x = 0, ImGuiCol_COUNT do
			if s.Colors[x] ~= nil then
				configMgr:SetValue(addon.name, "2", "Colors[" .. x .. "].x", tostring(s.Colors[x].x));
				configMgr:SetValue(addon.name, "2", "Colors[" .. x .. "].y", tostring(s.Colors[x].y));
				configMgr:SetValue(addon.name, "2", "Colors[" .. x .. "].z", tostring(s.Colors[x].z));
				configMgr:SetValue(addon.name, "2", "Colors[" .. x .. "].w", tostring(s.Colors[x].w));
			end
		end
	end
	
	
	
	
	
	
	AshitaCore:GetConfigurationManager():Save(addon.name, 'imguistyle/' .. player.Name .. '.ini');
end


local function load_imgui_style()
	local configMgr = AshitaCore:GetConfigurationManager();
	local player = GetPlayerEntity();
	
	if player == nil or player.Name == nil then
		return;
	end
	
	local s = AshitaCore:GetGuiManager():GetStyle();

	AshitaCore:GetConfigurationManager():Delete(addon.name);
    AshitaCore:GetConfigurationManager():Load(addon.name, 'imguistyle/' .. player.Name .. '.ini');

end


ashita.events.register('command', 'command_callback1', function (e)
    if (not e.command:startswith('/imguistyle')) then
        return
    end
    e.blocked = true;

    if (e.command == '/imguistyle show') then
        runtime_config.show = not runtime_config.show
    end
	
	if (e.command == '/imguistyle hide') then
        runtime_config.show = false
    end
	
	if (e.command == '/imguistyle save') then
		coroutine.sleepf(1);
        save_imgui_style();
    end
	
	if (e.command == '/imguistyle load') then
		load_imgui_style();
    end
end);


ashita.events.register('d3d_present', 'macropalette_present_cb', function ()

	if runtime_config.show then
	    imgui.Begin('Style Editor');
        imgui.ShowStyleEditor();
        imgui.End();
	end
end);