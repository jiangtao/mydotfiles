set cmd to ""
tell application "Finder"
    set theWindow to window 1
    set thePath to (POSIX path of (target of theWindow as alias))
    set cmd to "cd " & "\"" & thePath & "\""
    
end tell

tell application "Terminal"
    activate
    tell application "System Events" to keystroke "t" using command down

    delay 0.5
    do script cmd in window 1
end tell