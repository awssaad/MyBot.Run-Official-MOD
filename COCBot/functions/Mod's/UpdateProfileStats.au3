; #FUNCTION# ====================================================================================================================
; Name ..........: UpdateProfileStats
; Description ...: Additional functions for UpdateStats
; Syntax ........: UpdateStats()
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......:
; ===============================================================================================================================

Func UpdateStatsForSwitchAcc()

	GUICtrlSetData($g_hLblResultSkippedHourNow, $aSkippedVillageCountAcc[$nCurProfile -1])		;	Counting skipped village at Bottom GUI
	GUICtrlSetData($g_hLblResultAttackedHourNow, $aAttackedCountAcc[$nCurProfile -1])			;	Counting attacked village at Bottom GUI

    For $i = 0 To 3
	   ;village report
	   GUICtrlSetData($lblResultGoldNowAcc[$i], _NumberFormat($aGoldCurrentAcc[$i], True))
	   GUICtrlSetData($lblResultElixirNowAcc[$i], _NumberFormat($aElixirCurrentAcc[$i], True))
	   If $g_iStatsStartedWith[$eLootDarkElixir] <> "" Then
		  GUICtrlSetData($lblResultDeNowAcc[$i], _NumberFormat($aDarkCurrentAcc[$i], True))
	   EndIf
	   GUICtrlSetData($lblResultTrophyNowAcc[$i], _NumberFormat($aTrophyCurrentAcc[$i], True))
	   GUICtrlSetData($lblResultGemNowAcc[$i], _NumberFormat($aGemAmountAcc[$i], True))
	   GUICtrlSetData($lblResultBuilderNowAcc[$i], $aFreeBuilderCountAcc[$i] & "/" & $aTotalBuilderCountAcc[$i])

	   ; gain stats
	   GUICtrlSetData($lblGoldLootAcc[$i], _NumberFormat($aGoldTotalAcc[$i]))
	   GUICtrlSetData($lblHourlyStatsGoldAcc[$i], _NumberFormat(Round($aGoldTotalAcc[$i] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "K / h")

	   GUICtrlSetData($lblElixirLootAcc[$i], _NumberFormat($aElixirTotalAcc[$i]))
	   GUICtrlSetData($lblHourlyStatsElixirAcc[$i], _NumberFormat(Round($aElixirTotalAcc[$i] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "K / h")

	   If $g_iStatsStartedWith[$eLootDarkElixir] <> "" Then
		  GUICtrlSetData($lblDarkLootAcc[$i], _NumberFormat($aDarkTotalAcc[$i]))
		  GUICtrlSetData($lblHourlyStatsDarkAcc[$i], _NumberFormat(Round($aDarkTotalAcc[$i] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)) & " / h")
	   EndIf

	   GUICtrlSetData($lblTrophyLootAcc[$i], _NumberFormat($aTrophyLootAcc[$i]))
	   GUICtrlSetData($lblHourlyStatsTrophyAcc[$i], _NumberFormat(Round($aTrophyLootAcc[$i] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)) & " / h")

	Next		; ============= Update Gain stats per each account

	If $g_iFirstAttack = 2 Then
		GUICtrlSetData($g_hLblResultGoldHourNow, _NumberFormat(Round($aGoldTotalAcc[$nCurProfile-1] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "K / h") ;GUI BOTTOM
		GUICtrlSetData($g_hLblResultElixirHourNow, _NumberFormat(Round($aElixirTotalAcc[$nCurProfile-1] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "K / h") ;GUI BOTTOM
		If $g_iStatsStartedWith[$eLootDarkElixir] <> "" Then
			GUICtrlSetData($g_hLblResultDEHourNow, _NumberFormat(Round($aDarkTotalAcc[$nCurProfile-1] / (Int(TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)) & " / h") ;GUI BOTTOM
		EndIf
	EndIf		; ============= Update Gain Stats at Bottom GUI

EndFunc   ;==>UpdateStatsForSwitchAcc

Func ResetStatsForSwitchAcc()

	For $i = 0 To $nTotalProfile-1 ; SwitchAcc Mod - Demen
	   $aGoldTotalAcc[$i] = 0
	   $aElixirTotalAcc[$i] = 0
	   $aDarkTotalAcc[$i] = 0
	   $aTrophyLootAcc[$i] = 0
	   $aAttackedCountAcc[$i] = 0
	   $aSkippedVillageCountAcc[$i] = 0
	Next

EndFunc   ;==>ResetStatsForSwitchAcc
