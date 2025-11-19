#IfWinActive AMAZING ONLINE
#Include UDF.ahk
#SingleInstance Force
#NoEnv
ListLines Off
SetBatchLines -1
SetKeyDelay -1
#KeyHistory 0

LAlt & 1::
sendChat("/job")
sleep 200
Send, {Down 13}
sleep 200
Send, {Enter}
return

LAlt & 2::
sendChat("/job")
sleep 200
Send, {Down 1}
sleep 200
Send, {Enter}
sleep 200
Send, {Enter}
return

LAlt & 3::
sendChat("/job")
sleep 200
Send, {Down 2}
sleep 200
Send, {Enter}
sleep 200
Send, {Down 1}
sleep 200
Send, {Enter}
sleep 200
Send, {Enter}
sleep 200
Send, {Enter}
return
