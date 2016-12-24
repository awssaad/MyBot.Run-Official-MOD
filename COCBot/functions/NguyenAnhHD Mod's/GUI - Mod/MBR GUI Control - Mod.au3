; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Control - Mod
; Description ...: Extended GUI Control for Mod
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; GUI Control for SwitchAcc Mode - DEMEN
Func radProfileType()
	If GUICtrlRead($radIdleProfile) = $GUI_CHECKED Then
		_GUICtrlComboBox_SetCurSel($cmbMatchProfileAcc, 0)
	EndIf
	btnUpdateProfile()
EndFunc   ;==>radProfileType

Func cmbMatchProfileAcc()

	If _GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc) = 0 Then
		GUICtrlSetState($radIdleProfile, $GUI_CHECKED)
	EndIf

	If _GUICtrlComboBox_GetCurSel($cmbTotalAccount) <> 0 And _GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc) > _GUICtrlComboBox_GetCurSel($cmbTotalAccount) Then
		MsgBox($MB_OK, "SwitchAcc Mode", "Account [" & _GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc) & "] exceeds Total Account declared" ,30, $hGUI_BOT)
		_GUICtrlComboBox_SetCurSel($cmbMatchProfileAcc, 0)
		GUICtrlSetState($radIdleProfile, $GUI_CHECKED)
		btnUpdateProfile()
	EndIf

	If _GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc) <> 0 And _ArraySearch($aMatchProfileAcc,_GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc)) <> -1 Then
		MsgBox($MB_OK, "SwitchAcc Mode", "Account [" & _GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc) & "] has been assigned to Profile [" & _ArraySearch($aMatchProfileAcc,_GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc)) + 1 & "]" ,30, $hGUI_BOT)
		_GUICtrlComboBox_SetCurSel($cmbMatchProfileAcc, 0)
		GUICtrlSetState($radIdleProfile, $GUI_CHECKED)
		btnUpdateProfile()
	EndIf

	If _GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc) <> 0 And UBound(_ArrayFindAll($aMatchProfileAcc,_GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc))) > 1 Then
		MsgBox($MB_OK, "SwitchAcc Mode", "Account [" & _GUICtrlComboBox_GetCurSel($cmbMatchProfileAcc) & "] has been assigned to another profile" ,30, $hGUI_BOT)
		_GUICtrlComboBox_SetCurSel($cmbMatchProfileAcc, 0)
		GUICtrlSetState($radIdleProfile, $GUI_CHECKED)
		btnUpdateProfile()
	EndIf

EndFunc   ;==>cmbMatchProfileAcc

Func btnUpdateProfile()

	saveConfig()
	setupProfile()
	readConfig()
	applyConfig()
	saveConfig()

	$ProfileList = _GUICtrlComboBox_GetListArray($cmbProfile)
	$nTotalProfile = _GUICtrlComboBox_GetCount($cmbProfile)

	For $i = 0 To 7
		If $i <= $nTotalProfile - 1 Then
			$aconfig[$i] = $sProfilePath & "\" & $ProfileList[$i + 1] & "\config.ini"
			$aProfileType[$i] = IniRead($aconfig[$i], "Switch Account", "Profile Type", 3)
			$aMatchProfileAcc[$i] = IniRead($aconfig[$i], "Switch Account", "Match Profile Acc", "")

			If $i <= 3 Then
				For $j = $grpVillageAcc[$i] To $lblHourlyStatsDarkAcc[$i]
					GUICtrlSetState($j, $GUI_SHOW)
				Next
			EndIf

			Switch $aProfileType[$i]
			Case 1
				GUICtrlSetData($lblProfileList[$i],"Profile [" & $i+1 & "]: " & $ProfileList[$i+1] & " - Acc [" & $aMatchProfileAcc[$i] & "] - Active")
				GUICtrlSetState($lblProfileList[$i], $GUI_ENABLE)
				If $i <= 3 Then GUICtrlSetData($grpVillageAcc[$i], "Village: " & $ProfileList[$i+1] & " (Active)")

			Case 2
				GUICtrlSetData($lblProfileList[$i],"Profile [" & $i+1 & "]: " & $ProfileList[$i+1] & " - Acc [" & $aMatchProfileAcc[$i] & "] - Donate")
				GUICtrlSetState($lblProfileList[$i], $GUI_ENABLE)
				If $i <= 3 Then
					GUICtrlSetData($grpVillageAcc[$i], "Village: " & $ProfileList[$i+1] & " (Donate)")
					For $j = $aStartHide[$i] To $lblHourlyStatsDarkAcc[$i]
						GUICtrlSetState($j, $GUI_HIDE)
					Next
				EndIf
			Case 3
				GUICtrlSetData($lblProfileList[$i],"Profile [" & $i+1 & "]: " & $ProfileList[$i+1] & " - Acc [" & $aMatchProfileAcc[$i] & "] - Idle")
				GUICtrlSetState($lblProfileList[$i], $GUI_DISABLE)
				If $i <= 3 Then
					GUICtrlSetData($grpVillageAcc[$i], "Village: " & $ProfileList[$i+1] & " (Idle)")
					For $j = $aStartHide[$i] To $lblHourlyStatsDarkAcc[$i]
						GUICtrlSetState($j, $GUI_HIDE)
					Next
				EndIf
			EndSwitch

		Else
			GUICtrlSetData($lblProfileList[$i], "")
			If $i <= 3 Then
				For $j = $grpVillageAcc[$i] to $lblHourlyStatsDarkAcc[$i]
					GUICtrlSetState($j, $GUI_HIDE)
				Next
			EndIf
		EndIf
	Next

EndFunc

Func chkSwitchAcc()
	If GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED Then
		If _GUICtrlComboBox_GetCount($cmbProfile) <= 1 Then
			GUICtrlSetState($chkSwitchAcc, $GUI_UNCHECKED)
			MsgBox($MB_OK, "SwitchAcc Mode", "Cannot enable SwitchAcc Mode" & @CRLF & "You have only " & _GUICtrlComboBox_GetCount($cmbProfile) & " Profile set", 30, $hGUI_BOT)
		Else
			For $i = $chkTrain To $radNormalSwitch
				GUICtrlSetState($i, $GUI_ENABLE)
			Next
			If GUICtrlRead($radNormalSwitch) = $GUI_CHECKED And GUICtrlRead($chkUseTrainingClose) = $GUI_CHECKED Then
				GUICtrlSetState($radSmartSwitch, $GUI_CHECKED)
			EndIf
		EndIf
	Else
		For $i = $chkTrain To $radNormalSwitch
			GUICtrlSetState($i, $GUI_DISABLE)
		Next
	EndIf
EndFunc   ;==>chkSwitchAcc

Func chkTrain()
	If GUICtrlRead($chkTrain) = $GUI_CHECKED Then
		$ichkTrain = 1
	Else
		$ichkTrain = 0
	EndIf
EndFunc

Func radNormalSwitch()
	If GUICtrlRead($chkUseTrainingClose) = $GUI_CHECKED Then
		GUICtrlSetState($radSmartSwitch, $GUI_CHECKED)
		MsgBox($MB_OK, "SwitchAcc Mode", "Cannot enable Sleep Mode together with Normal Switch Mode", 30, $hGUI_BOT)
	EndIf
EndFunc   ;==>radNormalSwitch  - Normal Switch is not on the same boat with Sleep Combo

Func chkUseTrainingClose()
	If GUICtrlRead($chkUseTrainingClose) = $GUI_CHECKED And GUICtrlRead($chkSwitchAcc) = $GUI_CHECKED And GUICtrlRead($radNormalSwitch) = $GUI_CHECKED Then
		GUICtrlSetState($chkUseTrainingClose, $GUI_UNCHECKED)
		MsgBox($MB_OK, "SwitchAcc Mode", "Cannot enable Sleep Mode together with Normal Switch Mode", 30, $hGUI_BOT)
	EndIf
EndFunc   ;==>chkUseTrainingClose


Func btnLocateAcc1()
	LocateAcc(1)
EndFunc   ;==>btnLocateAcc1
Func btnLocateAcc2()
	LocateAcc(2)
EndFunc   ;==>btnLocateAcc2
Func btnLocateAcc3()
	LocateAcc(3)
EndFunc   ;==>btnLocateAcc3
Func btnLocateAcc4()
	LocateAcc(4)
EndFunc   ;==>btnLocateAcc4
Func btnLocateAcc5()
	LocateAcc(5)
EndFunc   ;==>btnLocateAcc5
Func btnLocateAcc6()
	LocateAcc(6)
EndFunc   ;==>btnLocateAcc6

Func LocateAcc($AccNo)
	Local $stext, $MsgBox, $sErrorText = ""

	SetLog("Locating Y-Coordinate of CoC Account No. " & $AccNo & ", please wait...", $COLOR_BLUE)
	WinGetAndroidHandle()

	Zoomout()

	Click(820, 585, 1, 0, "Click Setting")      ;Click setting
	Sleep(500)

	While 1
		_ExtMsgBoxSet(1 + 64, $SS_CENTER, 0x004080, 0xFFFF00, 12, "Comic Sans MS", 600)
		$stext = $sErrorText & @CRLF & "Click Connect/Disconnect to show the list of accounts" & @CRLF & "Click OK then click on your Account No. " & $AccNo & @CRLF & @CRLF & _
				GetTranslated(655,84, "Do not move mouse quickly after clicking location") & @CRLF & @CRLF & GetTranslated(655,85, "Please note that you have only 1 chance to click") & @CRLF
		$MsgBox = _ExtMsgBox(0, GetTranslated(655,86, "Ok|Cancel"), GetTranslated(655,87, "Locate CoC Account No. ") & $AccNo, $stext, 30, $frmBot)
		If $MsgBox = 1 Then
			WinGetAndroidHandle()
			Local $aPos = FindPos()
			$aAccPosY[$AccNo-1] = Int($aPos[1])
			ClickP($aAway, 1, 0, "#0379")
		Else
			SetLog("Locate CoC Account Cancelled", $COLOR_BLUE)
			ClickP($aAway, 1, 0, "#0382")
			Return
		EndIf
		SetLog("Locate CoC Account Success: " & "(383, " & $aAccPosY[$AccNo-1] & ")", $COLOR_GREEN)

		ExitLoop
	WEnd
	Clickp($aAway, 2, 0, "#0207")
	saveConfig()

EndFunc   ;==>LocateAcc

Func btnClearAccLocation()
	For $i = 1 to 6
		$aAccPosY[$i-1] = -1
	Next
	Setlog("Position of all accounts cleared")
	saveConfig()
EndFunc
; ============= SwitchAcc Mode ============= - DEMEN


; GUI Control for Classic FourFinger Attack - DEMEN
Func cmbDeployAB() ; avoid conflict between FourFinger and SmartAttack - DEMEN
	If _GUICtrlComboBox_GetCurSel($cmbDeployAB) = 4 Or _GUICtrlComboBox_GetCurSel($cmbDeployAB) = 5 Then
		GUICtrlSetState($chkSmartAttackRedAreaAB, $GUI_UNCHECKED)
		GUICtrlSetState($chkSmartAttackRedAreaAB, $GUI_DISABLE)
	Else
		GUICtrlSetState($chkSmartAttackRedAreaAB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaAB()
EndFunc   ;==>cmbDeployAB

Func cmbDeployDB() ; avoid conflict between FourFinger and SmartAttack - DEMEN
	If _GUICtrlComboBox_GetCurSel($cmbDeployDB) = 4 Or _GUICtrlComboBox_GetCurSel($cmbDeployDB) = 5 Then
		GUICtrlSetState($chkSmartAttackRedAreaDB, $GUI_UNCHECKED)
		GUICtrlSetState($chkSmartAttackRedAreaDB, $GUI_DISABLE)
	Else
		GUICtrlSetState($chkSmartAttackRedAreaDB, $GUI_ENABLE)
	EndIf
	chkSmartAttackRedAreaDB()
EndFunc   ;==>cmbDeployDB
; ============= Classic FourFinger Attack ============ - DEMEN

; GUI Control for Multi Finger Attack
Func Bridge()
	cmbDeployDB()
	cmbDBMultiFinger()
EndFunc   ;==>Bridge
; GUI Control for Multi Finger Attack

; Auto Hide
Func chkAutoHide()
	If GUICtrlRead($chkAutoHide) = $GUI_CHECKED Then
		GUICtrlSetState($txtAutohideDelay, $GUI_ENABLE)
	Else
		GUICtrlSetState($txtAutohideDelay, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkAutoHide

; CSV Deployment Speed Mod
Func cmbCSVSpeed()

	Switch _GUICtrlComboBox_GetCurSel($cmbCSVSpeed[$iMatchMode])
		Case 0
			$Divider = 0.5
		Case 1
			$Divider = 0.75
		Case 2
			$Divider = 1
		Case 3
			$Divider = 1.25
		Case 4
			$Divider = 1.5
		Case 5
			$Divider = 2
		Case 6
			$Divider = 3
	EndSwitch

EndFunc   ;==>cmbCSVSpeed

Func AttackNowLB()
	Setlog("Begin Live Base Attack TEST")
	$iMatchMode = $LB ; Select Live Base As Attack Type
	$iAtkAlgorithm[$LB] = 1 ; Select Scripted Attack
	$scmbABScriptName = GUICtrlRead($cmbScriptNameAB) ; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$iMatchMode = 1 ; Select Live Base As Attack Type
	$RunState = True
	PrepareAttack($iMatchMode) ; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack() ; Fire xD
	Setlog("End Live Base Attack TEST")
EndFunc   ;==>AttackNowLB

Func AttackNowDB()
	Setlog("Begin Dead Base Attack TEST")
	$iMatchMode = $DB ; Select Dead Base As Attack Type
	$iAtkAlgorithm[$DB] = 1 ; Select Scripted Attack
	$scmbABScriptName = GUICtrlRead($cmbScriptNameDB) ; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$iMatchMode = 0 ; Select Dead Base As Attack Type
	$RunState = True
	PrepareAttack($iMatchMode) ; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack() ; Fire xD
	Setlog("End Dead Base Attack TEST")
EndFunc   ;==>AttackNowDB

; Change Android Shield Color
Func btnColorShield()
	$sSelectedColor = _ChooseColor(2,0xFFFFFF,2,$frmBot)
	If $sSelectedColor <> -1 Then
	$sSelectedColor = StringTrimLeft($sSelectedColor,2)
	$AndroidShieldColor = Dec($sSelectedColor)
	SetLog("Shield color successfully chosen! Will be used now", $COLOR_INFO)
	Else
	SetLog("Shield color selection stopped, keeping the old one!",$COLOR_INFO)
	EndIf

EndFunc

Func sldrTransparancyShield()
	$ReadTransparancyShield = GUICtrlRead($sldrTransparancyShield)
	$AndroidShieldTransparency = Int($ReadTransparancyShield)

EndFunc

Func btnColorIdleShield()
	$sSelectedColor = _ChooseColor(2,0xFFFFFF,2,$frmBot)
	If $sSelectedColor <> -1 Then
	$sSelectedColor = StringTrimLeft($sSelectedColor,2)
	$AndroidInactiveColor = Dec($sSelectedColor)
	SetLog("Idle Shield color successfully chosen! Will be used now", $COLOR_INFO)
	Else
	SetLog("Idle Shield color selection stopped, keeping the old one!",$COLOR_INFO)
	EndIf

EndFunc

Func sldrTransparancyIdleShield()
	$ReadTransparancyIdle = GUICtrlRead($sldrTransparancyIdleShield)
	$AndroidInactiveTransparency = Int($ReadTransparancyIdle)

EndFunc
#cs
; Treasury Collect
Func chkCollectTresory()
	If GUICtrlRead($chkCollectTresory) = $GUI_CHECKED Then
		For $i = $leurequisertarienTresor To $btnResetDE
			GUICtrlSetState($i, $GUI_SHOW)
		Next
		If GUICtrlRead($chkCollectTresoryGold) = $GUI_UNCHECKED Then
			GUICtrlSetState($btnResetOR, $GUI_DISABLE)
			GUICtrlSetState($btnResetEL, $GUI_DISABLE)
			GUICtrlSetState($btnResetDE, $GUI_DISABLE)
		EndIf
		$ichkCollectTresory = 1
	Else
		For $i = $leurequisertarienTresor To $btnResetDE
			GUICtrlSetState($i, $GUI_HIDE)
		Next
		$ichkCollectTresory = 0
	EndIf
EndFunc   ;==>chkCollectTresory

Func chkCollectTresoryGold()
	If GUICtrlRead($chkCollectTresoryGold) = $GUI_CHECKED And GUICtrlRead($chkCollectTresory) = $GUI_CHECKED Then
		GUICtrlSetState($txtTreasuryGold, $GUI_ENABLE)
		GUICtrlSetState($btnResetOR, $GUI_ENABLE)
	ElseIf GUICtrlRead($chkCollectTresoryGold) = $GUI_CHECKED And GUICtrlRead($chkCollectTresory) = $GUI_UNCHECKED Then
		GUICtrlSetState($txtTreasuryGold, $GUI_DISABLE)
		GUICtrlSetState($btnResetOR, $GUI_DISABLE)
	ElseIf GUICtrlRead($chkCollectTresoryGold) = $GUI_UNCHECKED And GUICtrlRead($chkCollectTresory) = $GUI_CHECKED Then
		GUICtrlSetState($txtTreasuryGold, $GUI_DISABLE)
		GUICtrlSetState($btnResetOR, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkCollectTresoryGold

Func ResetOr()
	Global $ResetOR = 0
	GUICtrlSetData($txtTreasuryGold, $ResetOR)
	$itxtTreasuryGold = GUICtrlRead($txtTreasuryGold)
EndFunc   ;==>ResetOr

Func chkCollectTresoryElixir()
	If GUICtrlRead($chkCollectTresoryElixir) = $GUI_CHECKED And GUICtrlRead($chkCollectTresory) = $GUI_CHECKED Then
		GUICtrlSetState($txtTreasuryElixir, $GUI_ENABLE)
		GUICtrlSetState($btnResetEL, $GUI_ENABLE)
	ElseIf GUICtrlRead($chkCollectTresoryElixir) = $GUI_CHECKED And GUICtrlRead($chkCollectTresory) = $GUI_UNCHECKED Then
		GUICtrlSetState($txtTreasuryElixir, $GUI_DISABLE)
		GUICtrlSetState($btnResetEL, $GUI_DISABLE)
	ElseIf GUICtrlRead($chkCollectTresoryElixir) = $GUI_UNCHECKED And GUICtrlRead($chkCollectTresory) = $GUI_CHECKED Then
		GUICtrlSetState($txtTreasuryElixir, $GUI_DISABLE)
		GUICtrlSetState($btnResetEL, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkCollectTresoryElixir

Func ResetEL()
	Global $ResetEL = 0
	GUICtrlSetData($txtTreasuryElixir, $ResetEL)
	$itxtTreasuryElixir = GUICtrlRead($txtTreasuryElixir)
EndFunc   ;==>ResetEL

Func chkCollectTresoryDark()
	If GUICtrlRead($chkCollectTresoryDark) = $GUI_CHECKED And GUICtrlRead($chkCollectTresory) = $GUI_CHECKED Then
		GUICtrlSetState($txtTreasuryDark, $GUI_ENABLE)
		GUICtrlSetState($btnResetDE, $GUI_ENABLE)
	ElseIf GUICtrlRead($chkCollectTresoryDark) = $GUI_CHECKED And GUICtrlRead($chkCollectTresory) = $GUI_UNCHECKED Then
		GUICtrlSetState($txtTreasuryDark, $GUI_DISABLE)
		GUICtrlSetState($btnResetDE, $GUI_DISABLE)
	ElseIf GUICtrlRead($chkCollectTresoryDark) = $GUI_UNCHECKED And GUICtrlRead($chkCollectTresory) = $GUI_CHECKED Then
		GUICtrlSetState($txtTreasuryDark, $GUI_DISABLE)
		GUICtrlSetState($btnResetDE, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkCollectTresoryDark

Func ResetDE()
	Global $ResetDE = 0
	GUICtrlSetData($txtTreasuryDark, $ResetDE)
	$itxtTreasuryDark = GUICtrlRead($txtTreasuryDark)
EndFunc   ;==>ResetDE

Func randomSleep($SleepTime, $Range = 0)

	If $RunState = False Then Return
	If $Range = 0 Then $Range = Round($SleepTime / 5)
	$SleepTimeF = Random($SleepTime - $Range, $SleepTime + $Range, 1)
	If $DebugClick = 1 Then Setlog("Default sleep : " & $SleepTime & " - Random sleep : " & $SleepTimeF, $COLOR_ORANGE)
	If _Sleep($SleepTimeF) Then Return

EndFunc   ;==>randomSleep

Func QuickMIS($ValueReturned, $directory, $Left = 0, $Top = 0, $Right = $GAME_WIDTH, $Bottom = $GAME_HEIGHT, $Debug = False)

	If ($ValueReturned <> "BC1") And ($ValueReturned <> "CX") And ($ValueReturned <> "N1") And ($ValueReturned <> "NX") And ($ValueReturned <> "Q1") And ($ValueReturned <> "QX") Then
		SetLog("Error of parameters settings during QuickMIS call for MultiSearch...", $COLOR_RED)
		Return
	EndIf

	Sleep(1500)

	_CaptureRegion2($Left, $Top, $Right, $Bottom)
	$Res = DllCall($hImgLib, "str", "SearchMultipleTilesBetweenLevels", "handle", $hHBitmap2, "str", $directory, "str", "FV", "Int", 0, "str", "FV", "Int", 0, "Int", 1000)

	If IsArray($Res) Then
		If $Debug Then _ArrayDisplay($Res)
		If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $Res[0], $COLOR_PURPLE)

		If $Res[0] = "" Or $Res[0] = "0" Then
			If $DebugSetlog Then SetLog("No Button found")
			Switch $ValueReturned
				Case "BC1"
					Return False
				Case "CX"
					Return "-1"
				Case "N1"
					Return "none"
				Case "NX"
					Return "none"
				Case "Q1"
					Return 0
				Case "QX"
					Return 0
			EndSwitch

		ElseIf StringInStr($Res[0], "-1") <> 0 Then
			SetLog("DLL Error", $COLOR_RED)

		Else
			Switch $ValueReturned

				Case "BC1" ; coordinates of first/one image found + boolean value

					$Result = ""
					$KeyValue = StringSplit($Res[0], "|", $STR_NOCOUNT)
					For $i = 0 To UBound($KeyValue) - 1
						$DLLRes = DllCall($hImgLib, "str", "GetProperty", "str", $KeyValue[$i], "str", "objectpoints")
						$Result &= $DLLRes[0] & "|"
					Next
					If StringRight($Result, 1) = "|" Then $Result = StringLeft($Result, (StringLen($Result) - 1))
					$CoordsInArray = StringSplit($Result, ",", $STR_NOCOUNT)
					$QuickMISX = $CoordsInArray[0]
					$QuickMISY = $CoordsInArray[1]
					Return True

				Case "CX" ; coordinates of each image found - eg: $Array[0] = [X1, Y1] ; $Array[1] = [X2, Y2]

					$Result = ""
					$KeyValue = StringSplit($Res[0], "|", $STR_NOCOUNT)
					For $i = 0 To UBound($KeyValue) - 1
						$DLLRes = DllCall($hImgLib, "str", "GetProperty", "str", $KeyValue[$i], "str", "objectpoints")
						$Result &= $DLLRes[0] & "|"
					Next
					If StringRight($Result, 1) = "|" Then $Result = StringLeft($Result, (StringLen($Result) - 1))
					$CoordsInArray = StringSplit($Result, "|", $STR_NOCOUNT)
					Return $CoordsInArray


				Case "N1" ; name of first file found

					$MultiImageSearchResult = StringSplit($Res[0], "|")
					$FilenameFound = StringSplit($MultiImageSearchResult[1], "_")
					Return $FilenameFound[1]

				Case "NX" ; names of all files found

					$AllFilenamesFound = ""
					$MultiImageSearchResult = StringSplit($Res[0], "|")
					For $i = 1 To $MultiImageSearchResult[0]
						$FilenameFound = StringSplit($MultiImageSearchResult[$i], "_")
						$AllFilenamesFound &= $FilenameFound[1] & "|"
					Next
					If StringRight($AllFilenamesFound, 1) = "|" Then $AllFilenamesFound = StringLeft($AllFilenamesFound, (StringLen($AllFilenamesFound) - 1))
					Return $AllFilenamesFound

				Case "Q1" ; quantity of first/one tiles found

					$Result = ""
					$KeyValue = StringSplit($Res[0], "|", $STR_NOCOUNT)
					For $i = 0 To UBound($KeyValue) - 1
						$DLLRes = DllCall($hImgLib, "str", "GetProperty", "str", $KeyValue[$i], "str", "totalobjects")
						$Result &= $DLLRes[0] & "|"
					Next
					If StringRight($Result, 1) = "|" Then $Result = StringLeft($Result, (StringLen($Result) - 1))
					$QuantityInArray = StringSplit($Result, "|", $STR_NOCOUNT)
					Return $QuantityInArray[0]

				Case "QX" ; quantity of files found

					$MultiImageSearchResult = StringSplit($Res[0], "|", $STR_NOCOUNT)
					Return UBound($MultiImageSearchResult)

			EndSwitch
		EndIf
	EndIf

EndFunc   ;==>QuickMIS
#ce