; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Child Mod - Switch Profiles
; Description ...: This file creates the "Mods" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Team Mod MBR (NguyenAnhHD, Demen)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $g_hChkGoldSwitchMax = 0, $g_hCmbGoldMaxProfile = 0, $g_hTxtMaxGoldAmount = 0, $g_hChkGoldSwitchMin = 0, $g_hCmbGoldMinProfile = 0, $g_hTxtMinGoldAmount = 0, _
	   $g_hChkElixirSwitchMax = 0, $g_hCmbElixirMaxProfile = 0, $g_hTxtMaxElixirAmount = 0, $g_hChkElixirSwitchMin = 0, $g_hCmbElixirMinProfile = 0, $g_hTxtMinElixirAmount = 0, _
	   $g_hChkDESwitchMax = 0, $g_hCmbDEMaxProfile = 0, $g_hTxtMaxDEAmount = 0, $g_hChkDESwitchMin = 0, $g_hCmbDEMinProfile = 0, $g_hTxtMinDEAmount = 0, _
	   $g_hChkTrophySwitchMax = 0, $g_hCmbTrophyMaxProfile = 0, $g_hTxtMaxTrophyAmount = 0, $g_hChkTrophySwitchMin = 0, $g_hCmbTrophyMinProfile = 0, $g_hTxtMinTrophyAmount = 0

Func CreateModSwitchProfile()

	Local $sTxtTip = ""
	Local $x = 25, $y = 45

	GUICtrlCreateGroup(GetTranslated(655,2, "Gold Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ;Gold Switch
		$g_hChkGoldSwitchMax = GUICtrlCreateCheckbox(GetTranslated(655,3, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,4, "Enable this to switch profiles when gold is above amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbGoldMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,6, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,8, "When Gold is Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxGoldAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,7, "Set the amount of Gold to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 7)

	$y += 30
		$g_hChkGoldSwitchMin = GUICtrlCreateCheckbox(GetTranslated(655,3, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,5, "Enable this to switch profiles when gold is below amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbGoldMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,6, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,9, "When Gold is Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinGoldAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,7, "Set the amount of Gold to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 7)
		GUICtrlCreatePic(@ScriptDir & "\Images\GoldStorage.jpg", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	GUICtrlCreateGroup(GetTranslated(655,10, "Elixir Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ; Elixir Switch
		$g_hChkElixirSwitchMax = GUICtrlCreateCheckbox(GetTranslated(655,3, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,11, "Enable this to switch profiles when Elixir is above amount.")
			_GUICtrlSetTip(-1, $sTxtTip)

		$g_hCmbElixirMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,6, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,14, "When Elixir is Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxElixirAmount = GUICtrlCreateInput("6000000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,13, "Set the amount of Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 7)
	$y += 30
		$g_hChkElixirSwitchMin = GUICtrlCreateCheckbox(GetTranslated(655,3, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,12, "Enable this to switch profiles when Elixir is below amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbElixirMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,6, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,15, "When Elixir is Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinElixirAmount = GUICtrlCreateInput("500000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,13, "Set the amount of Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 7)
		GUICtrlCreatePic(@ScriptDir & "\Images\ElixirStorage.jpg", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	GUICtrlCreateGroup(GetTranslated(655,16, "Dark Elixir Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ;DE Switch
		$g_hChkDESwitchMax = GUICtrlCreateCheckbox(GetTranslated(655,3, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,17, "Enable this to switch profiles when Dark Elixir is above amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbDEMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,6, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,20, "When Dark Elixir is Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxDEAmount = GUICtrlCreateInput("200000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,19, "Set the amount of Dark Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 6)
	$y += 30
		$g_hChkDESwitchMin = GUICtrlCreateCheckbox(GetTranslated(655,3, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,18, "Enable this to switch profiles when Dark Elixir is below amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbDEMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,6, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,21, "When Dark Elixir is Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinDEAmount = GUICtrlCreateInput("10000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,19, "Set the amount of Dark Elixir to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 6)
		GUICtrlCreatePic(@ScriptDir & "\Images\DEStorage.jpg", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y += 48
	GUICtrlCreateGroup(GetTranslated(655,22, "Trophy Switch Profile Conditions"), $x - 20, $y - 20, 438, 75) ; Trophy Switch
		$g_hChkTrophySwitchMax = GUICtrlCreateCheckbox(GetTranslated(655,3, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,23, "Enable this to switch profiles when Trophies are above amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbTrophyMaxProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,6, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,26, "When Trophies are Above"), $x + 145, $y, -1, -1)
		$g_hTxtMaxTrophyAmount = GUICtrlCreateInput("3000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,25, "Set the amount of Trophies to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 4)
	$y += 30
		$g_hChkTrophySwitchMin = GUICtrlCreateCheckbox(GetTranslated(655,3, "Switch To"), $x - 10, $y - 5, -1, -1)
			$sTxtTip = GetTranslated(655,24, "Enable this to switch profiles when Trophies are below amount.")
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hCmbTrophyMinProfile = GUICtrlCreateCombo("", $x + 60, $y - 5, 75, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$sTxtTip = GetTranslated(655,6, "Select which profile to be switched to when conditions met")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(GetTranslated(655,27, "When Trophies are Below"), $x + 145, $y, -1, -1)
		$g_hTxtMinTrophyAmount = GUICtrlCreateInput("1000", $x + 275, $y - 5, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$sTxtTip = GetTranslated(655,25, "Set the amount of Trophies to trigger switching Profile.")
			_GUICtrlSetTip(-1, $sTxtTip)
			GUICtrlSetLimit(-1, 4)
		GUICtrlCreatePic(@ScriptDir & "\Images\TrophyLeague.jpg", $x + 350, $y - 40, 60, 60)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
		setupProfileComboBoxswitch()
EndFunc
