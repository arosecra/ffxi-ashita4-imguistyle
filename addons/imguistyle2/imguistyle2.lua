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

	AshitaCore:GetConfigurationManager():Delete(addon.name);
    AshitaCore:GetConfigurationManager():Load(addon.name, 'imguistyle/' .. player.Name .. '.ini');
	
	local s = AshitaCore:GetGuiManager():GetStyle();
	s.Alpha = configMgr:GetFloat(addon.name, "1", "Alpha", 0);
	s.WindowPadding.x = configMgr:GetFloat(addon.name, "1", "WindowPadding.x", 0);
	s.WindowPadding.y =	configMgr:GetFloat(addon.name, "1", "WindowPadding.y", 0);
	s.WindowRounding = configMgr:GetFloat(addon.name, "1", "WindowRounding", 0);
	s.WindowBorderSize = configMgr:GetFloat(addon.name, "1", "WindowBorderSize", 0);
	s.WindowMinSize.x = configMgr:GetFloat(addon.name, "1", "WindowMinSize.x", 0);
	s.WindowMinSize.y = configMgr:GetFloat(addon.name, "1", "WindowMinSize.y", 0);
	s.WindowTitleAlign.x = configMgr:GetFloat(addon.name, "1", "WindowTitleAlign.x", 0);
	s.WindowTitleAlign.y = configMgr:GetFloat(addon.name, "1", "WindowTitleAlign.y", 0);
	--skipping WindowMenuButtonPosition
	s.ChildRounding = configMgr:GetFloat(addon.name, "1", "ChildRounding", 0);
	s.ChildBorderSize = configMgr:GetFloat(addon.name, "1", "ChildBorderSize", 0);
	s.PopupRounding = configMgr:GetFloat(addon.name, "1", "PopupRounding", 0);
	s.PopupBorderSize = configMgr:GetFloat(addon.name, "1", "PopupBorderSize", 0);
	s.FramePadding.x = configMgr:GetFloat(addon.name, "1", "FramePadding.x", 0);
	s.FramePadding.y = configMgr:GetFloat(addon.name, "1", "FramePadding.y", 0);
	s.FrameRounding = configMgr:GetFloat(addon.name, "1", "FrameRounding", 0);
	s.FrameBorderSize = configMgr:GetFloat(addon.name, "1", "FrameBorderSize", 0);
	s.ItemSpacing.x = configMgr:GetFloat(addon.name, "1", "ItemSpacing.x", 0);
	s.ItemSpacing.y = configMgr:GetFloat(addon.name, "1", "ItemSpacing.y", 0);
	s.ItemInnerSpacing.x = configMgr:GetFloat(addon.name, "1", "ItemInnerSpacing.x", 0);
	s.ItemInnerSpacing.y = configMgr:GetFloat(addon.name, "1", "ItemInnerSpacing.y", 0);
	s.CellPadding.x = configMgr:GetFloat(addon.name, "1", "CellPadding.x", 0);
	s.CellPadding.y = configMgr:GetFloat(addon.name, "1", "CellPadding.y", 0);
	s.TouchExtraPadding.x = configMgr:GetFloat(addon.name, "1", "TouchExtraPadding.x", 0);
	s.TouchExtraPadding.y = configMgr:GetFloat(addon.name, "1", "TouchExtraPadding.y", 0);
	s.IndentSpacing = configMgr:GetFloat(addon.name, "1", "IndentSpacing", 0);
	s.ColumnsMinSpacing = configMgr:GetFloat(addon.name, "1", "ColumnsMinSpacing", 0);
	s.ScrollbarSize = configMgr:GetFloat(addon.name, "1", "ScrollbarSize", 0);
	s.ScrollbarRounding = configMgr:GetFloat(addon.name, "1", "ScrollbarRounding", 0);
	s.GrabMinSize = configMgr:GetFloat(addon.name, "1", "GrabMinSize", 0);
	s.GrabRounding = configMgr:GetFloat(addon.name, "1", "GrabRounding", 0);
	s.LogSliderDeadzone = configMgr:GetFloat(addon.name, "1", "LogSliderDeadzone", 0);
	s.TabBorderSize = configMgr:GetFloat(addon.name, "1", "TabBorderSize", 0);
	s.TabMinWidthForCloseButton = configMgr:GetFloat(addon.name, "1", "TabMinWidthForCloseButton", 0);
	--skipping ColorButtonPosition
	s.ButtonTextAlign.x = configMgr:GetFloat(addon.name, "1", "ButtonTextAlign.x", 0);
	s.ButtonTextAlign.y = configMgr:GetFloat(addon.name, "1", "ButtonTextAlign.y", 0);
	s.SelectableTextAlign.x = configMgr:GetFloat(addon.name, "1", "SelectableTextAlign.x", 0);
	s.SelectableTextAlign.y = configMgr:GetFloat(addon.name, "1", "SelectableTextAlign.y", 0);
	s.DisplayWindowPadding.x = configMgr:GetFloat(addon.name, "1", "DisplayWindowPadding.x", 0);
	s.DisplayWindowPadding.y = configMgr:GetFloat(addon.name, "1", "DisplayWindowPadding.y", 0);
	s.DisplaySafeAreaPadding.x = configMgr:GetFloat(addon.name, "1", "DisplaySafeAreaPadding.x", 0);
	s.DisplaySafeAreaPadding.y = configMgr:GetFloat(addon.name, "1", "DisplaySafeAreaPadding.y", 0);
	s.MouseCursorScale = configMgr:GetFloat(addon.name, "1", "MouseCursorScale", 0);
	
	if configMgr:GetString(addon.name, "1", "AntiAliasedLines") == "true" then
		s.AntiAliasedLines = true
	else
		s.AntiAliasedLines = false
	end
	if configMgr:GetString(addon.name, "1", "AntiAliasedLinesUseTex") == "true" then
		s.AntiAliasedLinesUseTex = true
	else
		s.AntiAliasedLinesUseTex = false
	end
	if configMgr:GetString(addon.name, "1", "AntiAliasedFill") == "true" then
		s.AntiAliasedFill = true
	else
		s.AntiAliasedFill = false
	end
	s.CurveTessellationTol = configMgr:GetFloat(addon.name, "1", "CurveTessellationTol", 0);
	s.CircleSegmentMaxError = configMgr:GetFloat(addon.name, "1", "CircleSegmentMaxError", 0);
	
	for i = 1,ImGuiCol_COUNT do
		s.Colors[i].x = configMgr:GetFloat(addon.name, "2", "Colors["..i.."].x", 0);
		s.Colors[i].y = configMgr:GetFloat(addon.name, "2", "Colors["..i.."].y", 0);
		s.Colors[i].w = configMgr:GetFloat(addon.name, "2", "Colors["..i.."].w", 0);
		s.Colors[i].z = configMgr:GetFloat(addon.name, "2", "Colors["..i.."].z", 0);
	end
	
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
		coroutine.sleepf(1);
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