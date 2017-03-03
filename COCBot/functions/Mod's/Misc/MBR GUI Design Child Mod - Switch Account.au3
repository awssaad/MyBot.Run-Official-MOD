; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Child Mod - Switch Account
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

Global $lblProfileNo[8], $lblProfileName[8], $cmbAccountNo[8], $cmbProfileType[8]
Global $chkSwitchAcc = 0, $cmbTotalAccount = 0, $radNormalSwitch = 0, $radSmartSwitch = 0, $chkUseTrainingClose = 0, $radCloseCoC = 0, $radCloseAndroid = 0, $cmbLocateAcc = 0

Func CreateModSwitchAccount()

	$ProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
	$nTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)

	Local $sTxtTip = ""
	Local $x = 22, $y = 100

		GUICtrlCreateGroup(GetTranslated(655,50, "Switch Account Mode"), $x - 12, $y - 20, 200, 300)
			$chkSwitchAcc = GUICtrlCreateCheckbox(GetTranslated(655,51, "Enable Switch Account"), $x , $y, -1, -1)
				$sTxtTip = GetTranslated(655,52, "Switch to another account & profile when troop training time is >= 3 minutes") & @CRLF & GetTranslated(655,53, "This function supports maximum 8 CoC accounts & 8 Bot profiles") & @CRLF & GetTranslated(655,54, "Make sure to create sufficient Profiles equal to number of CoC Accounts, and align the index of accounts order with profiles order")
				GUICtrlSetTip(-1, $sTxtTip)
				GUICtrlSetOnEvent(-1, "chkSwitchAcc")

			GUICtrlCreateLabel(GetTranslated(655,59, "Total CoC Acc:"), $x + 15, $y + 29, -1, -1)
				$sTxtTip = GetTranslated(655,60, "Choose number of CoC Accounts pre-logged")

			$cmbTotalAccount = GUICtrlCreateCombo("", $x + 100, $y + 25, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				GUICtrlSetData(-1, "1 Acc." & "|" & "2 Acc." & "|" & "3 Acc." & "|" & "4 Acc." & "|" & "5 Acc." & "|" & "6 Acc." & "|" & "7 Acc." & "|" & "8 Acc.")
				GUICtrlSetTip(-1, $sTxtTip)

			$radNormalSwitch = GUICtrlCreateRadio(GetTranslated(655,61, "Normal switch"), $x + 15, $y + 55, -1, 16)
				GUICtrlSetTip(-1, GetTranslated(655,62, "Switching accounts continously"))
				GUICtrlSetState(-1, $GUI_CHECKED)
				GUICtrlSetOnEvent(-1, "radNormalSwitch")

			$radSmartSwitch = GUICtrlCreateRadio(GetTranslated(655,63, "Smart switch"), $x + 100 , $y + 55, -1, 16)
				GUICtrlSetTip(-1, GetTranslated(655,64, "Switch to account with the shortest remain training time"))
				GUICtrlSetOnEvent(-1, "radNormalSwitch")

			$y += 80

			$chkUseTrainingClose = GUICtrlCreateCheckbox(GetTranslated(655,65, "Combo Sleep after Switch Acc."), $x, $y, -1, -1)
				$sTxtTip = GetTranslated(655,66, "Close CoC combo with Switch Account when there is more than 3 mins remaining on training time of all accounts.")
				GUICtrlSetTip(-1, $sTxtTip)

			GUIStartGroup()
			$radCloseCoC = GUICtrlCreateRadio(GetTranslated(655,67, "Close CoC"), $x + 15 , $y + 30, -1, 16)
				GUICtrlSetState(-1, $GUI_CHECKED)

			$radCloseAndroid = GUICtrlCreateRadio(GetTranslated(655,68, "Close Android"), $x + 100, $y + 30, -1, 16)

			$y += 60

			GUICtrlCreateLabel(GetTranslated(655,69, "Manually locate account coordinates"), $x, $y, -1, -1)

			$cmbLocateAcc = GUICtrlCreateCombo("", $x + 15, $y + 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				$sTxtTip = GetTranslated(655,70, "Select CoC Account to manually locate its y-coordinate")
				GUICtrlSetData(-1, "Acc. 1" & "|" & "Acc. 2" & "|" & "Acc. 3" & "|" & "Acc. 4" & "|" & "Acc. 5" & "|" & "Acc. 6" & "|" & "Acc. 7" & "|" & "Acc. 8", "Acc. 1")
				GUICtrlSetTip(-1, $sTxtTip)

			GUICtrlCreateButton(GetTranslated(655,71, "Locate"), $x + 80, $y + 24 , 50, 23)
				GUICtrlSetTip(-1, GetTranslated(655,72, "Starting locate your CoC Account"))
				GUICtrlSetOnEvent(-1, "btnLocateAcc")

			GUICtrlCreateButton(GetTranslated(655,73, "Clear All"), $x + 135, $y + 24 , 50, 23, $BS_MULTILINE)
				GUICtrlSetTip(-1, GetTranslated(655,74, "Clear location data of all accounts"))
				GUICtrlSetOnEvent(-1, "btnClearAccLocation")

		GUICtrlCreateGroup("", -99, -99, 1, 1)

	; Profiles & Account matching
	Local $x = 235, $y = 100

		GUICtrlCreateGroup(GetTranslated(655,75, "Profiles"), $x - 20, $y - 20, 225, 300)
			GUICtrlCreateButton(GetTranslated(655,76, "Update Profiles"), $x + 40, $y - 5 , -1, 25)
				GUICtrlSetOnEvent(-1, "btnUpdateProfile")
			GUICtrlCreateButton(GetTranslated(655,77, "Clear Profiles"), $x + 130, $y - 5 , -1, 25)
				GUICtrlSetOnEvent(-1, "btnClearProfile")

		$y += 35
			GUICtrlCreateLabel(GetTranslated(655,78, "No."), $x-10, $y, 15,-1,$SS_CENTER)
			GUICtrlCreateLabel(GetTranslated(655,79, "Profile Name"), $x+10, $y, 90,-1,$SS_CENTER)
			GUICtrlCreateLabel(GetTranslated(655,80, "Acc."), $x+105, $y, 30,-1,$SS_CENTER)
			GUICtrlCreateLabel(GetTranslated(655,81, "Bot Type"), $x+140, $y, 60,-1,$SS_CENTER)

		$y += 20
			GUICtrlCreateGraphic($x - 10, $y, 205, 1, $SS_GRAYRECT)
			GUICtrlCreateGraphic($x + 10, $y - 25, 1, 40, $SS_GRAYRECT)

		$y += 10
			 For $i = 0 To 7
				$lblProfileNo[$i] = GUICtrlCreateLabel($i + 1 & ".", $x -10, $y + 4 + ($i) * 25, 15, 18, $SS_CENTER)
				GUICtrlCreateGraphic($x + 10, $y + ($i) * 25, 1, 25, $SS_GRAYRECT)

				$lblProfileName[$i] = GUICtrlCreateLabel(GetTranslated(655,82, "Village Name"), $x +10, $y + 4 + ($i) * 25, 90, 18, $SS_CENTER)
					If $i <= $nTotalProfile - 1 Then GUICtrlSetData(-1, $ProfileList[$i+1])
				$cmbAccountNo[$i] = GUICtrlCreateCombo("", $x + 105, $y + ($i) * 25, 30, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					$sTxtTip = GetTranslated(655,83, "Select the index of CoC Account to match with this Profile")
					GUICtrlSetData(-1, "1" & "|" & "2" & "|" & "3" & "|" & "4" & "|" & "5" & "|" & "6" & "|" & "7" & "|" & "8")
					GUICtrlSetTip(-1, $sTxtTip)
					GUICtrlSetOnEvent(-1, "cmbMatchProfileAcc"&$i+1)
				$cmbProfileType[$i] = GUICtrlCreateCombo("", $x + 140, $y + ($i) * 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					$sTxtTip = GetTranslated(655,84, "Define the botting type of this profile")
					GUICtrlSetData(-1, GetTranslated(655,85, "Active") & "|" & GetTranslated(655,86, "Donate") & "|" & GetTranslated(655,87, "Idle"))
					GUICtrlSetTip(-1, $sTxtTip)
				If $i > $nTotalProfile - 1 Then
					For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
						GUICtrlSetState($j, $GUI_HIDE)
					Next
				EndIf
			 Next
			 GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc
