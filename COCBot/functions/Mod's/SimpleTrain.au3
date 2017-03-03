; #FUNCTION# ====================================================================================================================
; Name ..........: SmartQuickTrain
; Description ...: This file contains the Sequence that runs all MBR Bot
; Author ........: DEMEN
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Functions used:
; 	getArmyCapacityOnTrainTroops($x_start, $y_start)   -> Gets quantity of troops in army Window
;	GetOCRCurrent($x_start, $y_start)
;	ISArmyWindow($writelogs = False, $TabNumber = 0)
;	OpenTrainTabNumber($Num)
; 	MakingDonatedTroops()
; 	CheckExistentArmy()
; 	QuickTrain()

Global Enum $Full, $Remained, $NoTrain

Func SimpleTrain()

	If $g_bQuickTrainEnable = False Then
		Setlog("Start Simple Custom Train")
	Else
		Setlog("Start Simple Quick Train")
	EndIf

	Local $CheckTroop[4] = [810, 186, 0xCFCFC8, 15] ; the gray background
	Local $TrainMethod = $NoTrain, $BrewMethod = $NoTrain
	Local $CheckRemoveWrongTroops = False, $CheckRemoveWrongSpells = False

	If $g_bRunState = False Then Return

; Troops
	OpenTrainTabNumber($TrainTroopsTAB, "SimpleTrain()")
	If _Sleep(1000) Then Return
	If ISArmyWindow(True, $TrainTroopsTAB) = False Then Return

	Local $ArmyCamp = GetOCRCurrent(48, 160)

	Setlog(" - Current queue/capacity: " & $ArmyCamp[0] & "/" & $ArmyCamp[1])

	If $ichkFillArcher <> 1 Then $iFillArcher = 0

	Switch $ArmyCamp[0] - $ArmyCamp[1]
		Case -$ArmyCamp[1]
			SetLog(" »» No troop")
			$TrainMethod = $Full

		Case -$ArmyCamp[1]+1 To -$iFillArcher-1
			If $g_bQuickTrainEnable = False And _ColorCheck(_GetPixelColor(820, 220, True), Hex(0xCFCFC8, 6), 15) = False Then
				SetLog(" »» Not full troop camp. Let's clear training troops")
				Local $x = 0
				While _ColorCheck(_GetPixelColor(820, 220, True), Hex(0xCFCFC8, 6), 15) = False	; the gray background at slot 0 troop
					PureClick(820, 202, 2, 50)
					$x += 1
					If $x = 480 Then ExitLoop
				WEnd
			Else
				SetLog(" »» Not full troop camp.")
			EndIf
			$CheckRemoveWrongTroops = True
			$TrainMethod = $Remained

		Case -$iFillArcher To 0
			If $ArmyCamp[0] - $ArmyCamp[1] < 0 Then
				SetLog(" »» Fill some archers")
				Local $ArchToMake = $ArmyCamp[1] - $ArmyCamp[0]
				If ISArmyWindow(False, $TrainTroopsTAB) Then TrainIt($eArch, $ArchToMake, 500)
				SetLog(" » Trained " & $ArchToMake & " archer(s)!")
			Else
				SetLog(" »» Zero queue")
			EndIf
			$TrainMethod = $Full

		Case 1 To $ArmyCamp[1] - $iFillArcher - 1
			SetLog(" »» Not full queue. Delete queued troops")
			If ISArmyWindow(False, $TrainTroopsTAB) Then
				For $i = 0 To 11
				   If _ColorCheck(_GetPixelColor($CheckTroop[0] - $i*70, $CheckTroop[1], True), Hex($CheckTroop[2], 6), $CheckTroop[3]) = False Then
					  Local $x = 0
					  While _ColorCheck(_GetPixelColor($CheckTroop[0] - $i*70, $CheckTroop[1], True), Hex($CheckTroop[2], 6), $CheckTroop[3]) = False
						If _Sleep(20) Then Return
						If $g_bRunState = False Then Return
						PureClick($CheckTroop[0] - $i*70, 202, 2, 50)
						$x += 1
						If $x = 250 Then ExitLoop
					  WEnd
					  ExitLoop
				   EndIf
				Next
			EndIf
			$TrainMethod = $Full

		Case $ArmyCamp[1] -$iFillArcher To $ArmyCamp[1]
			If $ArmyCamp[0] - $ArmyCamp[1] < $ArmyCamp[1] Then
				SetLog(" »» Fill some archers")
				Local $ArchToMake = $ArmyCamp[1]*2 - $ArmyCamp[0]
				If ISArmyWindow(False, $TrainTroopsTAB) Then TrainIt($eArch, $ArchToMake, 500)
				SetLog(" » Trained " & $ArchToMake & " archer(s)!")
			Else
				SetLog(" »» Full queue")
			EndIf
			$TrainMethod = $NoTrain

	EndSwitch

	If $g_bQuickTrainEnable = False And $TrainMethod = $Full Then
	   MakeCustomTrain($TrainMethod, $BrewMethod)
	   $TrainMethod = $NoTrain
	EndIf

; Spells
	If $g_bQuickTrainEnable = 1 OR TotalSpellsToBrewInGUI() > 0 Then
		OpenTrainTabNumber($BrewSpellsTAB, "SimpleTrain()")
		If _Sleep(1000) Then Return
		If ISArmyWindow(True, $BrewSpellsTAB) = False Then Return

		Local $SpellCamp = GetOCRCurrent(48, 160)
		Setlog(" - Current queue/capacity: " & $SpellCamp[0] & "/" & $SpellCamp[1])

		Switch $SpellCamp[0] - $SpellCamp[1]
			Case -$SpellCamp[1]
				SetLog(" »» No spell")
				$BrewMethod = $Full

			Case -$SpellCamp[1]+1 To -1
				If $ichkFillEQ = 0 OR $SpellCamp[0] - $SpellCamp[1] < -1 Then
					If $g_bQuickTrainEnable = False Then
						SetLog(" »» Not full spell camp. Let's clear brewing spells")
						Local $x = 0
						While _ColorCheck(_GetPixelColor(820, 220, True), Hex(0xCFCFC8, 6), 15) = False	; the gray background at slot 0 troop
							PureClick(820, 202, 2, 50)
							$x += 1
							If $x = 22 Then ExitLoop
						WEnd
					Else
						SetLog(" »» Not full spell camp.")
					EndIf
				Else
					SetLog(" »» Fill with 1 EQ spell")
					If ISArmyWindow(False, $BrewSpellsTAB) Then TrainIt($eESpell, 1, 500)
					SetLog(" » Brewed 1 EQ spell!")
				EndIf
				$CheckRemoveWrongSpells = True
				$BrewMethod = $Remained

			Case 0
				SetLog(" »» Full spell camp, Zero queue")
				$BrewMethod = $Full

			Case 1 To $SpellCamp[1] - 1
				If $ichkFillEQ = 0 OR $SpellCamp[0] - $SpellCamp[1] < $SpellCamp[1] - 1 Then
					SetLog(" »» Not full queue, Delete queued spells")
					If ISArmyWindow(False, $BrewSpellsTAB) Then
						For $i = 0 To 11
						   If _ColorCheck(_GetPixelColor($CheckTroop[0] - $i*70, $CheckTroop[1], True), Hex($CheckTroop[2], 6), $CheckTroop[3]) = False Then
							 Local $x = 0
							  While _ColorCheck(_GetPixelColor($CheckTroop[0] - $i*70, $CheckTroop[1], True), Hex($CheckTroop[2], 6), $CheckTroop[3]) = False
								If _Sleep(20) Then Return
								If $g_bRunState = False Then Return
								PureClick($CheckTroop[0] - $i*70, 202, 2, 50)
								$x += 1
								If $x = 22 Then ExitLoop
							 WEnd
							 ExitLoop
						  EndIf
						Next
					EndIf
					$BrewMethod = $Full
				Else
					SetLog(" »» Fill with 1 EQ spell")
					If ISArmyWindow(False, $BrewSpellsTAB) Then TrainIt($eESpell, 1, 500)
					SetLog(" » Brewed 1 EQ spell!")
					$BrewMethod = $NoTrain
				EndIf

			Case $SpellCamp[1]
				SetLog(" »» Full queue")
				$BrewMethod = $NoTrain

		EndSwitch

		If $g_bQuickTrainEnable = False And $BrewMethod = $Full Then
		   MakeCustomTrain($NoTrain, $BrewMethod)
		   $BrewMethod = $NoTrain
		EndIf
	EndIf

	If $g_bQuickTrainEnable = False Then	; Custom Train
	    If _Sleep(500) Then Return
	    RemoveWrongTroops($CheckRemoveWrongTroops, $CheckRemoveWrongSpells)
		If _Sleep(1000) Then Return
		MakeCustomTrain($TrainMethod, $BrewMethod)
		ClickP($aAway, 2, 0, "#0000")
	ElseIf $TrainMethod <> $NoTrain OR $BrewMethod <> $NoTrain Then 	; Quick Train
		OpenTrainTabNumber($QuickTrainTAB, "SimpleTrain()")
		If _Sleep(500) Then Return
		TrainArmyNumber($g_bQuickTrainArmy)
		ClickP($aAway, 2, 0, "#0000")
	Else
		Setlog("Full queue, skip Quick Train")
    EndIf

	ClickP($aAway, 2, 0, "#0000") ;Click Away
EndFunc


Func MakeCustomTrain($TrainMethod, $BrewMethod)
;Troops
	If $TrainMethod = $NoTrain And $BrewMethod = $NoTrain Then
	   Setlog("Full barracks & spell factories, skip training")
	   Return
	EndIf

	If $TrainMethod <> $NoTrain Then
		Local $rWTT[1][2] = [["Arch", 0]]	; result of what to train
		If $TrainMethod = $Remained Then OpenTrainTabNumber($TrainTroopsTAB, "MakeCustomTrain()")
		If ISArmyWindow(True, $TrainTroopsTAB) = False Then OpenTrainTabNumber($TrainTroopsTAB, "MakeCustomTrain()")
		If $TrainMethod = $Remained Then
			Setlog("Custom train troops left")
			For $i = 0 To ($eTroopCount - 1)
				Local $troopIndex = $g_aiTrainOrder[$i]
				If $g_bRunState = False Then Return
				If $g_aiArmyCompTroops[$troopIndex] - $g_aiCurrentTroops[$troopIndex] > 0 Then
					$rWTT[UBound($rWTT) - 1][0] = $g_asTroopShortNames[$troopIndex]
					$rWTT[UBound($rWTT) - 1][1] = Abs($g_aiArmyCompTroops[$troopIndex] - $g_aiCurrentTroops[$troopIndex])
					Local $iTroopIndex = TroopIndexLookup($rWTT[UBound($rWTT)-1][0])
					Local $sTroopName = ($rWTT[UBound($rWTT) - 1][1] > 1 ? $g_asTroopNamesPlural[$iTroopIndex] : $g_asTroopNames[$iTroopIndex])
					setlog(   UBound($rWTT) & ". " & $sTroopName & " x " & $rWTT[UBound($rWTT) - 1][1])
					ReDim $rWTT[UBound($rWTT) + 1][2]
				EndIf
			Next

		ElseIf $TrainMethod = $Full Then
		    Setlog("Custom train full set of troops")
			For $i = 0 To ($eTroopCount - 1)
				Local $troopIndex = $g_aiTrainOrder[$i]
				If $g_aiArmyCompTroops[$troopIndex] > 0 Then
					$rWTT[UBound($rWTT) - 1][0] = $g_asTroopShortNames[$troopIndex]
					$rWTT[UBound($rWTT) - 1][1] = $g_aiArmyCompTroops[$troopIndex]
					Local $iTroopIndex = TroopIndexLookup($rWTT[UBound($rWTT)-1][0])
					Local $sTroopName = ($rWTT[UBound($rWTT) - 1][1] > 1 ? $g_asTroopNamesPlural[$iTroopIndex] : $g_asTroopNames[$iTroopIndex])
					setlog(   UBound($rWTT) & ". " & $sTroopName & " x " & $rWTT[UBound($rWTT) - 1][1])
					ReDim $rWTT[UBound($rWTT) + 1][2]
				EndIf
			Next
		EndIf

		; Train it
		For $i = 0 To (UBound($rWTT) - 1)
			If $g_bRunState = False Then Return
			If $rWTT[$i][1] > 0 Then
				If DragIfNeeded($rWTT[$i][0]) = False Then Return False
				If CheckValuesCost($rWTT[$i][0], $rWTT[$i][1]) Then
					Local $iTroopIndex = TroopIndexLookup($rWTT[$i][0])
					Local $sTroopName = ($rWTT[$i][1] > 1 ? $g_asTroopNamesPlural[$iTroopIndex] : $g_asTroopNames[$iTroopIndex])
					SetLog("Training " & $rWTT[$i][1] & "x " & $sTroopName, $COLOR_GREEN)
					TrainIt($iTroopIndex, $rWTT[$i][1], $g_iTrainClickDelay)
				Else
					SetLog("No resources to Train " & $rWTT[$i][1] & "x " & $sTroopName, $COLOR_ORANGE)
				EndIf
			EndIf
		Next
    EndIf

;Spells
	If $BrewMethod <> $NoTrain Then
	    Local $rWTT[1][2] = [["LSpell", 0]]	; result of what to train
		If $TrainMethod = $Remained Then OpenTrainTabNumber($BrewSpellsTAB, "MakeCustomTrain()")
		If ISArmyWindow(True, $BrewSpellsTAB) = False Then OpenTrainTabNumber($BrewSpellsTAB, "MakeCustomTrain()")
		If $BrewMethod = $Remained Then
		    Setlog("Custom brew spells left")
		    For $i = 0 To ($eSpellCount - 1)
				If $g_bRunState = False Then Return
				If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
				If $g_aiArmyCompSpells[$i] - $g_aiCurrentSpells[$i] > 0 Then
					$rWTT[UBound($rWTT) - 1][0] = $g_asSpellShortNames[$i]
					$rWTT[UBound($rWTT) - 1][1] = $g_aiArmyCompSpells[$i] - $g_aiCurrentSpells[$i]
					Local $iSpellIndex = TroopIndexLookup($rWTT[UBound($rWTT)-1][0])
					Local $sSpellName = $g_asSpellNames[$iSpellIndex - $eLSpell]
					setlog(   UBound($rWTT) & ". " & $sSpellName & " x " & $rWTT[UBound($rWTT) - 1][1])
					ReDim $rWTT[UBound($rWTT) + 1][2]
				EndIf
			Next
		ElseIf $BrewMethod = $Full Then
		    Setlog("Custom brew full set of spells")
			For $i = 0 To ($eSpellCount - 1)
				If $g_bRunState = False Then Return
				If TotalSpellsToBrewInGUI() = 0 Then ExitLoop
				If $g_aiArmyCompSpells[$i] > 0 Then
					$rWTT[UBound($rWTT) - 1][0] = $g_asSpellShortNames[$i]
					$rWTT[UBound($rWTT) - 1][1] = $g_aiArmyCompSpells[$i]
					Local $iSpellIndex = TroopIndexLookup($rWTT[UBound($rWTT)-1][0])
					Local $sSpellName = $g_asSpellNames[$iSpellIndex - $eLSpell]
					setlog(   UBound($rWTT) & ". " & $sSpellName & " x " & $rWTT[UBound($rWTT) - 1][1])
					ReDim $rWTT[UBound($rWTT) + 1][2]
				EndIf
			Next
	   EndIf

		; Train it
		For $i = 0 To (UBound($rWTT) - 1)
			If $g_bRunState = False Then Return
			If $rWTT[$i][1] > 0 Then
				If CheckValuesCost($rWTT[$i][0], $rWTT[$i][1]) Then
					Local $iSpellIndex = TroopIndexLookup($rWTT[$i][0])
					Local $sSpellName = $g_asSpellNames[$iSpellIndex - $eLSpell]
					SetLog("Brewing " & $rWTT[$i][1] & "x " & $sSpellName, $COLOR_GREEN)
					TrainIt($iSpellIndex, $rWTT[$i][1], $g_iTrainClickDelay)
				Else
					SetLog("No resources to Train " & $rWTT[$i][1] & "x " & $sSpellName, $COLOR_ORANGE)
				EndIf
			EndIf
		Next
	EndIf
EndFunc   ;==>MakeCustomTrain

Func RemoveWrongTroops($Troop = True, $Spell = False)
	If $Troop = False And $Spell = False Then Return
	Local $toRemove[1][2] = [["Arch", 0]]	; Wrong Troops & Spells to be removed
	OpenTrainTabNumber($ArmyTAB, "MakeCustomTrain()")
	If _Sleep(500) Then Return

	If $Troop = True Then
	   CheckExistentArmy("Troops", True)
	   For $i = 0 To ($eTroopCount - 1)
		   If $g_bRunState = False Then Return
		   If $g_aiCurrentTroops[$i] - $g_aiArmyCompTroops[$i] > 0 Then
			   $toRemove[UBound($toRemove) - 1][0] = $g_asTroopShortNames[$i]
			   $toRemove[UBound($toRemove) - 1][1] = $g_aiCurrentTroops[$i] - $g_aiArmyCompTroops[$i]
			   ReDim $toRemove[UBound($toRemove) + 1][2]
		   EndIf
	   Next
	EndIf

    If $Spell = True Then
	   CheckExistentArmy("Spells", True)
	   For $i = 0 To ($eSpellCount - 1)
		   If $g_bRunState = False Then Return
		   If $g_aiCurrentSpells[$i]  - $g_aiArmyCompSpells[$i] > 0 Then
			   $toRemove[UBound($toRemove) - 1][0] = $g_asSpellShortNames[$i]
			   $toRemove[UBound($toRemove) - 1][1] = $g_aiCurrentSpells[$i]  - $g_aiArmyCompSpells[$i]
			   ReDim $toRemove[UBound($toRemove) + 1][2]
		   EndIf
	   Next
	EndIf

	If UBound($toRemove) = 1 And $toRemove[0][0] = "Arch" And $toRemove[0][1] = 0 Then Return ; If was default Wrong Troops

	If UBound($toRemove) > 0 Then ; If needed to remove troops
		Local $rGetSlotNumber = GetSlotNumber() ; Get all available Slot numbers with troops assigned on them
		Local $rGetSlotNumberSpells = GetSlotNumber(True) ; Get all available Slot numbers with Spells assigned on them

		SetLog("Troops To Remove: ", $COLOR_GREEN)
		; Loop through Troops needed to get removed Just to write some Logs
		Local $CounterToRemove = 0
		For $i = 0 To (UBound($toRemove) - 1)
			If IsSpellToBrew($toRemove[$i][0]) Then ExitLoop
			$CounterToRemove += 1
			If $toRemove[$i][1] > 0 Then SetLog("  " & $g_asTroopNames[TroopIndexLookup($toRemove[$i][0])] & ": " & $toRemove[$i][1] & "x", $COLOR_GREEN)
		Next

		If TotalSpellsToBrewInGUI() > 0 Then
			If $CounterToRemove <= UBound($toRemove) Then
				SetLog("Spells To Remove: ", $COLOR_GREEN)
				For $i = $CounterToRemove To (UBound($toRemove) - 1)
					If $toRemove[$i][1] > 0 Then SetLog("  " & $g_asSpellNames[TroopIndexLookup($toRemove[$i][0]) - $eLSpell] & ": " & $toRemove[$i][1] & "x", $COLOR_GREEN)
				Next
			EndIf
		EndIf

		If _ColorCheck(_GetPixelColor(806, 472, True), Hex(0xD0E878, 6), 25) = False Then ; If no 'Edit Army' Button found in army tab to edit troops
			SetLog("Cannot find/verify 'Edit Army' Button in Army tab", $COLOR_ORANGE)
			Return False ; Exit function
		EndIf

		Click(Random(723, 812, 1), Random(469, 513, 1)) ; Click on Edit Army Button

		; Loop through troops needed to get removed
		$CounterToRemove = 0
		For $j = 0 To (UBound($toRemove) - 1)
			If IsSpellToBrew($toRemove[$j][0]) Then ExitLoop
			$CounterToRemove += 1
			For $i = 0 To (UBound($rGetSlotNumber) - 1) ; Loop through All available slots
				; $toRemove[$j][0] = Troop name, E.g: Barb, $toRemove[$j][1] = Quantity to remove
				If $toRemove[$j][0] = $rGetSlotNumber[$i] Then ; If $toRemove Troop Was the same as The Slot Troop
					Local $pos = GetSlotRemoveBtnPosition($i + 1) ; Get positions of - Button to remove troop
					ClickRemoveTroop($pos, $toRemove[$j][1], $g_iTrainClickDelay) ; Click on Remove button as much as needed
				EndIf
			Next
		Next

		If TotalSpellsToBrewInGUI() > 0 Then
			For $j = $CounterToRemove To (UBound($toRemove) - 1)
				For $i = 0 To (UBound($rGetSlotNumberSpells) - 1) ; Loop through All available slots
					; $toRemove[$j][0] = Troop name, E.g: Barb, $toRemove[$j][1] = Quantity to remove
					If $toRemove[$j][0] = $rGetSlotNumberSpells[$i] Then ; If $toRemove Troop Was the same as The Slot Troop
						Local $pos = GetSlotRemoveBtnPosition($i + 1, True) ; Get positions of - Button to remove troop
						ClickRemoveTroop($pos, $toRemove[$j][1], $g_iTrainClickDelay) ; Click on Remove button as much as needed
					EndIf
				Next
			Next
		EndIf

		If _Sleep(150) Then Return

		If _ColorCheck(_GetPixelColor(806, 561, True), Hex(0xD0E878, 6), 25) = False Then ; If no 'Okay' button found in army tab to save changes
			SetLog("Cannot find/verify 'Okay' Button in Army tab", $COLOR_ORANGE)
			ClickP($aAway, 2, 0, "#0346") ; Click Away, Necessary! due to possible errors/changes
			If _Sleep(400) Then OpenArmyWindow() ; Open Army Window AGAIN
			Return False ; Exit Function
		EndIf

		If _Sleep(700) Then Return
		If $g_bRunState = False Then Return
		Click(Random(720, 815, 1), Random(558, 589, 1)) ; Click on 'Okay' button to save changes

		If _Sleep(1200) Then Return

		If _ColorCheck(_GetPixelColor(508, 428, True), Hex(0xFFFFFF, 6), 30) = False Then ; If no 'Okay' button found to verify that we accept the changes
			SetLog("Cannot find/verify 'Okay #2' Button in Army tab", $COLOR_ORANGE)
			ClickP($aAway, 2, 0, "#0346") ;Click Away
			Return False ; Exit function
		EndIf

		Click(Random(445, 585, 1), Random(400, 455, 1)) ; Click on 'Okay' button to Save changes... Last button

		SetLog("All Extra troops removed", $COLOR_GREEN)
		If _Sleep(200) Then Return
	Else ; If No extra troop found
		SetLog("No extra troop to remove, Great", $COLOR_GREEN)
EndIf

EndFunc   ;==>RemoveWrongTroops