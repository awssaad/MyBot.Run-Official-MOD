; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........: NguyenAnhHD, Demen
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func SaveConfig_MOD()
	; <><><> TeamVN MOD (NguyenAnhHD, Demen) <><><>
	ApplyConfig_MOD("Save")
	; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
	_Ini_Add("general", "AutoHide", $ichkAutoHide ? 1 : 0)
	_Ini_Add("general", "AutoHideDelay", $ichkAutoHideDelay)

	; Check Collector Outside (McSlither) - Added by NguyenAnhHD
	_Ini_Add("search", "DBMeetCollOutside", $ichkDBMeetCollOutside ? 1 : 0)
	_Ini_Add("search", "DBMinCollOutsidePercent", $iDBMinCollOutsidePercent)

	; Switch Profile (IceCube) - Added by NguyenAnhHD
	_Ini_Add("profiles", "chkGoldSwitchMax", $ichkGoldSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbGoldMaxProfile", $icmbGoldMaxProfile)
	_Ini_Add("profiles", "txtMaxGoldAmount", $itxtMaxGoldAmount)
	_Ini_Add("profiles", "chkGoldSwitchMin", $ichkGoldSwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbGoldMinProfile", $icmbGoldMinProfile)
	_Ini_Add("profiles", "txtMinGoldAmount", $itxtMinGoldAmount)

	_Ini_Add("profiles", "chkElixirSwitchMax", $ichkElixirSwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbElixirMaxProfile", $icmbElixirMaxProfile)
	_Ini_Add("profiles", "txtMaxElixirAmount", $itxtMaxElixirAmount)
	_Ini_Add("profiles", "chkElixirSwitchMin", $ichkElixirSwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbElixirMinProfile", $icmbElixirMinProfile)
	_Ini_Add("profiles", "txtMinElixirAmount", $itxtMinElixirAmount)

	_Ini_Add("profiles", "chkDESwitchMax", $ichkDESwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbDEMaxProfile", $icmbDEMaxProfile)
	_Ini_Add("profiles", "txtMaxDEAmount", $itxtMaxDEAmount)
	_Ini_Add("profiles", "chkDESwitchMin", $ichkDESwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbDEMinProfile", $icmbDEMinProfile)
	_Ini_Add("profiles", "txtMinDEAmount", $itxtMinDEAmount)

	_Ini_Add("profiles", "chkTrophySwitchMax", $ichkTrophySwitchMax ? 1 : 0)
	_Ini_Add("profiles", "cmbTrophyMaxProfile", $icmbTrophyMaxProfile)
	_Ini_Add("profiles", "txtMaxTrophyAmount", $itxtMaxTrophyAmount)
	_Ini_Add("profiles", "chkTrophySwitchMin", $ichkTrophySwitchMin ? 1 : 0)
	_Ini_Add("profiles", "cmbTrophyMinProfile", $icmbTrophyMinProfile)
	_Ini_Add("profiles", "txtMinTrophyAmount", $itxtMinTrophyAmount)

	; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
	_Ini_Add("DeploymentSpeed", "DB", $g_iCmbCSVSpeed[$DB])
	_Ini_Add("DeploymentSpeed", "LB", $g_iCmbCSVSpeed[$LB])

	; Smart Upgrade (Roro-Titi) - Added by NguyenAnhHD
	_Ini_Add("upgrade", "chkSmartUpgrade", $ichkSmartUpgrade ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreTH", $ichkIgnoreTH ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreKing", $ichkIgnoreKing ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreQueen", $ichkIgnoreQueen ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreWarden", $ichkIgnoreWarden ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreCC", $ichkIgnoreCC ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreLab", $ichkIgnoreLab ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreBarrack", $ichkIgnoreBarrack ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreDBarrack", $ichkIgnoreDBarrack ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreFactory", $ichkIgnoreFactory ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreDFactory", $ichkIgnoreDFactory ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreGColl", $ichkIgnoreGColl ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreEColl", $ichkIgnoreEColl ? 1 : 0)
	_Ini_Add("upgrade", "chkIgnoreDColl", $ichkIgnoreDColl ? 1 : 0)
	_Ini_Add("upgrade", "SmartMinGold", $iSmartMinGold)
	_Ini_Add("upgrade", "SmartMinElixir", $iSmartMinElixir)
	_Ini_Add("upgrade", "SmartMinDark", $iSmartMinDark)

	; Upgrade Management (MMHK) - Added by NguyenAnhHD
	_Ini_Add("upgrade", "UpdateNewUpgradesOnly", $g_ibUpdateNewUpgradesOnly ? 1 : 0)

#cs
	; SimpleTrain (Demen) - Added by Demen
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "Enable", $ichkSimpleTrain)
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "PreciseTroops", $ichkPreciseTroops)
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "ChkFillArcher", $ichkFillArcher)
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "FillArcher", $iFillArcher)
	IniWriteS($g_sProfileConfigPath, "SimpleTrain", "FillEQ", $ichkFillEQ)

	; Notify Bot Speep (Kychera) - Added By NguyenAnhHD
	IniWriteS($g_sProfileConfigPath, "notify", "AlertPBSleep", $g_bNotifyAlertBOTSleep ? 1 : 0)

	; ClanHop (Rhinoceros) - Added by NguyenAnhHD
	IniWriteS($g_sProfileConfigPath, "Others", "ClanHop", $ichkClanHop ? 1 : 0)

	; CoC Stats - Added by NguyenAnhHD
	IniWriteS($g_sProfileConfigPath, "Stats", "chkCoCStats", $ichkCoCStats ? 1 : 0)
	IniWriteS($g_sProfileConfigPath, "Stats", "txtAPIKey", $MyApiKey)
#ce
EndFunc
#cs
Func SaveConfig_SwitchAcc($SwitchAcc_Style = False)
	; <><><> SwitchAcc_Demen_Style <><><>
	ApplyConfig_SwitchAcc("Save", $SwitchAcc_Style)
	If $SwitchAcc_Style = True Then IniWriteS($profile, "SwitchAcc_Demen_Style", "SwitchType", $iSwitchAccStyle)	; 1 = DocOc Style, 2 = Demen Style

	IniWriteS($profile, "SwitchAcc_Demen_Style", "Enable", $ichkSwitchAcc ? 1 : 0)
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Pre-train", $ichkTrain ? 1 : 0)
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Total Coc Account", $icmbTotalCoCAcc)		; 1 = 1 Acc, 2 = 2 Acc, etc.
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Smart Switch", $ichkSmartSwitch ? 1 : 0)
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Force Switch", $ichkForceSwitch ? 1 : 0)
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Force Switch Search", $iForceSwitch)
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Force Stay Donate", $ichkForceStayDonate? 1 : 0)
	IniWriteS($profile, "SwitchAcc_Demen_Style", "Sleep Combo", $ichkCloseTraining)			; 0 = No Sleep, 1 = Close CoC, 2 = Close Android
	For $i = 1 to 8
		IniWriteS($profile, "SwitchAcc_Demen_Style", "MatchProfileAcc." & $i, _GUICtrlCombobox_GetCurSel($cmbAccountNo[$i-1])+1)		; 1 = Acc 1, 2 = Acc 2, etc.
		IniWriteS($profile, "SwitchAcc_Demen_Style", "ProfileType." & $i, _GUICtrlCombobox_GetCurSel($cmbProfileType[$i-1])+1)			; 1 = Active, 2 = Donate, 3 = Idle
	Next
EndFunc
#ce
