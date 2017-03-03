; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control Mod
; Description ...: Extended GUI Control Mod
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

; Auto Hide (NguyenAnhHD) - Added by NguyenAnhHD
Func chkAutoHide()
	GUICtrlSetState($g_hTxtAutohideDelay, GUICtrlRead($g_hChkAutoHide) = $GUI_CHECKED ? $GUI_ENABLE : $GUI_DISABLE)
EndFunc   ;==>chkAutoHide

; Classic Four Finger (Demen) - Added by NguyenAnhHD
Func cmbStandardDropSidesAB() ; avoid conflict between FourFinger and SmartAttack
	If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesAB) = 4 Then
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_UNCHECKED)
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_hChkSmartAttackRedAreaAB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaAB()
EndFunc   ;==>g_hCmbStandardDropSidesAB

Func cmbStandardDropSidesDB() ; avoid conflict between FourFinger and SmartAttack
	If _GUICtrlComboBox_GetCurSel($g_hCmbStandardDropSidesDB) = 4 Then
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_UNCHECKED)
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_hChkSmartAttackRedAreaDB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaDB()
EndFunc   ;==>g_hCmbStandardDropSidesDB

; CSV Deploy Speed (Roro-Titi) - Added by NguyenAnhHD
Func cmbCSVSpeed()

	Switch _GUICtrlComboBox_GetCurSel($g_hCmbCSVSpeed[$g_iMatchMode])
		Case 0
			$g_hDivider = 0.5
		Case 1
			$g_hDivider = 0.75
		Case 2
			$g_hDivider = 1
		Case 3
			$g_hDivider = 1.25
		Case 4
			$g_hDivider = 1.5
		Case 5
			$g_hDivider = 2
		Case 6
			$g_hDivider = 3
	EndSwitch

EndFunc   ;==>cmbCSVSpeed

; Attack Now Button MR.ViPeR) - Added by NguyenAnhHD
Func AttackNowLB()
	SetLog("Begin Live Base Attack TEST")
	$g_iMatchMode = $LB			; Select Live Base As Attack Type
	cmbCSVSpeed()
	$g_aiAttackAlgorithm[$LB] = 1			; Select Scripted Attack
	$g_sAttackScrScriptName[$LB] = GuiCtrlRead($g_hCmbScriptNameAB)		; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$g_iMatchMode = 1			; Select Live Base As Attack Type
	$g_bRunState = True

	ForceCaptureRegion()
	_CaptureRegion2()

	If CheckZoomOut("VillageSearch", True, False) = False Then
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($iDelayPrepareSearch3) Then Return ; wait 500 ms
			ForceCaptureRegion()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, True)
		Until $bMeasured = True Or $i >= 2
		If $bMeasured = False Then Return ; exit func
	EndIf

	PrepareAttack($g_iMatchMode)			; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack()			; Fire xD
	SetLog("End Live Base Attack TEST")
EndFunc   ;==>AttackNowLB

Func AttackNowDB()
	SetLog("Begin Dead Base Attack TEST")
	$g_iMatchMode = $DB			; Select Dead Base As Attack Type
	cmbCSVSpeed()
	$g_aiAttackAlgorithm[$DB] = 1			; Select Scripted Attack
	$g_sAttackScrScriptName[$DB] = GuiCtrlRead($g_hCmbScriptNameDB)		; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$g_iMatchMode = 0			; Select Dead Base As Attack Type
	$g_bRunState = True
	ForceCaptureRegion()
	_CaptureRegion2()

	If CheckZoomOut("VillageSearch", True, False) = False Then
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($iDelayPrepareSearch3) Then Return ; wait 500 ms
			ForceCaptureRegion()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, True)
		Until $bMeasured = True Or $i >= 2
		If $bMeasured = False Then Return ; exit func
	EndIf

	PrepareAttack($g_iMatchMode)			; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack()			; Fire xD
	SetLog("End Dead Base Attack TEST")
EndFunc   ;==>AttackNowLB

; Switch Profiles (IceCube) - Added by NguyenAnhHD
Func btnRecycle()
	FileDelete($g_sProfileConfigPath)
	saveConfig()
	SetLog("Profile " & $g_sProfileCurrentName & " was recycled with success", $COLOR_GREEN)
	SetLog("All unused settings were removed", $COLOR_GREEN)
EndFunc   ;==>btnRecycle

Func setupProfileComboBoxswitch()
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbGoldMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbGoldMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbGoldMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbGoldMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbElixirMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbElixirMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbElixirMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbElixirMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbDEMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbDEMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbDEMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbDEMinProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbTrophyMaxProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbTrophyMaxProfile, $profileString, "<No Profiles>")
	; Clear the combo box current data in case profiles were deleted
	GUICtrlSetData($g_hCmbTrophyMinProfile, "", "")
	; Set the new data of available profiles
	GUICtrlSetData($g_hCmbTrophyMinProfile, $profileString, "<No Profiles>")
EndFunc   ;==>setupProfileComboBoxswitch

; Switch Account (Demen) - Added by Demen
Func btnUpdateProfile()

	SaveConfig_SwitchAcc()
	ReadConfig_SwitchAcc()
	ApplyConfig_SwitchAcc("Read")

	$ProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
	$nTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)

	For $i = 0 To 7
		If $i <= $nTotalProfile - 1 Then
			GUICtrlSetData($lblProfileName[$i], $ProfileList[$i+1])
			For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
				GUICtrlSetState($j, $GUI_SHOW)
			Next

			; Update stats GUI
			If $i <= 3 Then
				For $j = $aStartHide[$i] To $aEndHide[$i]
				   GUICtrlSetState($j, $GUI_SHOW)
				Next
				Switch $aProfileType[$i]
					Case 1
						GUICtrlSetData($grpVillageAcc[$i], "Village: " & $ProfileList[$i+1] & " (Active)")
					Case 2
						GUICtrlSetData($grpVillageAcc[$i], "Village: " & $ProfileList[$i+1] & " (Donate)")
						For $j = $aSecondHide[$i] To $aEndHide[$i]
						  GUICtrlSetState($j, $GUI_HIDE)
						Next
					Case Else
						GUICtrlSetData($grpVillageAcc[$i], "Village: " & $ProfileList[$i+1] & " (Idle)")
						For $j = $aSecondHide[$i] To $aEndHide[$i]
							GUICtrlSetState($j, $GUI_HIDE)
						Next
				EndSwitch
			EndIf
		Else
			GUICtrlSetData($lblProfileName[$i], "")
			_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], -1)
			_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], -1)
			For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
				GUICtrlSetState($j, $GUI_HIDE)
			Next

			; Update stats GUI
			If $i <= 3 Then
				For $j = $aStartHide[$i] To $aEndHide[$i]
				   GUICtrlSetState($j, $GUI_HIDE)
				Next
			EndIf

		EndIf
	Next

EndFunc

Func btnClearProfile()
	For $i = 0 To 7
		_GUICtrlComboBox_SetCurSel($cmbAccountNo[$i], -1)
		_GUICtrlComboBox_SetCurSel($cmbProfileType[$i], -1)
	Next
EndFunc

Func chkSwitchAcc()
	If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then
		If _GUICtrlComboBox_GetCount($g_hCmbProfile) <= 1 Then
			GUICtrlSetState($chkSwitchAcc, $GUI_UNCHECKED)
			MsgBox($MB_OK, GetTranslated(655,88, "SwitchAcc Mode"), GetTranslated(655,89, "Cannot enable SwitchAcc Mode") & @CRLF & GetTranslated(655,90, "You have only ") & _GUICtrlComboBox_GetCount($g_hCmbProfile) & " Profile", 30, $g_hGUI_BOT)
		EndIf
	EndIf
EndFunc   ;==>chkSwitchAcc

Func radNormalSwitch()
	If GUICtrlRead($radNormalSwitch) = $GUI_CHECKED Then
		GUICtrlSetState($chkUseTrainingClose, $GUI_UNCHECKED)
		GUICtrlSetState($chkUseTrainingClose, $GUI_DISABLE)
		For $i = $radCloseCoC To $radCloseAndroid
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	Else
		GUICtrlSetState($chkUseTrainingClose, $GUI_ENABLE)
		For $i = $radCloseCoC To $radCloseAndroid
			GUICtrlSetState($i, $GUI_ENABLE)
		Next
	EndIf
EndFunc   ;==>radNormalSwitch  - Normal Switch is not on the same boat with Sleep Combo


Func cmbMatchProfileAcc1()
	MatchProfileAcc(0)
EndFunc
Func cmbMatchProfileAcc2()
	MatchProfileAcc(1)
EndFunc
Func cmbMatchProfileAcc3()
	MatchProfileAcc(2)
EndFunc
Func cmbMatchProfileAcc4()
	MatchProfileAcc(3)
EndFunc
Func cmbMatchProfileAcc5()
	MatchProfileAcc(4)
EndFunc
Func cmbMatchProfileAcc6()
	MatchProfileAcc(5)
EndFunc
Func cmbMatchProfileAcc7()
	MatchProfileAcc(6)
EndFunc
Func cmbMatchProfileAcc8()
	MatchProfileAcc(7)
EndFunc


Func MatchProfileAcc($Num)

    If _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) > _GUICtrlComboBox_GetCurSel($cmbTotalAccount) Then
	   MsgBox($MB_OK, GetTranslated(655,88, "SwitchAcc Mode"), GetTranslated(655,91, "Account [") & _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) & GetTranslated(655,92, "] exceeds Total Account declared") ,30, $g_hGUI_BOT)
	   _GUICtrlComboBox_SetCurSel($cmbAccountNo[$Num], -1)
	   _GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], -1)
	   btnUpdateProfile()
	EndIf

	Local $AccSelected = _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num])
	If $AccSelected >= 0 Then
		For $i = 0 to 7
			If $i = $Num Then ContinueLoop
			If $AccSelected = _GUICtrlComboBox_GetCurSel($cmbAccountNo[$i]) Then
				MsgBox($MB_OK, GetTranslated(655,88, "SwitchAcc Mode"), GetTranslated(655,91, "Account [") & $AccSelected+1 & GetTranslated(655,93, "] has been assigned to Profile [") & $i+1 & "]" ,30, $g_hGUI_BOT)
				_GUICtrlComboBox_SetCurSel($cmbAccountNo[$Num], -1)
				_GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], -1)
				btnUpdateProfile()
				ExitLoop
			EndIf
		Next

		If _GUICtrlComboBox_GetCurSel($cmbAccountNo[$Num]) >= 0 Then
			_GUICtrlComboBox_SetCurSel($cmbProfileType[$Num], 0)
			btnUpdateProfile()
		EndIf
	EndIf

EndFunc ;===> MatchProfileAcc

Func btnLocateAcc()

	Local $AccNo = _GUICtrlComboBox_GetCurSel($cmbLocateAcc) + 1
	Local $stext, $MsgBox

	Local $wasRunState = $g_bRunState
	$g_bRunState = True

	SetLog(GetTranslated(655,94, "Locating Y-Coordinate of CoC Account No. ") & $AccNo & GetTranslated(655,95, ", please wait..."), $COLOR_BLUE)
	WinGetAndroidHandle()

	Zoomout()

	Click(820, 585, 1, 0, "Click Setting")      ;Click setting
	Sleep(500)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 600)
		$stext = GetTranslated(655,96, "Click Connect/Disconnect on emulator to show the accout list") & @CRLF & @CRLF & _
				 GetTranslated(655,97, "Click OK then click on your Account No. ") & $AccNo & @CRLF & @CRLF & _
				 GetTranslated(655,98, "Do not move mouse quickly after clicking location") & @CRLF & @CRLF
		$MsgBox = _ExtMsgBox(0, GetTranslated(655,99, "Ok|Cancel"), GetTranslated(655,100, "Locate CoC Account No. ") & $AccNo, $stext, 60, $g_hFrmBot)
		If $MsgBox = 1 Then
			WinGetAndroidHandle()
			Local $aPos = FindPos()
			$aLocateAccConfig[$AccNo-1] = Int($aPos[1])
			ClickP($aAway, 1, 0, "#0379")
		Else
			SetLog(GetTranslated(655,101, "Locate CoC Account Cancelled"), $COLOR_BLUE)
			ClickP($aAway, 1, 0, "#0382")
			Return
		EndIf
		SetLog(GetTranslated(655,102, "Locate CoC Account Success: ") & "(383, " & $aLocateAccConfig[$AccNo-1] & ")", $COLOR_GREEN)

		ExitLoop
	WEnd
	Clickp($aAway, 2, 0, "#0207")
	IniWriteS($profile, "Switch Account", "AccLocation." & $AccNo, $aLocateAccConfig[$AccNo-1])
    $g_bRunState = $wasRunState
	AndroidShield("LocateAcc") ; Update shield status due to manual $RunState

EndFunc   ;==>LocateAcc

Func btnClearAccLocation()
	For $i = 1 to 8
		$aLocateAccConfig[$i-1] = -1
		$aAccPosY[$i-1] = -1
	Next
	Setlog("Position of all accounts cleared")
	SaveConfig_SwitchAcc()
EndFunc

; QuickTrainCombo (Demen) - Added by Demen
Func chkQuickTrainCombo()
	If GUICtrlRead($g_ahChkArmy[0]) = $GUI_UNCHECKED And GUICtrlRead($g_ahChkArmy[1]) = $GUI_UNCHECKED And GUICtrlRead($g_ahChkArmy[2]) = $GUI_UNCHECKED Then
		GUICtrlSetState($g_ahChkArmy[0],$GUI_CHECKED)
		ToolTip("QuickTrainCombo: " & @CRLF & "At least 1 Army Check is required! Default Army1.")
		Sleep(2000)
		ToolTip('')
	EndIf
EndFunc	;==> QuickTrainCombo

; SimpleTrain (Demen) - Added by Demen
Func chkSimpleTrain()
	If GUICtrlRead($chkSimpleTrain) = $GUI_CHECKED Then
		_GUI_Value_STATE("ENABLE", $chkFillArcher & "#" & $chkFillEQ)
	Else
		_GUI_Value_STATE("DISABLE", $chkFillArcher & "#" & $chkFillEQ)
		_GUI_Value_STATE("UNCHECKED", $chkFillArcher & "#" & $chkFillEQ)
	EndIf
	chkFillArcher()
EndFunc   ;==>chkSimpleTrain

Func chkFillArcher()
	If GUICtrlRead($chkFillArcher) = $GUI_CHECKED Then
		_GUI_Value_STATE("ENABLE", $txtFillArcher)
	Else
		_GUI_Value_STATE("DISABLE", $txtFillArcher)
	EndIf
EndFunc   ;==>chkFillArcher

