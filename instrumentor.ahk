appCollection := "apps.txt" ; a list of app URLs
applePassword := "**********************"
waitTime := 5000 ; wait time between download attempts in seconds. Should leave enough time for iTunes to download an average app.
DownloadsDir := "C:\Users\Konrad\Music\iTunes\iTunes Media\Downloads" ; adapt to your environment
Restart := 100 ; how often iTunes is closed and restarted to overcome issues

iTunes := StartTunes()

; Save progress in file
Loop, read, instrumentorStatus.txt
{
    StoppedAt := A_LoopReadLine
}
If LastLine == "" ; if instrumentorStatus.txt does not exist
    StoppedAt := 0
i := 0

Loop, read, %appCollection%
{
    i := i + 1
    If (i <= StoppedAt)
        Continue

    ; Reset iTunes regularly, just in case
    If (Mod(A_Index, %Restart%) = 0)
    {
        Sleep, %waitTime%
        KillTunes()
        Sleep, %waitTime%
        Loop, %DownloadsDir%\*.*, 1, 0
        {
            If InStr(A_LoopFileAttrib, "D")
                FileRemoveDir, %A_LoopFileLongPath%, 1
            Else
                FileSetAttrib, -RASH, %A_LoopFileLongPath%
                FileDelete, %A_LoopFileLongPath%
        }
        iTunes := StartTunes()
    }
    
    url := A_LoopReadLine
    url := StrReplace(url, "https://", "itmss://") ; use correct protocol
    
    ; Open App in store
    try
    {
        iTunes.OpenURL(url)
    }
    catch e
    {
        iTunes := StartTunes()
    }

    ; Download App
    Sleep, %waitTime%
    WinActivate, iTunes
    If GetLoginWindow() <> ""
       Login()
    CloseAnyPopups()
    MouseClick, left, 130, 410

    ; Save progress
    FileAppend, `n%url%`n%i%, instrumentorStatus.txt
}

CloseAnyPopups()
{
    If WinExist("ahk_class iTunesCustomModalDialog")
    {
        WinActivate
        WinGetText, windowText
        If (InStr(windowText, "&Buy") || InStr(windowText, "Item Not Available") || InStr(windowText, "not installed correctly")) {
            Send, {Escape}
        }
        Else If InStr(windowText, "This update is free.") {
            Send, {Left}{Enter}
        }
        Else {
            Send, {Enter}
        }        
        Sleep, 1000
        CloseAnyPopups()
    }
}

GetLoginWindow()
{
    WinGet, Windows, List , iTunes
    If (Windows > 1) {
        Loop %Windows% {
            active_id := Windows%A_Index%

            WinGetText, windowText, ahk_id %active_id%
            if InStr(windowText, "iforgot.apple.com")
                return %active_id%
        }
    }
    return ""
}

Login()
{
    global applePassword
    Sleep, 1000
    Send, %applePassword%{Enter}
    Sleep, 10000
}

StartTunes()
{
    Run, C:\Program Files\iTunes\iTunes.exe
    Sleep, 1000
    CloseAnyPopups()
    iTunes := ComObjCreate("iTunes.Application") ; starts iTunes if not active
    WinWait, iTunes
    return iTunes
}

KillTunes()
{
    run,%comspec% /k taskkill /F /IM iTunes.exe && exit
}
