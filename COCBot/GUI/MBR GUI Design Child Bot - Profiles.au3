; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Profiles" tab under the "Bot" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

Global $g_hCmbProfile = 0, $g_hTxtVillageName = 0, $g_hBtnAddProfile = 0, $g_hBtnConfirmAddProfile = 0, $g_hBtnConfirmRenameProfile = 0, _
	   $g_hBtnDeleteProfile = 0, $g_hBtnCancelProfileChange = 0, $g_hBtnRenameProfile = 0

;$hGUI_Profiles = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $g_hGUI_BOT)
;GUISwitch($hGUI_Profiles)

Func CreateBotProfiles()

    Local $x = 25, $y = 45
	GUICtrlCreateGroup(GetTranslated(637,1, "Switch Profiles"), $x - 20, $y - 20, 440, 360)
		;$y -= 5
		$x -= 5
		;$lblProfile = GUICtrlCreateLabel(GetTranslated(7,27, "Current Profile") & ":", $x, $y, -1, -1)
		;$y += 15
		$g_hCmbProfile = GUICtrlCreateCombo("", $x - 3, $y + 1, 130, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslated(637,2, "Use this to switch to a different profile")& @CRLF & _
							   GetTranslated(637,3, "Your profiles can be found in") & ": " & @CRLF & $g_sProfilePath)
			setupProfileComboBox()
			PopulatePresetComboBox()
			GUICtrlSetState(-1, $GUI_SHOW)
			GUICtrlSetOnEvent(-1, "cmbProfile")
		$g_hTxtVillageName = GUICtrlCreateInput(GetTranslated(637,4, "MyVillage"), $x - 3, $y, 130, 22, $ES_AUTOHSCROLL)
			GUICtrlSetLimit (-1, 100, 0)
			GUICtrlSetFont(-1, 9, 400, 1)
			_GUICtrlSetTip(-1, GetTranslated(637,5, "Your village/profile's name"))
			GUICtrlSetState(-1, $GUI_HIDE)
			; GUICtrlSetOnEvent(-1, "txtVillageName") - No longer needed

		Local $bIconAdd = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_2.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_2.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd_4.bmp")
			_GUIImageList_AddBitmap($bIconAdd, @ScriptDir & "\images\Button\iconAdd.bmp")
		Local $bIconConfirm = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_2.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_2.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm_4.bmp")
			_GUIImageList_AddBitmap($bIconConfirm, @ScriptDir & "\images\Button\iconConfirm.bmp")
		Local $bIconDelete = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_2.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_2.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete_4.bmp")
			_GUIImageList_AddBitmap($bIconDelete, @ScriptDir & "\images\Button\iconDelete.bmp")
		Local $bIconCancel = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_2.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_2.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel_4.bmp")
			_GUIImageList_AddBitmap($bIconCancel, @ScriptDir & "\images\Button\iconCancel.bmp")
		Local $bIconEdit = _GUIImageList_Create(24, 24, 4)
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_2.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_2.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit_4.bmp")
			_GUIImageList_AddBitmap($bIconEdit, @ScriptDir & "\images\Button\iconEdit.bmp")

		$g_hBtnAddProfile = GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnAddProfile, $bIconAdd, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslated(637,6, "Add New Profile"))
		$g_hBtnConfirmAddProfile = GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnConfirmAddProfile, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnAddConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslated(637,7, "Confirm"))
		$g_hBtnConfirmRenameProfile = GUICtrlCreateButton("", $x + 135, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnConfirmRenameProfile, $bIconConfirm, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslated(637,7, -1))
		$g_hBtnDeleteProfile = GUICtrlCreateButton("", $x + 164, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnDeleteProfile, $bIconDelete, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_SHOW)
			_GUICtrlSetTip(-1, GetTranslated(637,8, "Delete Profile"))
		$g_hBtnCancelProfileChange = GUICtrlCreateButton("", $x + 164, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnCancelProfileChange, $bIconCancel, 4)
			GUICtrlSetOnEvent(-1, "btnDeleteCancel")
			GUICtrlSetState(-1, $GUI_HIDE)
			_GUICtrlSetTip(-1, GetTranslated(637,9, "Cancel"))
		$g_hBtnRenameProfile = GUICtrlCreateButton("", $x + 194, $y, 24, 24)
			_GUICtrlButton_SetImageList($g_hBtnRenameProfile, $bIconEdit, 4)
			GUICtrlSetOnEvent(-1, "btnRenameConfirm")
			_GUICtrlSetTip(-1, GetTranslated(637,10, "Rename Profile"))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	CreateBotProfilesSwitchAcc()	; SwitchAcc - Demen

EndFunc


;================================ SwitchAcc - Demen ====================================
Global $lblProfileNo[8], $lblProfileName[8], $cmbAccountNo[8], $cmbProfileType[8]
Global $chkSwitchAcc = 0, $cmbTotalAccount = 0, $radNormalSwitch = 0, $radSmartSwitch = 0, $chkUseTrainingClose = 0, $radCloseCoC = 0, $radCloseAndroid = 0, $cmbLocateAcc = 0

Func CreateBotProfilesSwitchAcc()

	$ProfileList = _GUICtrlComboBox_GetListArray($g_hCmbProfile)
	$nTotalProfile = _GUICtrlComboBox_GetCount($g_hCmbProfile)

	Local $x = 22, $y = 100

		GUICtrlCreateGroup("Switch Account Mode", $x - 12, $y - 20, 200, 300)
			$chkSwitchAcc = GUICtrlCreateCheckbox("Enable Switch Account", $x , $y, -1, -1)
				Local $txtTip = "Switch to another account & profile when troop training time is >= 3 minutes" & @CRLF & "This function supports maximum 6 CoC accounts & 6 Bot profiles" & @CRLF & "Make sure to create sufficient Profiles equal to number of CoC Accounts, and align the index of accounts order with profiles order"
				GUICtrlSetTip(-1, $txtTip)
				GUICtrlSetOnEvent(-1, "chkSwitchAcc")

			GUICtrlCreateLabel("Total CoC Acc:", $x + 15, $y + 29, -1, -1)
				Local $txtTip = "Choose number of CoC Accounts pre-logged"

			$cmbTotalAccount = GUICtrlCreateCombo("", $x + 100, $y + 25, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				GUICtrlSetData(-1, "1 Acc." & "|" & "2 Acc." & "|" & "3 Acc." & "|" & "4 Acc." & "|" & "5 Acc." & "|" & "6 Acc." & "|" & "7 Acc." & "|" & "8 Acc.")
				GUICtrlSetTip(-1, $txtTip)

			$radNormalSwitch = GUICtrlCreateRadio("Normal switch", $x + 15, $y + 55, -1, 16)
				GUICtrlSetTip(-1, "Switching accounts continously")
				GUICtrlSetState(-1, $GUI_CHECKED)
				GUICtrlSetOnEvent(-1, "radNormalSwitch")

			$radSmartSwitch = GUICtrlCreateRadio("Smart switch", $x + 100 , $y + 55, -1, 16)
				GUICtrlSetTip(-1, "Switch to account with the shortest remain training time")
				GUICtrlSetOnEvent(-1, "radNormalSwitch")

			$y += 80

			$chkUseTrainingClose = GUICtrlCreateCheckbox("Combo Sleep after Switch Acc.", $x, $y, -1, -1)
				Local $txtTip = "Close CoC combo with Switch Account when there is more than 3 mins remaining on training time of all accounts."
				GUICtrlSetTip(-1, $txtTip)

			GUIStartGroup()
			$radCloseCoC = GUICtrlCreateRadio("Close CoC", $x + 15 , $y + 30, -1, 16)
				GUICtrlSetState(-1, $GUI_CHECKED)

			$radCloseAndroid = GUICtrlCreateRadio("Close Android", $x + 100, $y + 30, -1, 16)

			$y += 60

			GUICtrlCreateLabel("Manually locate account coordinates", $x, $y, -1, -1)

			$cmbLocateAcc = GUICtrlCreateCombo("", $x + 15, $y + 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
				Local $txtTip = "Select CoC Account to manually locate its y-coordinate"
				GUICtrlSetData(-1, "Acc. 1" & "|" & "Acc. 2" & "|" & "Acc. 3" & "|" & "Acc. 4" & "|" & "Acc. 5" & "|" & "Acc. 6" & "|" & "Acc. 7" & "|" & "Acc. 8", "Acc. 1")
				GUICtrlSetTip(-1, $txtTip)

			GUICtrlCreateButton("Locate", $x + 80, $y + 24 , 50, 23)
				GUICtrlSetTip(-1, "Starting locate your CoC Account")
				GUICtrlSetOnEvent(-1, "btnLocateAcc")

			GUICtrlCreateButton("Clear All", $x + 135, $y + 24 , 50, 23, $BS_MULTILINE)
				GUICtrlSetTip(-1, "clear location data of all accounts")
				GUICtrlSetOnEvent(-1, "btnClearAccLocation")

		GUICtrlCreateGroup("", -99, -99, 1, 1)

	; Profiles & Account matching
	Local $x = 235, $y = 100

		GUICtrlCreateGroup("Profiles", $x - 20, $y - 20, 225, 300)
			GUICtrlCreateButton("Update Profiles", $x + 40, $y - 5 , -1, 25)
				GUICtrlSetOnEvent(-1, "btnUpdateProfile")
			GUICtrlCreateButton("Clear Profiles", $x + 130, $y - 5 , -1, 25)
				GUICtrlSetOnEvent(-1, "btnClearProfile")

		$y += 35
			GUICtrlCreateLabel("No.", $x-10, $y, 15,-1,$SS_CENTER)
			GUICtrlCreateLabel("Profile Name", $x+10, $y, 90,-1,$SS_CENTER)
			GUICtrlCreateLabel("Acc.", $x+105, $y, 30,-1,$SS_CENTER)
			GUICtrlCreateLabel("Bot Type", $x+140, $y, 60,-1,$SS_CENTER)

		$y += 20
			GUICtrlCreateGraphic($x - 10, $y, 205, 1, $SS_GRAYRECT)
			GUICtrlCreateGraphic($x + 10, $y - 25, 1, 40, $SS_GRAYRECT)

		$y += 10
			 For $i = 0 To 7
				$lblProfileNo[$i] = GUICtrlCreateLabel($i + 1 & ".", $x -10, $y + 4 + ($i) * 25, 15, 18, $SS_CENTER)
				GUICtrlCreateGraphic($x + 10, $y + ($i) * 25, 1, 25, $SS_GRAYRECT)

				$lblProfileName[$i] = GUICtrlCreateLabel("Village Name", $x +10, $y + 4 + ($i) * 25, 90, 18, $SS_CENTER)
					If $i <= $nTotalProfile - 1 Then GUICtrlSetData(-1, $ProfileList[$i+1])
				$cmbAccountNo[$i] = GUICtrlCreateCombo("", $x + 105, $y + ($i) * 25, 30, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					Local $txtTip = "Select the index of CoC Account to match with this Profile"
					GUICtrlSetData(-1, "1" & "|" & "2" & "|" & "3" & "|" & "4" & "|" & "5" & "|" & "6" & "|" & "7" & "|" & "8")
					GUICtrlSetTip(-1, $txtTip)
					GUICtrlSetOnEvent(-1, "cmbMatchProfileAcc"&$i+1)
				$cmbProfileType[$i] = GUICtrlCreateCombo("", $x + 140, $y + ($i) * 25, 60, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
					Local $txtTip = "Define the botting type of this profile"
					GUICtrlSetData(-1, "Active" & "|" & "Donate" & "|" & "Idle")
					GUICtrlSetTip(-1, $txtTip)
				If $i > $nTotalProfile - 1 Then
					For $j = $lblProfileNo[$i] To $cmbProfileType[$i]
						GUICtrlSetState($j, $GUI_HIDE)
					Next
				EndIf
			 Next
			 GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc
;================================ SwitchAcc - Demen ====================================
