; <COMPILER: v1.1.37.01>
#IfWinActive AMAZING ONLINE
#Include UDF.ahk
#SingleInstance Force
#NoEnv
global lastArrestTime := 0
ListLines Off
SetBatchLines -1
SetKeyDelay -1
#KeyHistory 0
global buildscr := 5
global strings=1
IfNotExist, %A_ScriptDir%\3.mp3
{
    URLDownloadToFile, %mp3_1%, %A_ScriptDir%\3.mp3
}
IfNotExist, %A_ScriptDir%\settings.ini
{
    URLDownloadToFile, %settings%, %A_ScriptDir%\settings.ini
}
Menu, Tray, NoStandard
Menu, Tray, Add, Автор скрипта, OpenAuthor
Menu, tray, add
Menu, Tray, Add, Перезагрузить, LABEL_RELOAD
Menu, Tray, Add, Закрыть, LABEL_EXIT
start_gui:
IniRead, dire, %A_ScriptDir%\settings.ini, SETTINGS, way
IniRead, Server, %A_ScriptDir%\settings.ini, SETTINGS, vServer
global CRMP_USER_NICKNAME:="Неизвестный_ник"
global ServerNumber := Server
ServerList := "RED|YELLOW|GREEN|AZURE|SILVER|ROSE|BLACK|SKY|"
global NewServerList := StrReplace(ServerList, ServerNumber, ServerNumber "|")
global ServerN := ""
global playerMask := -1
global playerID := -1
global RegplayerMask = -1
global RegplayerId = -1
global RegHomeId = -1
IniRead, KeyOne, %A_ScriptDir%\settings.ini, SETTINGS, vKeyOne
IniRead, Rozisk, %A_ScriptDir%\settings.ini, SETTINGS, vRozisk
IniRead, KeyThree, %A_ScriptDir%\settings.ini, SETTINGS, vKeyThree
IniRead, KeyFour, %A_ScriptDir%\settings.ini, SETTINGS, vKeyFour
IniRead, KeyFive, %A_ScriptDir%\settings.ini, SETTINGS, vKeyFive
IniRead, KeySix, %A_ScriptDir%\settings.ini, SETTINGS, vKeySix
IniRead, KeySeven, %A_ScriptDir%\settings.ini, SETTINGS, vKeySeven
IniRead, KeyEight, %A_ScriptDir%\settings.ini, SETTINGS, vKeyEight
IniRead, KeyNine, %A_ScriptDir%\settings.ini, SETTINGS, vKeyNine
IniRead, Mask, %A_ScriptDir%\settings.ini, SETTINGS, vMask
IniRead, Teg, %A_ScriptDir%\settings.ini, SETTINGS, vTeg
IniRead, Dolzhnost, %A_ScriptDir%\settings.ini, SETTINGS, vDolzhnost
IniRead, ProbivGosId, %A_ScriptDir%\settings.ini, SETTINGS, vProbivGosId
IniRead, KeyPolice, %A_ScriptDir%\settings.ini, SETTINGS, vKeyPolice
IniRead, TegText, %A_ScriptDir%\settings.ini, SETTINGS, vTegText
IniRead, KeyVesti, %A_ScriptDir%\settings.ini, SETTINGS, vKeyVesti
IniRead, KeyCar, %A_ScriptDir%\settings.ini, SETTINGS, vKeyCar
IniRead, KeyCars, %A_ScriptDir%\settings.ini, SETTINGS, vKeyCars
IniRead, KeyProbiv, %A_ScriptDir%\settings.ini, SETTINGS, vKeyProbiv
IniRead, KeyPosadi, %A_ScriptDir%\settings.ini, SETTINGS, vKeyPosadi
IniRead, KeyProtokol, %A_ScriptDir%\settings.ini, SETTINGS, vKeyProtokol
IniRead, 1help, %A_ScriptDir%\settings.ini, SETTINGS, v1help
IniRead, 2help, %A_ScriptDir%\settings.ini, SETTINGS, v2help
IniRead, 3help, %A_ScriptDir%\settings.ini, SETTINGS, v3help
IniRead, vivs, %A_ScriptDir%\settings.ini, SETTINGS, vvivs
IniRead, ProbivGos, %A_ScriptDir%\settings.ini, SETTINGS, vProbivGos
if(TegText == "ERROR") {
    global TegText := "УФСБ"
}
IniRead, KeyUnmask, %A_ScriptDir%\settings.ini, SETTINGS, vKeyUnmask
global Sleep := 0
IniRead, Sleep, %A_ScriptDir%\settings.ini, SETTINGS, vSleep
if (Sleep = "ERROR") {
    Sleep := 150
}
Gui Add, Tab3, x8 y3 w605 h690, Настройки клавиш
Gui Tab, 1
Gui Add, Edit, vDire x168 y35 w314 h22, %dire%
Gui Add, Button, gKey x504 y32 w90 h26, Выбрать
Gui Add, Text, x23 y32 w125 h25 +0x200 , Выбрать папку
Gui Add, Text, x23 y69 w125 h25 +0x200 , Выберите сервер
Gui Add, Text, x350 y69 w125 h25 +0x200 , Время сна
Gui Add, Edit, vSleep x450 y69 w90 h22, %Sleep%
Gui Add, Text, x23 y110 w125 h25 +0x200 , Ввести ID
Gui Add, Edit, vKeyOne x167 y110 w90 h22, %KeyOne%
Gui Add, Text, x23 y150 w125 h25 +0x200 , /chase
Gui Add, Text, x23 y191 w125 h25 +0x200 , /cuff
Gui Add, Edit, vKeyThree x168 y152 w90 h22, %KeyThree%
Gui Add, Edit, vKeyFour x168 y191 w90 h22, %KeyFour%
Gui Add, Text, x23 y231 w125 h25 +0x200 , Миранда
Gui Add, Text, x23 y272 w125 h25 +0x200 , Представиться
Gui Add, Text, x23 y312 w125 h25 +0x200 , Достать из автомобиля
Gui Add, Text, x23 y352 w125 h25 +0x200 , Список разыскиваемых
Gui Add, Text, x23 y392 w125 h25 +0x200 , Требование остановки
Gui Add, Text, x23 y432 w125 h25 +0x200 , Тэг
Gui Add, Text, x23 y472 w125 h25 +0x200 , Первое окно подсказки
Gui Add, Text, x23 y512 w125 h25 +0x200 , Окно подсказки /d
Gui Add, Text, x23 y552 w125 h25 +0x200 , Окно ПП/СВУ
Gui Add, Text, x23 y592 w125 h25 +0x200 , Пробив /find гос
Gui Add, Edit, vTegText x167 y432 w90 h22, %TegText%
Gui Add, Edit, v1help x167 y472 w90 h22, %1help%
Gui Add, Edit, v2help x167 y512 w90 h22, %2help%
Gui Add, Edit, v3help x167 y552 w90 h22, %3help%
Gui Add, Edit, vProbivGos x167 y592 w90 h22, %ProbivGos%
Gui Add, Edit, vKeyFive x167 y231 w90 h22, %KeyFive%
Gui Add, Edit, vKeySix x168 y273 w90 h22, %KeySix%
Gui Add, Edit, vKeySeven x167 y312 w90 h22, %KeySeven%
Gui Add, Edit, vKeyEight x167 y352 w90 h22, %KeyEight%
Gui Add, Edit, vKeyNine x167 y392 w90 h22, %KeyNine%
Gui Add, ComboBox, vServer x168 y70 w120, %NewServerList%
Gui Add, Text, x330 y110 w75 h25 +0x200 , Позывной
Gui Add, Edit, vTeg x431 y110 w90 h25, %Teg%
Gui Add, Text, x330 y150 w90 h25 +0x200 , Должность
Gui Add, Edit, vDolzhnost x431 y150 w90 h25, %Dolzhnost%
Gui Add, Text, x330 y190 w90 h25 +0x200 , Маска
Gui Add, Edit, vMask x431 y190 w90 h25, %Mask%
Gui Add, Text, x330 y230 w90 h25 +0x200 , Пробив id
Gui Add, Edit, vProbivGosId x431 y230 w90 h25, %ProbivGosId%
Gui Add, Text, x330 y270 w90 h25 +0x200 , /police
Gui Add, Edit, vKeyPolice x431 y270 w90 h25, %KeyPolice%
Gui Add, Text, x330 y312 w125 h25 +0x200 , Вести за собой
Gui Add, Edit, vKeyVesti x431 y312 w90 h25, %KeyVesti%
Gui Add, Text, x330 y350 w125 h25 +0x200 , Розыск
Gui Add, Edit, vRozisk x431 y350 w90 h25, %Rozisk%
Gui Add, Text, x330 y390 w125 h25 +0x200 , Эвакуация
Gui Add, Edit, vKeyCar x431 y390 w90 h25, %KeyCar%
Gui Add, Text, x330 y430 w125 h25 +0x200 , Сдача на штрафку
Gui Add, Edit, vKeyCars x431 y430 w90 h25, %KeyCars%
Gui Add, Text, x330 y470 w125 h25 +0x200 , Пробить (радар)
Gui Add, Edit, vKeyProbiv x431 y470 w90 h25, %KeyProbiv%
Gui Add, Text, x330 y510 w125 h25 +0x200 , Посадить в авто
Gui Add, Edit, vKeyPosadi x431 y510 w90 h25, %KeyPosadi%
Gui Add, Text, x330 y550 w125 h25 +0x200 , Протокол (ИВС)
Gui Add, Edit, vKeyProtokol x431 y550 w90 h25, %KeyProtokol%
Gui Add, Text, x330 y590 w125 h25 +0x200 , Передача в ИВС
Gui Add, Edit, vvivs x431 y590 w90 h25, %vivs%
Gui Tab
Gui Add, Button, gKeySave x519 y700 w90 h26, Сохранить
Gui Add, Button, gOpenLink x8 y700 w108 h26, Сообщить о баге
Gui Add, Button, gDonate x262 y700 w108 h26, Поддержать проект
Gui Show, w617 h732, Настройки
Return
GuiEscape:
GuiClose:
ExitApp
key:
FileSelectFolder, SelectedFile, 3, %dire%
if SelectedFile =
return
else
IniWrite, %SelectedFile%, %A_ScriptDir%\settings.ini, SETTINGS, way
Gui, Destroy
goto start_gui
keySave:
GuiControlGet, Dire
IniWrite, %Rozisk%, %A_ScriptDir%\settings.ini, SETTINGS, vRozisk
GuiControlGet, Rozisk
IniWrite, %dire%, %A_ScriptDir%\settings.ini, SETTINGS, way
GuiControlGet, KeyOne
IniWrite, %KeyOne%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyOne
GuiControlGet, KeyThree
IniWrite, %KeyThree%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyThree
GuiControlGet, KeyFour
IniWrite, %KeyFour%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyFour
GuiControlGet, KeyFive
IniWrite, %KeyFive%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyFive
GuiControlGet, KeySix
IniWrite, %KeySix%, %A_ScriptDir%\settings.ini, SETTINGS, vKeySix
GuiControlGet, KeySeven
IniWrite, %KeySeven%, %A_ScriptDir%\settings.ini, SETTINGS, vKeySeven
GuiControlGet, KeyEight
IniWrite, %KeyEight%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyEight
GuiControlGet, Dolzhnost
IniWrite, %Dolzhnost%, %A_ScriptDir%\settings.ini, SETTINGS, vDolzhnost
GuiControlGet, ProbivGosId
IniWrite, %ProbivGosId%, %A_ScriptDir%\settings.ini, SETTINGS, vProbivGosId
GuiControlGet, Mask
IniWrite, %Mask%, %A_ScriptDir%\settings.ini, SETTINGS, vMask
GuiControlGet, TegText
IniWrite, %TegText%, %A_ScriptDir%\settings.ini, SETTINGS, vTegText
GuiControlGet, SOS
IniWrite, %SOS%, %A_ScriptDir%\settings.ini, SETTINGS, vSOS
GuiControlGet, Sleep
IniWrite, %Sleep%, %A_ScriptDir%\settings.ini, SETTINGS, vSleep
GuiControlGet, KeyNine
IniWrite, %KeyNine%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyNine
GuiControlGet, Teg
IniWrite, %Teg%, %A_ScriptDir%\settings.ini, SETTINGS, vTeg
GuiControlGet, KeyPolice
IniWrite, %KeyPolice%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyPolice
GuiControlGet, KeyVesti
IniWrite, %KeyVesti%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyVesti
GuiControlGet, Server
IniWrite, %Server%, %A_ScriptDir%\settings.ini, SETTINGS, vServer
GuiControlGet, KeyCar
IniWrite, %KeyCar%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyCar
GuiControlGet, KeyCars
IniWrite, %KeyCars%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyCars
GuiControlGet, KeyProbiv
IniWrite, %KeyProbiv%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyProbiv
GuiControlGet, KeyPosadi
IniWrite, %KeyPosadi%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyPosadi
GuiControlGet, KeyProtokol
IniWrite, %KeyProtokol%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyProtokol
GuiControlGet, 1help
IniWrite, %1help%, %A_ScriptDir%\settings.ini, SETTINGS, v1help
GuiControlGet, 2help
IniWrite, %2help%, %A_ScriptDir%\settings.ini, SETTINGS, v2help
GuiControlGet, 3help
IniWrite, %3help%, %A_ScriptDir%\settings.ini, SETTINGS, v3help
GuiControlGet, vivs
IniWrite, %vivs%, %A_ScriptDir%\settings.ini, SETTINGS, vvivs
GuiControlGet, ProbivGos
IniWrite, %ProbivGos%, %A_ScriptDir%\settings.ini, SETTINGS, vProbivGos
Switch Server
{
    Case "Red":
    ServerNumber := 0
    Case "Yellow":
    ServerNumber := 1
    Case "Green":
    ServerNumber := 2
    Case "Azure":
    ServerNumber := 3
    Case "Silver":
    ServerNumber := 4
    Case "Rose":
    ServerNumber := 5
    Default:
    MsgBox, 16, Error, Invalid server name
    Return
}
RegRead, CRMP_USER_NICKNAME, HKEY_CURRENT_USER, SOFTWARE\Amazing\Russia\Nicknames, %ServerNumber%
if(CRMP_USER_NICKNAME=="")
{
    NewServerNumber := ServerNumber + 1
    RegRead, CRMP_USER_NICKNAME, HKEY_CURRENT_USER, SOFTWARE\Amazing\vcn\Online\Saves\Nicknames, %NewServerNumber%
    if(CRMP_USER_NICKNAME=="")
    {
        MsgBox, 16, Nickname не найден, Установите ник в лаунчере в меню выбранного в скрипте сервера
        CRMP_USER_NICKNAME:="Неизвестный_ник_после_ошибки"
        return
    }
}
ServerN = %Server%
Gui, Destroy
Hotkey,%KeyCar%,KeyCar
Hotkey,%KeyCars%,KeyCars
Hotkey,%Rozisk%,Rozisk
Hotkey,%KeyOne%,KeyOne
Hotkey,%KeyThree%,KeyThree
Hotkey,%KeyFour%,KeyFour
Hotkey,%KeyFive%,KeyFive
Hotkey,%KeySix%,KeySix
Hotkey,%KeySeven%,KeySeven
Hotkey,%KeyEight%,KeyEight
Hotkey,%KeyNine%,KeyNine
Hotkey,%KeyPolice%,KeyPolice
Hotkey,%KeyVesti%,KeyVesti
Hotkey,%KeyPosadi%,KeyPosadi
Hotkey,%KeyProtokol%,KeyProtokol
Hotkey,%1help%,1help
Hotkey,%2help%,2help
Hotkey,%3help%,3help
Hotkey,%KeyProbiv%,KeyProbiv
Hotkey,%vivs%,vivs
Hotkey,%ProbivGos%,ProbivGos
Hotkey,%ProbivGosId%,ProbivGosId
IniRead, dire, %A_ScriptDir%\settings.ini, SETTINGS, way
way = %dire%\amazing\chatlog.txt
FileDelete, %way%
TrayTip, AHK, AHK запущен (в игре будет запущен через 10 секунд). Приятного пользования!, 1
WinWaitActive, AMAZING ONLINE, , 30
if ErrorLevel
{
    MsgBox, 1, Ошибка, Вы не открыли окно игры в течении 30 секунд. Нажмите ОК для повторения ожидания`n`nДля выключения скрипта нажмите кнопку ОТМЕНА
    IfMsgBox OK
    reload
    else
    ExitApp
}
else
{
    IniRead, TIME_SLEEP, %A_ScriptDir%\settings.ini, SETTINGS, TIME_SLEEP
    if(TIME_SLEEP == "ERROR" || TIME_SLEEP < 1000)
    {
        sleep 3000
    }
    else {
        sleep %TIME_SLEEP%
    }
    loadInGame()
    FileDelete, %way%
    Goto, start
}
start:
FileReadLine, line, %way%, strings
{
    if ErrorLevel
    {
        goto start
    }
    else
    {
    if line contains Вы оглушили
    {
    	if (InStr(line, "с помощью дубинки") or InStr(line, "с помощью электрошокера"))
    	{
        	if (InStr(line, "Неизвестный ["))
        	{
            	RegExMatch(line, "Вы оглушили Неизвестный \[(.*)\] с помощью", pmask)
            	saveMask(pmask1)
        	}
		else {
		RegExMatch(line, "Вы оглушили (.*) с помощью", name)
		name1 := RegExReplace(name1, "[^а-яА-Яa-zA-Z0-9_]")
		sendChat("/id " name1)
        	}
    	}
    }
    if line contains Игроки онлайн:
    {
	str := strings+=2
	sleep 25
	FileReadLine, nick, %way%, %str%
	if(InStr(nick, "Совпадений не найдено")) {
	} else {
	RegExMatch(nick, "\}\[(.*)\]", pid)
	saveID(pid1)
        }
    }
    if line contains [R] Внимание всем постам
    {
        If(InStr(line, "Сработала сигнализация дома"))
        {
            RegExMatch(line, "Сработала сигнализация дома (.*), возможно", pid)
            RegHomeId := pid1
       	addChatMessageEx(-1, "{58e11b}[Диспетчер]{FFFFFF} Вы хотите отметить дом {58e11b}" RegHomeId " {FFFFFF}в GPS? Для этого используйте {58e11b}LAlt & H")
        }
    }
    if line contains [R] Внимание всем постам
    {
        If(InStr(line, "Сработала сигнализация особняка"))
        {
            RegExMatch(line, "Сработала сигнализация особняка (.*), возможно", pid)
            RegOsobaId := pid1
       	addChatMessageEx(-1, "{58e11b}[Диспетчер]{FFFFFF} Вы хотите отметить особняк {58e11b}" RegOsobaId " {FFFFFF}в GPS? Для этого используйте {58e11b}RAlt & H")
        }
    }
    if line contains выписал(-а) штраф
    {
        if (InStr(line, CRMP_USER_NICKNAME) or InStr(line, Mask))
        {
	    TakeScreenshot()
            addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Вы выписали штраф игроку")
            Sleep 20000
            addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Кд на штраф прошло")
        }
    } 
    if line contains арестовал преступника
    {
	if (InStr(line, CRMP_USER_NICKNAME) or InStr(line, Mask))
    	{
            now := A_TickCount
            if (now - lastArrestTime > 1000)
            {
            	lastArrestTime := now
            	TakeScreenshot()
            	addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Вы арестовали игрока")
            }
        }
    }
    if line contains начал преследование за
    {
        if (InStr(line, CRMP_USER_NICKNAME))
        {
            RegExMatch(line, "начал преследование за (.*)_(.*) \[(\d\d?\d?)\]", playeridid)
            saveID(playeridid3)
        }
    }    
	if line contains запросил местоположение
    {
        if (InStr(line, CRMP_USER_NICKNAME))
        {
            RegExMatch(line, "запросил местоположение (.*)_(.*) \[(\d\d?\d?)\]", playeridid)
            saveID(playeridid3)
        }
    }
    strings+=1
    goto start
}
}
OpenLink:
Run, https://www.youtube.com/watch?v=dQw4w9WgXcQ
Return
Donate:
Run, https://www.youtube.com/watch?v=dQw4w9WgXcQ
Return
OpenAuthor:
Run, https://vk.com/id1042741763
Return

TakeScreenshot() {
sleep 500
SendInput, {sc42 down}
sleep 10
SendInput, {sc42 up}
}

KeyOne:
SendMessage, 0x50,, 0x4190419,, A
SendInput {sc40}
Sleep 100
SendInput, /Введите ID подозреваемого:{space}
Sleep 50
Input, playerID, I L6 V, {Enter}
if (playerId >= 0 && playerId <= 1000) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} В системе зарегистрирован новый ID: {58e11b}" playerID)
playerMask := -1
Send, ^a
sleep 2
} else if(playerId >= 1001 && playerId <= 9999999) {
if playerID >= 1001
SendInput {sc1C} 
playerMask := playerId
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} В системе зарегистрирована новая маска: {58e11b}" playerMask)
playerID := -1
Send, ^a
sleep 25
} else {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} ID должен быть числом от 0 до 1000")
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Маска должна быть числом от 1001 до 999999")
}
return

KeyThree:
if(playerID >= 0) {
sendChat("/chase " playerID)
}
else if(playerMask >= 1001){
sendChat("/chaseid " playerMask)
}
else if (playerID < 0 or playerMask < 0) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Маска или ID не зарегистрированны в системе")
}
return

KeyFour:
if(playerID >= 0) {
sendChat("/cuff " playerID)
}
if(playerMask >= 1001){
sendChat("/cuffid " playerMask)
}
else if (playerID < 0 and playerMask < 0) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Маска или ID не зарегистрированны в системе")
}
return

KeyFive:
SendChat("Вам предоставляются следующие права:")
Sleep 1000
SendChat("Право не свидетельствовать против себя и своих близких.")
Sleep 1250
SendChat("Право на ознакомление с всеми протоколами, составленными при задержании.")
Sleep 1250
SendChat("Право на обжалование действий сотрудников правоохранительных органов в судебном порядке.")
Sleep 1250
SendChat("Право на юридическую помощь в лице адвоката и телефонный звонок.")
Sleep 1250
return

KeySix:
sendChat("Здравия желаю, я - " . Dolzhnost . ", мой позывной " . Teg . ".")
return

Rozisk:
sendChat("/me движением рук достал из кармана Apple iPad Pro и стилус")
sleep 800
sendChat("/do Apple iPad Pro и стилус в руках.")
sleep 800
sendChat("/me движением пальц перешел во вкладку рисовать")
sleep 800
sendChat("/me движением рук нарисовал фоторобот подозреваемого")
sleep 800
sendChat("/me движением рук достал переходник и КПК из кармана")
sleep 800
sendChat("/do Переходник и КПК в руках.")
sleep 800
sendChat("/me движением рук подключил переходник к КПК и iPad")
sleep 800
sendChat("/me движением пальц перекинул фоторобот подозреваемого в КПК")
sleep 800
sendChat("/do Фоторобот подозреваевого находиться в КПК.")
sleep 800
sendChat("/me движением пальц зашел в базу данных и перекинул фоторобот подозреваемого")
sleep 800
sendChat("/me подчеркнул его приметы и нажал на пункт в розыск")
sleep 800
sendChat("/do Добавил подозреваемого в розыск.")
sleep 800
sendChat("/su " playerID)
return

KeySeven:
if(playerID >= 0) {
sendChat("/deject " playerID)
}
else if(playerMask >= 1001){
sendChat("/dejectid " playerMask)
}
else if (playerID < 0 or playerMask < 0) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Маска или ID не зарегистрированны в системе")
}
return

KeyEight:
sendChat("/frac")
sleep %Sleep%
SendInput, {1}{1}
sleep %Sleep%
SendInput, {1}{1}
sleep %Sleep%
SendInput, {2}{2}
return

KeyNine:
sendChat("/m [" . TegText . "] Внимание! Принимаем правое положение и делаем остановку!")
sleep 600
sendChat("/m [" . TegText . "] В случае неподчинения мы будем открывать огонь!")
return

KeyPolice:
SendChat("/me нажимает на кнопку включения проблесковых маячков")
Sleep 600
SendChat("/police")
return

KeyVesti:
sendChat("/frac " playerID)
sleep 300
SendInput, {1}{1}
sleep 300
SendInput, {4}{4}
if (playerID < 0) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} ID не зарегистрирован в системе")
}
return

LAlt & B::
sleep 50
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff}Внимание. Вы запустили перезагрузку скрипта!")
reload
return
loadInGame() {
if (!checkHandles())
checkHandles()
Sleep 1500
addChatMessageEx(0, "          ")
addChatMessageEx(0, "{58e11b}[Диспетчер]{FFFFFF} Приветствуем, {58e11b}" . CRMP_USER_NICKNAME)
addChatMessageEx(0, "{58e11b}[Диспетчер]{FFFFFF} Ассистент для сотрудников ФСБ. {58e11b}успешно запущен")
addChatMessageEx(0, "{58e11b}[Диспетчер]{FFFFFF} Нашли ошибку или хотите предложить идею? VK - {58e11b}@id1042741763")
addChatMessageEx(0, "          ")
}
LABEL_RELOAD:
Reload
return
LABEL_EXIT:
ExitApp
Return

saveID(playerID) {
RegplayerId := playerID
addChatMessageEx(-1, "{58e11b}[Диспетчер]{FFFFFF} Вы хотите внести ID игрока {58e11b}" RegplayerId " {FFFFFF}в систему? Для этого используйте {58e11b}LAlt & E")
}
return

saveMask(maskID) {
RegplayerMask := maskID
addChatMessageEx(-1, "{58e11b}[Диспетчер]{FFFFFF} Вы хотите внести маску игрока {58e11b}" maskID " {FFFFFF}в систему? Для этого используйте {58e11b}LAlt & Q")
}
return

LAlt & Q::
if(RegplayerMask == -1) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} У Вас нет маски, которую нужно зарегистрировать")
}
else {
playerMask := RegplayerMask
addChatMessageEx(-1, "{58e11b}[Диспетчер]{FFFFFF} Маска {58e11b}" playerMask " {FFFFFF}зарегистрирована")
}
return

LAlt & E::
if(RegplayerId == -1) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} У Вас нет ID игрока, которую нужно зарегистрировать")
}
else {
playerId := RegplayerId
addChatMessageEx(-1, "{58e11b}[Диспетчер]{FFFFFF} ID игрока {58e11b}" playerId " {FFFFFF}зарегистрирован")
}
return

LAlt & H::
if(RegHomeId == -1) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} У Вас нет дома, который нужно отметить")
}
else {
sendChat("/gps")
sleep %Sleep%
Send, {Down 15}
sleep 250
Send, {Enter}
sleep %Sleep%
Send % RegHomeId
sleep %Sleep%
Send, {Enter}
}
return

RAlt & H::
if(RegOsobaId == -1) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} У Вас нет особняка, который нужно отметить")
}
else {
sendChat("/gps")
sleep %Sleep%
Send, {Down 16}
sleep 250
Send, {Enter}
sleep %Sleep%
Send % RegOsobaId
sleep %Sleep%
Send, {Enter}
}
return

KeyProtokol:
SendChat("/do Протокол о задержании и ручка находятся на столе.")
Sleep 1000
SendChat("/me правой рукой берёт ручку, затем заполняет в бланке данные задержанного, свои данные, место, время, причины и обстоятельства задержания")
Sleep 1000
SendChat("/me ставит подпись на бланке")
Sleep 1000
Return

ProbivGos:
SendChat("/me снимает с пояса КПК, после чего авторизуется в нём и пробивает информацию")
sleep 1000
sendChat("/frac")
sleep 300
SendInput, {1}{1}
sleep %Sleep%
SendInput, {1}{1}
sleep %Sleep%
SendInput, {5}{5}
Return

ProbivGosId:
if(RegplayerId == -1) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} У Вас нет зарегистрированного ID игрока.")
}
else {
SendChat("/me снимает с пояса КПК, после чего авторизуется в нём и вводит информацию")
sleep 1000
sendChat("/frac")
sleep 300
SendInput, {1}{1}
sleep %Sleep%
SendInput, {3}{3}
sleep %Sleep%
SendInput, {3}{3}
sleep %Sleep%
Send % playerID
sleep %Sleep%
Send, {Enter}
}
Return

LAlt & 9::
sendChat("/fvoice")
Sleep 500
sendChat("/famvoice")
Return 

RAlt & 9::
sendChat("/fvoice")
Sleep 500
sendChat("/famvoice")
Return 

KeyCar:
SendChat("/do Бортовой компьютер включён.")
Sleep 1000
SendChat("/me открывает панель управления эвакуатором")
Sleep 1000
SendChat("/me управляя тросом через программу, начинает буксировку")
Sleep 1000
SendChat("/me цепляет тросом эвакуатора автомобиль")
Sleep 1000
SendChat("/tow")
Sleep 1000
SendChat("/crash")
Return

KeyCars:
SendChat("/me снимает с пояса рацию, после чего вызывает дежурного по штрафстоянке и вешает рацию обратно на пояс")
Sleep 1000
SendChat("/me достаёт КПК из правого кармана, авторизовывается и вносит информацию, далее убирает КПК в правый карман")
Sleep 1000
SendChat("/me управляя тросом через программу отцепляет автомобиль")
Sleep 1000
sendChat("/frac")
sleep 300
SendInput, {1}{1}
sleep %Sleep%
SendInput, {3}{3}
sleep %Sleep%
SendInput, {8}{8}
Return

:?:!кор5::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%] Ввожу корректировки в ЛД № по статье 5 ПК.{left 16}
Return

:?:!кор7::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%] Ввожу корректировки в ЛД № по статье 7 ПК.{left 16}
Return

:?:!протокол::
sendChat("/me взял бланк протокола об АПН в руки, после чего начал заполнять")
Sleep 1000
sendChat("/me Внёс в протокол об АПН такю информацию, как: ФИО инспектора и гражданина; серию и номер документа удостоверяющего личность гражданина; место, время и обстоятельства совершения нарушения; поставил свою подпись")
Sleep 2000
sendChat("Ознакамливаться с протоколом и подписывать будете?")
Return 

:?:!док::
sendChat("/do В нагрудном кармане удостоверение.")
Sleep 500
sendChat("/me достал из нагрудного кармана удостоверение показал его не передавая в руки")
Sleep 500
sendChat("/me ..затем свернул удостоверение и убрал обратно в нагрудный карман")
Return

KeyProbiv:
sendChat("/frac")
Sleep 250
sendInput {sc2}{sc2}
Sleep 250
sendInput {sc4}{sc4}
Sleep 250
SendInput {sc4}{sc4}
Sleep 400
SendInput %playerID%{sc1c}
Return

KeyPosadi:
sendChat("/me открыл дверь автомобиля, затем посадил гражданина в авто")
Sleep 450
sendChat("/do Задержанный в автомобиле.")
Sleep 450
sendChat("/me пристегнул ремень безопасности, затем закрыл дверь автомобиля")
Sleep 450
sendChat("/incar " playerID)
Return

vivs:
sendChat("/me показывает протокол о задержании на уровне глаз задержанного")
Sleep 750
sendChat("/me достаёт рацию, настраивает волну с дежурным и подносит к рту")
Sleep 750
sendChat("/todo У меня задержанный, подходи * держа в руке рацию")
Sleep 750
sendChat("/do Дежурный подошёл.")
Sleep 750
sendChat("/me передаёт задержанного дежурному вместе с протоколом о задержании")
Sleep 750
sendChat("/do Дежурный ушёл с задержанным и протоколом о задержании.")
Sleep 750
sendChat("/frac " playerID)
sleep 450
SendInput, {1}{1}
sleep 450
SendInput, {5}{5}
sleep 450
SendInput, {8}{8}
Return

:?:!дп::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%] Говорит %Teg%, на связь{!} {left 1}
Return

:?:!вн::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%] Говорит %Teg%. Вызов срочной помощи внутренний.{left 1}
Return

:?:!дпп::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%] %Dolzhnost% с личным позывным - %Teg% на связи, слушаю Вас...{left 1}
Return

:?:!увд::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/УМВД] Говорит %Teg%, на связь{!} {left 1}
Return

:?:!увдд::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/УМВД] %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!вчч::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ВЧ] %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!вч::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ВЧ] Говорит %Teg%, на связь{!} {left 1}
Return

:?:!пр::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ПР] Говорит %Teg%, на связь{!} {left 1}
Return

:?:!прр::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ПР] %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!ес::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ЕСС] Говорит %Teg%, на связь{!} {left 1}
Return

:?:!есс::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ЕСС] %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!фс::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/УФСИН] Говорит %Teg%, на связь{!} {left 1}
Return

:?:!фсс::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/УФСИН] %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!гаи::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ГИБДД] Говорит %Teg%, на связь{!} {left 1}
Return

:?:!гаии::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ГИБДД] %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!поме::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%] Говорит %Teg%. Помехи от нас. {left 1}
Return

:?:!гаип::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ГИБДД] Говорит %Teg%. Стройте состав на парковке ГИБДД, готовность -  минут.{left 7}
Return

:?:!увдп::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/УМВД] Говорит %Teg%. Стройте состав на парковке УМВД, готовность -  минут.{left 7}
Return

:?:!фсп::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/УФСИН] Говорит %Teg%. Стройте состав на парковке УФСИН, готовность -  минут.{left 7}
Return

:?:!вчп::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ВЧ] Говорит %Teg%. Стройте состав на парковке ВЧ, готовность -  минут.{left 7}
Return

:?:!есп::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/ЕСС] Говорит %Teg%. Стройте состав на парковке ЕСС, готовность -  минут.{left 7}
Return

:?:!вгп::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [%TegText%/УМВД/ГИБДД/ВЧ] Говорит %Teg%. Стройте состав на парковке УФСБ, готовность -  минут.{left 7}
Return

:?:!свуэм::
sendChat("/me снимает набор сапёра с разгрузки, после чего ставит рядом с собой и открывает его")
Sleep 1000
sendChat("/me достает инженерную отвертку и кусачки из набора сапёра, после чего откручивает крышку СВУ и убирает крышку в сторону")
Sleep 1000
sendChat("/me кладёт инженерную отвертку в набор сапёра, достаёт оттуда индикаторную отвертку и начинает прозванивать провода")
Sleep 1000
sendChat("/me найдя провод питания берёт кусачки после чего перекусывает провод, ведущий к таймеру")
Sleep 1000
sendChat("/do СВУ обесточено.")
Sleep 1000
sendChat("/me открывает бронированный кейс, затем кладёт его возле СВУ")
Sleep 1000
sendChat("/me отделяет механический взрыватель, от него отделяет капсюль, затем достаёт из СВУ тротиловую шашку")
Sleep 1000
sendChat("/do СВУ обезврежено.")
Sleep 1000
sendChat("/me укладывает взрывчатые компоненты СВУ в бронированный кейс и закрывая его, берёт в правую руку")
Return


:?:!свухим::
sendChat("/me достает химическую защиту, одевает её")
Sleep 1000
sendChat("/me снимает набор сапёра с разгрузки, открывает его, достаёт инженерную отвертку")
Sleep 1000
sendChat("/me осматривает взрывное устройство, после чего откручивает крышку")
Sleep 1000
sendChat("/me осматривает содержимое корпуса, после чего обнаруживает химический взрыватель")
Sleep 1000
sendChat("/me снимает с разгрузки бронированный кейс, открывает его и ставит на пол")
Sleep 1000
sendChat("/me выкручивает химический взрыватель из тротиловой шашки")
Sleep 1000
sendChat("/me раскладывает компоненты СВУ по кейсам, закрывает кейсы, вешает на крепления бронежилета")
Sleep 1000
sendChat("/do СВУ обезврежено.")
Return

:?:!свудист::
sendChat("/me достал гнереатор ЭМИ помех, влючил его и расположил рядом с СВУ")
Sleep 1000
sendChat("/me снимает набор сапёра с разгрузки, после чего ставит рядом с собой и открывает его")
Sleep 1000
sendChat("/me достает инженерную отвертку и кусачки из набора сапёра, после чего откручивает крышку СВУ и убирает крышку в сторону")
Sleep 1000
sendChat("/me кладёт инженерную отвертку в набор сапёра, достаёт оттуда индикаторную отвертку и начинает прозванивать провода")
Sleep 1000
sendChat("/me найдя провод питания берёт кусачки после чего перекусывает провод, ведущий к таймеру")
Sleep 1000
sendChat("/do СВУ обесточено.")
Sleep 1000
sendChat("/me открывает бронированный кейс, затем кладёт его возле СВУ")
Sleep 1000
sendChat("/me отделяет механический взрыватель, от него отделяет капсюль, затем достаёт из СВУ тротиловую шашку")
Sleep 1000
sendChat("/do СВУ обезврежено.")
Sleep 1000
sendChat("/me укладывает взрывчатые компоненты СВУ в бронированный кейс и закрывая его, берёт в правую руку")
Return

:?:!свумех::
sendChat("/me снимает набор сапёра с разгрузки, после чего ставит рядом с собой и открывает его")
Sleep 1000
sendChat("/me достает инженерную отвертку и кусачки из набора сапёра, после чего откручивает крышку СВУ и убирает крышку в сторону")
Sleep 1000
sendChat("/me кладёт инженерную отвертку в набор сапёра, достаёт оттуда индикаторную отвертку и начинает прозванивать провода")
Sleep 1000
sendChat("/me найдя провод питания берёт кусачки после чего перекусывает провод, ведущий к таймеру")
Sleep 1000
sendChat("/do СВУ обесточено.")
Sleep 1000
sendChat("/me открывает бронированный кейс, затем кладёт его возле СВУ")
Sleep 1000
sendChat("/me отделяет механический взрыватель, от него отделяет капсюль, затем достаёт из СВУ тротиловую шашку")
Sleep 1000
sendChat("/do СВУ обезврежено.")
Sleep 1000
sendChat("/me укладывает взрывчатые компоненты СВУ в бронированный кейс и закрывая его, берёт в правую руку")
Return

:?:!пояссм::
sendChat("/me достаёт генератор радиопомех, после чего активирует его")
Sleep 1000
sendChat("/do Генератор радиопомех активирован.")
Sleep 1000
sendChat("/me снимает набор сапера с разгрузки и ставит его на пол")
Sleep 1000
sendChat("/me открывает набор сапера")
Sleep 1000
sendChat("/me достает инженерную отвертку и кусачки из набора")
Sleep 1000
sendChat("/me осматривает устройство с целью нахождения отсека с питанием")
Sleep 1000
sendChat("/me откручивает крышку устройства отверткой")
Sleep 1000
sendChat("/me начинает прозванивать отверткой провода")
Sleep 1000
sendChat("/do Нужный провод найден.")
Sleep 1000
sendChat("/me перерезает нужный провод кусачками")
Sleep 1000
sendChat("/do СВУ обесточено.")
Sleep 1000
sendChat("/me аккуратным движением снимает пояс смертника с человека")
Sleep 1000
sendChat("/do Пояс смертника снят.")
Sleep 1000
sendChat("/me снимает с разгрузки кейс, затем открывает его и ставит возле СВУ. ")
Sleep 1000
sendChat("/me вынимает из устройства тротиловую шашку, отделяет от неё шашку взрывателя, а от шашки взрывателя капсюль.")
Sleep 1000
sendChat("/me укладывает тротиловую шашку, шашку взрывателя и капсюль в бронированный кейс")
Sleep 1000
sendChat("/me цепляет кейс на лямки бронежилета")
Sleep 1000
sendChat("/do СВУ обезврежено.")
Return

:?:!растяж::
sendChat("/me кладёт набор сапёра рядом с собой, после чего открывает")
Sleep 1000
sendChat("/me обхватывает рукой корпус гранаты, одновременно просунув палец в кольцо")
Sleep 1000
sendChat("/do Спусковой рычаг заблокирован.")
Sleep 1000
sendChat("/me сжимает гранату рукой, наклоняя ее")
Sleep 1000
sendChat("/me разводит усики шплинта, удерживающий чеку")
Sleep 1000
sendChat("/do Чека упала.")
Sleep 1000
sendChat("/me достает кусачки из набора сапер после чего перекусывает проволоку")
Sleep 1000
sendChat("/do Растяжка деактивирована.")
Sleep 1000
Return

:?:!мина::
sendChat("/me снимает набор сапера с разгрузки и ставит его на пол")
Sleep 1000
sendChat("/me открывает набор сапера")
Sleep 1000
sendChat("/me осторожно перерезает проволоку, идущую к мине, не дергая и не натягивая ее")
Sleep 1000
sendChat("/do Проволока перерезана.")
Sleep 1000
sendChat("/me снимает маскирующий слой вокруг взрывателя, вставляя в отверстия штоков ударников чеки кусок проволоки")
Sleep 1000
sendChat("/me достает крюк и верёвку из набора сапера, после чего подцепляет крук к мине в отверстия штоков ударников чеки")
Sleep 1000
sendChat("/me подцепляет верёвку к крюку")
Sleep 1000
sendChat("/me отходит на 50 метров")
Sleep 1000
sendChat("/me вырывает мину из грунта")
Sleep 1000
sendChat("/me подходит к мине")
Sleep 1000
sendChat("/me вывинчивает взрыватель")
Sleep 1000
sendChat("/do Взрыватель выкручен.")
Sleep 1000
sendChat("/me аккуратно откладывает мину в бронекейс")
Sleep 1000
sendChat("/me закрывает бронекейс")
Sleep 1000
sendChat("/do Мина обезврежена.")
Sleep 1000
Return

:?:!аудиовидео::
SendInput /do Есть ли у человека аудио/фото/видеозаписывающие устройства?{Enter}
Sleep 1000
sendChat("/b /do Да. или Нет.")
Return

:?:!обморок::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой")
Sleep 1000
sendChat("/me придаёт пострадавшему положение спиной вниз")
Sleep 1000
sendChat("/me кладёт под ноги пострадавшего полотенце, выравнивая ноги с уровнем головы")
Sleep 1000
sendChat("/me Расстёгивает сдавливающие слои одежды на пострадавшем")
Sleep 1000
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} При жаркой погоде выносим человека в тень, при холоде в тёплое место, при обморожении укрываем одеялом.")
Sleep 1000
sendChat("/me смещает голову пострадавшего вбок")
Sleep 1000
sendChat("/do Человек в сознании?")
Sleep 1000
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} В случа того, если человек в сознании предлагаем тёплый чай.")
Return

:?:!сотряс::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой")
Sleep 1000
sendChat("/me укладывает человека на ровную поверхность, кладёт под голову пострадавшего полотенце")
Sleep 1000
sendChat("/me переворачивает пострадавшего на правый бок, сгибает левую руку и ногу пострадавшего")
Sleep 1000
sendChat("/me из аптечки достаёт танометр, фиксирует на правой руке, включает режим постоянного измерения пульса, давления и температуры тела")
Sleep 1000
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} В случае остановки дыхания сделать непрямой массаж сердца")
Sleep 1000
sendChat("/me обрабатывает место ушиба перекисью, накладывает на место ушиба холодный компресс")
Return

:?:!артерия::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой помощи, кладёт телефон обратно в карман")
Sleep 1000
sendChat("/me открывает аптечку, после чего достаёт пару чистых резиновых перчаток и натягивает на руки")
Sleep 1000
sendChat("/me пережимает артерию кулаком в месте ранения, параллельно доставая из аптечки жгут и бинт")
Sleep 1000
sendChat("/me перевязывает место наложения жгута бинтом, после чего накладывает жгут выше места ранения")
Sleep 1000
sendChat("/me достает из правого нагрудного кармана маркер, после чего записывает время наложения жгута")
Sleep 1000
sendChat("/me правой рукой берёт из аптечки стерильную салфетку и накрывает место ранения")
Sleep 1000
sendChat("/do Кровотечение прекратилось?")
Return

:?:!вена::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой помощи, кладёт телефон обратно в правый карман")
Sleep 1000
sendChat("/me открывает аптечку, после чего достаёт пару чистых резиновых перчаток и натягивает на руки")
Sleep 1000
sendChat("/me накладывает жгут ниже места ранения на 10 сантиметров и записывает на бумажке время наложения жгута")
Sleep 1000
sendChat("/me протягивает руку в аптечку после чего берет от туда марлю")
Sleep 1000
sendChat("/me накладывает марлю на рану")
Sleep 1000
sendChat("/me достает из аптечки бинт и вату после чего кладет вату на марлю и туго бинтует")
Sleep 1000
sendChat("/do Кровотечение прекратилось?")
Return

:?:!закрперелом::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой помощи, кладёт телефон обратно в правый карман")
Sleep 1000
sendChat("/me укладывает в удобную для пострадавшего позу на твёрдой ровной поверхности")
Sleep 1000
sendChat("/me открывает аптечку, после чего достаёт пару чистых резиновых перчаток и натягивает на руки")
Sleep 1000
sendChat("/me достаёт из аптечки медицинскую шину, накладывает её на место перелома")
Sleep 1000
sendChat("/me достаёт из аптечки бинты, после чего тупо фиксирует шину")
Sleep 1000
sendChat("/do Шина зафиксирована.")
Sleep 1000
sendChat("/me протягивает правую руку в аптечку, достаёт оттуда гипотермический пакет и накладывает на место перелома")
Sleep 1000
sendChat("")
Sleep 1000
Return

:?:!открперелом::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой помощи, кладёт телефон обратно в правый карман")
Sleep 1000
sendChat("/me открывает аптечку, после чего достаёт пару чистых резиновых перчаток и натягивает на руки")
Sleep 1000
sendChat("/me достаёт из аптечки ножницы, после чего разрезает одежду вокруг места перелома")
Sleep 1000
sendChat("/me достаёт из аптечки медицинскую шину, после чего накладывает шину на место перелома")
Sleep 1000
sendChat("/me достаёт из аптечки бинты, после чего тупо фиксирует шину")
Sleep 1000
sendChat("/do Шина зафиксирована.")
Return

:?:!пулевое::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой помощи, кладёт телефон обратно в правый карман")
Sleep 1000
sendChat("/me открывает аптечку, после чего достаёт пару чистых резиновых перчаток и натягивает на руки")
Sleep 1000
sendChat("/me запрокидывает голову человеку немного в бок")
Sleep 1000
sendChat("/do Есть ли кровотечение?")
Sleep 1000
sendChat("/do Какое кровотечени и где?")
Sleep 1000
sendChat("/me достаёт из аптечки ножницы, после чего разрезает одежду вокруг места ранения")
Sleep 1000
sendChat("/me достаёт зелёнку из аптечки, после чего обрабатывает края раны")
Sleep 1000
sendChat("/me достаёт из аптечки давящую позявку, после чего накладывает давящую повязку на место ранения")
Return

:?:!общожог::
sendChat("/me сухой тканью убирает источник ожога в сторону")
Sleep 1000
sendChat("/me берёт ёмкость с водой комнатной температуры 17 градусов, промывает место ожога")
Sleep 1000
sendChat("/me наливает в пустую ёмкость раствор фурацилина, промывает раствором рану")
Sleep 1000
sendChat("/me из аптечки достаёт  марлевую повязку, накрывает ей место ожога")
Sleep 1000
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} В случа если повреждены конечности, наложить аккуратно шину")
Sleep 1000
sendChat("/do Человек в сознании?")
Sleep 1000
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Если человек в сознании то даём ему  или жаропонижающее средство")
Return

:?:!терможгл::
sendChat("/me достаёт из-за пазухи чёрный складной зонт, раскрывает его и ставит так, чтобы закрыть глаза пострадавшего от солнечных лучей")
Sleep 1000
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой")
Sleep 1000
sendChat("/me из аптечки достаёт раствор дикаина с концентрацией 0,5 процента, капает в глаза пострадавшего")
Sleep 1000
sendChat("/me кладёт раствор дикаина в аптечку, достаёт раствор сульфацил-натрия с концентрацией 30 процентов, капает в глаза пострадавшего")
Return

:?:!химожгл::
sendChat("/me достаёт из-за пазухи чёрный складной зонт, раскрывает его и ставит так, чтобы закрыть глаза пострадавшего от солнечных лучей")
Sleep 1000
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой")
Sleep 1000
sendChat("/me из аптечки достаёт раствор дикаина с концентрацией 0,5 процента, капает в глаза пострадавшего")
Sleep 1000
sendChat("/me кладёт раствор дикаина в аптечку, достаёт раствор сульфацил-натрия с концентрацией 30 процентов, капает в глаза пострадавшего")
Sleep 1000
sendChat("/me сухой ватной палочкой убирает остатки агрессивного вещества")
Sleep 1000
sendChat("/me Мягким ватным тампоном обильно смоченным в растворе пищевой соды, промывает глаза пострадавшего")
Sleep 1000
sendChat("/me из аптечки достаёт раствор дикаина с концентрацией 0,5 процента, капает в глаза пострадавшего")
Sleep 1000
sendChat("/me кладёт раствор дикаина в аптечку, достаёт раствор сульфацил-натрия с концентрацией 30 процентов, капает в глаза пострадавшего")
Return

:?:!обморож::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой помощи, кладёт телефон обратно в правый карман")
Sleep 1000
sendChat("/me открывает аптечку, после чего достаёт пару чистых резиновых перчаток и натягивает на руки")
Sleep 1000
sendChat("/me начинает осторожно растирать поражённые участки тела")
Sleep 1000
sendChat("/me достаёт из аптечки согревающую повязку, в виде бинтов, начал обматывать поражённую конечность в несколько слоёв")
Return

:?:!угаргаз::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой помощи, кладёт телефон обратно в правый карман")
Sleep 1000
sendChat("/me открывает аптечку, после чего достаёт пару чистых резиновых перчаток и натягивает на руки")
Sleep 1000
sendChat("/me укладывает человека на спину, после чего подкладывает фуражку под ноги человека")
Sleep 1000
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Требуется прекратить поступление угарного газа если человек в помещении")
Sleep 1000
sendChat("/do Человек в сознании?")
Return

:?:!ножевое::
sendChat("/me достаёт из правого кармана телефон, после чего вызывает бригаду скорой помощи, кладёт телефон обратно в правый карман")
Sleep 1000
sendChat("/me открывает аптечку, после чего достаёт пару чистых резиновых перчаток и натягивает на руки")
Sleep 1000
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Определяете вид кровотечения и устраняете (!артерия) или (!вена). АХК ждёт 30 секунд.")
Sleep 30000
sendChat("/me укладывает человека в удобную для него позу")
Sleep 1000
sendChat("/me из аптечки достаёт танометр, фиксирует на правой руке, включает режим постоянного измерения пульса, давления и температуры тела")
Sleep 1000
sendChat("/me достаёт из аптечки стерильную салфетку, после чего накладывает на место ранения")
Sleep 1000
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Нож и раны не достаём! В ПП это не входит.")
Return

:?:!эпилепс::
sendChat("/me достаёт из аптечки полотенце, кладёт под голову пострадавшего")
Sleep 1000
sendChat("/me ослабляет стягивающую одежду и аксессуары на пострадавшем")
Sleep 1000
sendChat("/me укладывает пострадавшего на бок, придерживает пострадавшего")
Sleep 1000
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Важно: не кладите никаких предметов в рот, как пример: шпатель, ложка и член")
Return

:?:!с1::
sendChat("/r Докладывает " . Teg . ": выехал на вызов SOS.")
Sleep 200
TakeScreenshot()
Return

:?:!с2::
sendChat("/r Докладывает " . Teg . ": прибыл на вызов SOS.")
Sleep 200
TakeScreenshot()
Return

:?:!с3::
sendChat("/r Докладывает " . Teg . ": отработал вызов SOS.")
Sleep 200
TakeScreenshot()
Return

:?:!пгаи1::
sendChat("/r Докладывает " . Teg . ": начал прослушивание организации «УГИБДД».")
Sleep 200
TakeScreenshot()
Return

:?:!пгаи2::
sendChat("/r Докладывает " . Teg . ": продолжаю прослушивание организации «УГИБДД».")
Sleep 200
TakeScreenshot()
Return

:?:!пгаи3::
sendChat("/r Докладывает " . Teg . ": закончил прослушивание организации «УГИБДД».")
Sleep 200
TakeScreenshot()
Return

Home::
TakeScreenshot()
Return

CapsLock::
Return

F12::
sendChat("/sos")
sleep %Sleep%
SendInput {Down}
sleep %Sleep%
SendInput {Enter}
sleep 1000
sendChat("/fsos")
return

SetBatchLines, -1
SetTitleMatchMode, 2

global State3 := false
global State4 := false
global State7 := false
global State6 := false

1help:
    Gosub, DestroyAllGuis
    State3 := !State3
    State4 := false
    State5 := false
    State7 := false
    
    if (State3) {
        CreateWindow1()
    }
return

2help:
    Gosub, DestroyAllGuis
    State4 := !State4
    State3 := false
    State5 := false
    State7 := false
    
    if (State4) {
        CreateWindow2()
    }
return

3help:
    Gosub, DestroyAllGuis
    State6 := !State6
    State3 := false
    State4 := false
    State7 := false
    
    if (State6) {
        CreateWindow3()
    }
return

CreateWindow1() {
    global KeyOne, KeyThree, KeyFive, KeyNine, KeyVesti, KeyEight, kvgp, KeySix, KeyFour, KeyProtokol, KeySeven, KeyCar, KeyCars, vivs, KeyPolice, Rozisk, KeyPosadi, 2help, 3help, ProbivGos, ProbivGosId

    Gui, 1:Destroy
    Gui, 1:New, +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui, 1:Color, black
    Gui, 1:Font, s7 cWhite w%Speed1%
    
    If UserID {
        Gui, 1:Add, Text,, ID = %UserID%
    }
    
    Gui, 1:Add, Text,,     [КОМБИНАЦИИ]         [ОТЫГРОВКИ]
    Gui, 1:Add, Text,,       %KeyOne%          	Ввести в базу данных ID
    Gui, 1:Add, Text,,       %KeyThree%            	/chase
    Gui, 1:Add, Text,,       %KeyFive%              	Миранда
    Gui, 1:Add, Text,,       %KeyNine%              	Преды
    Gui, 1:Add, Text,,       %KeyVesti%           	Вести за собой
    Gui, 1:Add, Text,,       %ProbivGosId%             	Пробив по id
    Gui, 1:Add, Text,,       Alt & E             	/id - рег
    Gui, 1:Add, Text,,       LAlt & H             	Дом
    Gui, 1:Add, Text,,       RAlt & H             	Особняк
    Gui, 1:Add, Text,,       %KeySix%             	Представиться
    Gui, 1:Add, Text,,       %KeyFour%             	/cuff
    Gui, 1:Add, Text,,       %KeyProtokol%             	Протокол (ИВС)
    Gui, 1:Add, Text,,       %KeySeven%             	/deject
    Gui, 1:Add, Text,,       %vivs%             	Передача в ИВС
    Gui, 1:Add, Text,,       %ProbivGos%             	Пробить /find
    Gui, 1:Add, Text,,       %KeyEight%           	Пробить розыск
    Gui, 1:Add, Text,,       %KeyCar%             	Эвакуация
    Gui, 1:Add, Text,,       %KeyCars%             	Сдача на штрафку
    Gui, 1:Add, Text,,       %KeyPolice%             	/police
    Gui, 1:Add, Text,,       %Rozisk%             	Розыск (выдать)
    Gui, 1:Add, Text,,       %KeyPosadi%             	Посадить в авто
    Gui, 1:Add, Text,,       F12             	/sos
    Gui, 1:Add, Text,,       (!протокол)        Протокол (АПН)
    Gui, 1:Add, Text,,       (!док)             	Ксива
    Gui, 1:Add, Text,,       LAlt & B             	Перезагрузка
    Gui, 1:Add, Text,,             	             	             	    
    Gui, 1:Add, Text,,       %2help%             	Второе окно
    Gui, 1:Add, Text,,       %3help%             	Окно ПП
    
    WinSet, TransColor, EEAA99 450
    Gui, 1:Show, x5 y3 NoActivate, Window1
}

CreateWindow2() {
    Gui, 2:Destroy
    Gui, 2:New, +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui, 2:Color, black
    Gui, 2:Font, s7 cWhite w%Speed1%
    
    If UserID {
        Gui, 2:Add, Text,, ID = %UserID%
    }
    
    Gui, 2:Add, Text,,     [КОМБИНАЦИИ]         [ОТЫГРОВКИ]
    Gui, 2:Add, Text,,       (!вн)             	Внутренний SOS
    Gui, 2:Add, Text,,       (!дп)             	На связь любой
    Gui, 2:Add, Text,,       (!дпп)             	На связи любой
    Gui, 2:Add, Text,,       (!гаии)             	На связи ГАИ
    Gui, 2:Add, Text,,       (!гаи)             	На связь ГАИ
    Gui, 2:Add, Text,,       (!увдд)             	На связи МВД
    Gui, 2:Add, Text,,       (!увд)             	На связь МВД
    Gui, 2:Add, Text,,       (!вчч)             	На связи ВЧ
    Gui, 2:Add, Text,,       (!вч)             	На связь ВЧ
    Gui, 2:Add, Text,,       (!прр)             	На связи ПР
    Gui, 2:Add, Text,,       (!пр)             	На связь ПР
    Gui, 2:Add, Text,,       (!есс)             	На связи ЕСС
    Gui, 2:Add, Text,,       (!ес)             	На связь ЕСС
    Gui, 2:Add, Text,,       (!фсс)             	На связи ФСИН
    Gui, 2:Add, Text,,       (!гаип)             	Построение ГАИ
    Gui, 2:Add, Text,,       (!увдп)             	Построение МВД
    Gui, 2:Add, Text,,       (!фсп)             	Построение ФСИН
    Gui, 2:Add, Text,,       (!вчп)             	Построение ВЧ
    Gui, 2:Add, Text,,       (!есп)             	Построение ЕСС
    Gui, 2:Add, Text,,       (!поме)             	Помехи
    Gui, 2:Add, Text,,       (!кор5 / !кор7)  	ПК ст.5/7
    Gui, 2:Add, Text,,             	             	             	    
    Gui, 2:Add, Text,,       LAlt X             	Первое окно
    Gui, 2:Add, Text,,       LAlt V             	Окно ПП/СВУ
    
    WinSet, TransColor, EEAA99 450
    Gui, 2:Show, x5 y3 NoActivate, Window2
}

CreateWindow3() {
    Gui, 3:Destroy
    Gui, 3:New, +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui, 3:Color, black
    Gui, 3:Font, s7 cWhite w%Speed1%
    
    If UserID {
        Gui, 3:Add, Text,, ID = %UserID%
    }
    
    Gui, 3:Add, Text,,     [КОМБИНАЦИИ]         [ВИД ПП/СВУ]
    Gui, 3:Add, Text,,       (!обморок)             	ПП при Обмороке
    Gui, 3:Add, Text,,       (!сотряс)             	ПП при Сотрясении
    Gui, 3:Add, Text,,       (!артерия)             	ПП при Артериальном кровотечении
    Gui, 3:Add, Text,,       (!вена)             		ПП при Венозном кровотечении
    Gui, 3:Add, Text,,       (!закрперелом)             	ПП при Закрытом переломе
    Gui, 3:Add, Text,,       (!открперелом)             	ПП при Открытом переломе
    Gui, 3:Add, Text,,       (!пулевое)             	ПП при Пулевом ранении
    Gui, 3:Add, Text,,       (!общожог)             	Отыгровка ожога, простая
    Gui, 3:Add, Text,,       (!терможгл)                	ПП при Термическом ожоге глаза
    Gui, 3:Add, Text,,       (!химожгл)                	ПП при Химическом ожоге глаза
    Gui, 3:Add, Text,,       (!обморож)             	ПП при Обморожении
    Gui, 3:Add, Text,,       (!угаргаз)             	ПП при Удушении угарным газом
    Gui, 3:Add, Text,,       (!ножевое)             	ПП при Ножевом ранении
    Gui, 3:Add, Text,,       (!эпилепс)             	ПП при Эпилепсии
    Gui, 3:Add, Text,,             	             	             	    
    Gui, 3:Add, Text,,       (!свуэм)    	Разминирование СВУ элект-мех
    Gui, 3:Add, Text,,       (!свудист)    	Разминирование СВУ дистанц
    Gui, 3:Add, Text,,       (!свухим)    	Разминирование СВУ химич
    Gui, 3:Add, Text,,       (!свумех)    	Разминирование СВУ мех
    Gui, 3:Add, Text,,       (!пояссм)    	Разминирование СВУ пояс
    Gui, 3:Add, Text,,       (!рястяж)    	Разминирование Растяжки
    Gui, 3:Add, Text,,       (!мина)    	Разминирование Мины
    Gui, 3:Add, Text,,             	             	             	    
    Gui, 3:Add, Text,,       LAlt X             		Первое окно
    Gui, 3:Add, Text,,       LAlt C             		Окно /d
    Gui, 3:Add, Text,,             	             	             	    
    Gui, 3:Add, Text,,       Такие виды ПП, как: утопление, солнечный удар, отравление и
    Gui, 3:Add, Text,,       сахарный диабет НЕ ВХОДЯТ в АХК ввиду простоты
    
    WinSet, TransColor, EEAA99 450
    Gui, 3:Show, x5 y3 NoActivate, Window3
}

DestroyAllGuis:
    Gui, 1:Destroy
    Gui, 2:Destroy
    Gui, 3:Destroy
    Gui, 4:Destroy
return