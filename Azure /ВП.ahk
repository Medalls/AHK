; <COMPILER: v1.1.37.01>
#IfWinActive AMAZING ONLINE
#Include UDF.ahk
#SingleInstance Force
#NoEnv
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
ServerList := "RED|YELLOW|GREEN|AZURE|SILVER|ROSE|"
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
IniRead, KeyTwen, %A_ScriptDir%\settings.ini, SETTINGS, vKeyTwen
IniRead, Mask, %A_ScriptDir%\settings.ini, SETTINGS, vMask
IniRead, Teg, %A_ScriptDir%\settings.ini, SETTINGS, vTeg
IniRead, Dolzhnost, %A_ScriptDir%\settings.ini, SETTINGS, vDolzhnost
IniRead, Rank, %A_ScriptDir%\settings.ini, SETTINGS, vRank
IniRead, KeyPolice, %A_ScriptDir%\settings.ini, SETTINGS, vKeyPolice
IniRead, TegText, %A_ScriptDir%\settings.ini, SETTINGS, vTegText
IniRead, KeyVesti, %A_ScriptDir%\settings.ini, SETTINGS, vKeyVesti
IniRead, KeyCar, %A_ScriptDir%\settings.ini, SETTINGS, vKeyCar
IniRead, KeyCars, %A_ScriptDir%\settings.ini, SETTINGS, vKeyCars
IniRead, KeyProbiv, %A_ScriptDir%\settings.ini, SETTINGS, vKeyProbiv
IniRead, KeyPosadi, %A_ScriptDir%\settings.ini, SETTINGS, vKeyPosadi
if(TegText == "ERROR") {
    global TegText := "ВЧ"
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
Gui Add, Text, x23 y472 w125 h25 +0x200 , Вызов «SOS»
Gui Add, Edit, vTegText x167 y432 w90 h22, %TegText%
Gui Add, Edit, vKeyFive x167 y231 w90 h22, %KeyFive%
Gui Add, Edit, vKeySix x168 y273 w90 h22, %KeySix%
Gui Add, Edit, vKeySeven x167 y312 w90 h22, %KeySeven%
Gui Add, Edit, vKeyEight x167 y352 w90 h22, %KeyEight%
Gui Add, Edit, vKeyNine x167 y392 w90 h22, %KeyNine%
Gui Add, Edit, vKeyTwen x167 y472 w90 h22, %KeyTwen%
Gui Add, ComboBox, vServer x168 y70 w120, %NewServerList%
Gui Add, Text, x330 y110 w75 h25 +0x200 , Позывной
Gui Add, Edit, vTeg x431 y110 w90 h25, %Teg%
Gui Add, Text, x330 y150 w90 h25 +0x200 , Должность
Gui Add, Edit, vDolzhnost x431 y150 w90 h25, %Dolzhnost%
Gui Add, Text, x330 y190 w90 h25 +0x200 , Маска
Gui Add, Edit, vMask x431 y190 w90 h25, %Mask%
Gui Add, Text, x330 y230 w90 h25 +0x200 , Звание
Gui Add, Edit, vRank x431 y230 w90 h25, %Rank%
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
Gui Add, Text, x330 y470 w125 h25 +0x200 , Пробить
Gui Add, Edit, vKeyProbiv x431 y470 w90 h25, %KeyProbiv%
Gui Add, Text, x330 y520 w125 h25 +0x200 , Посадить в авто
Gui Add, Edit, vKeyPosadi x431 y520 w90 h25, %KeyPosadi%
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
GuiControlGet, Rank
IniWrite, %Rank%, %A_ScriptDir%\settings.ini, SETTINGS, vRank
GuiControlGet, Mask
IniWrite, %Mask%, %A_ScriptDir%\settings.ini, SETTINGS, vMask
GuiControlGet, TegText
IniWrite, %TegText%, %A_ScriptDir%\settings.ini, SETTINGS, vTegText
GuiControlGet, Sleep
IniWrite, %Sleep%, %A_ScriptDir%\settings.ini, SETTINGS, vSleep
GuiControlGet, KeyNine
IniWrite, %KeyNine%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyNine
GuiControlGet, KeyTwen
IniWrite, %KeyTwen%, %A_ScriptDir%\settings.ini, SETTINGS, vKeyTwen
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
Hotkey,%KeyTwen%,KeyTwen
Hotkey,%KeyPolice%,KeyPolice
Hotkey,%KeyVesti%,KeyVesti
Hotkey,%KeyPosadi%,KeyPosadi
Hotkey,%KeyProbiv%,KeyProbiv
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
        sleep 10000
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
    if line contains СР
    {
	if (InStr(line, "1-1"))
	{
        	addChatMessageEx(-1, "{58e11b}[Диспетчер] {FF0000}&#9888 Внимание! {FFFFFF}Пасхалко!{FF0000}&#9888")
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
Run, https://vk.com/shau02
Return

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
return

KeyFour:
if(playerID == -1) {
if(playerMask == -1) {
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Вы не зарегистрировали ID или маску в системе")
}
else
{
addChatMessageEx(0xFFFFFF, "{58e11b}[Диспетчер] {ffffff} Вы не зарегистрировали ID в системе")
}
}
sendChat("/frac " playerID)
sleep 300
SendInput, {1}{1}
sleep 300
SendInput, {2}{2}
return

KeyFive:
SendChat("На основании части 1, статьи 13 процессуального кодекса, Вам предоставляются следующие права:")
Sleep 1000
SendChat("Право не свидетельствовать против себя и своих близких.")
Sleep 1250
SendChat("Право на ознакомление с всеми протоколами, составленными при задержании.")
Sleep 1250
SendChat("Право на обжалование действий сотрудников правоохранительных органов в судебном порядке.")
Sleep 1250
SendChat("И право на юридическую помощь в лице адвоката и телефонный звонок в любой момент задержания после прибытия в отдел.")
Sleep 1250
return

KeySix:
sendChat("Здравия желаю, я - " . Dolzhnost . ", в звании " . Rank . ", мой позывной " . Teg . ".")
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
return

KeyEight:
sendChat("/frac")
sleep %Sleep%
SendInput, {1}{1}
sleep %Sleep%
SendInput, {1}{1}
sleep %Sleep%
SendInput, {1}{1}
return

KeyNine:
sendChat("/m [" . TegText . "] Внимание! Принимаем правое положение и делаем остановку!")
sleep 600
sendChat("/m [" . TegText . "] В случае неподчинения мы будем открывать огонь!")
return

KeyTwen:
sendChat("/fsos")
sleep 1000
sendChat("/sos")
sleep %Sleep%
SendInput {Down}
sleep %Sleep%
SendInput {Enter}
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
SendInput, {3}{3}
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
addChatMessageEx(0, "{58e11b}[Диспетчер]{FFFFFF} Ассистент для сотрудников ВЧ. {58e11b}успешно запущен")
addChatMessageEx(0, "{58e11b}[Диспетчер]{FFFFFF} Нашли ошибку или хотите предложить идею? VK - {58e11b}@shau02")
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

^3::
SendChat("/do Протокол о задержании и ручка находятся на столе.")
Sleep 1000
SendChat("/me правой рукой берёт ручку, затем заполняет в бланке данные задержанного, свои данные, место, время, причины и обстоятельства задержания")
Sleep 1000
SendChat("/me ставит подпись на бланке")
Sleep 1000
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
SendInput, {7}{7}
Return

:?:!кор::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ] Ввожу корректировки в личное дело жетона по ПК статья 5,7.{left 1}
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

F9::
sendChat("/frac")
sleep %Sleep%
SendInput, {1}{1}
sleep %Sleep%
SendInput, {1}{1}
sleep %Sleep%
SendInput, {Enter}
return

F10::
sendChat("/frac")
sleep %Sleep%
SendInput, {1}{1}
sleep %Sleep%
SendInput, {2}{2}
sleep %Sleep%
SendInput, {Enter}
return

:?:!дп::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/] %Rank% с личным позывным - %Teg%, на связь{!} {left 1}
Return

:?:!вн::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ] Вызов срочной помощи внутренний.{left 1}
Return

:?:!дпп::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/] %Rank% с личным позывным - %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!фсбб::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/УФСБ] %Rank% с личным позывным - %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!фсб::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/УФСБ] %Rank% с личным позывным - %Teg%, на связь{!} {left 1}
Return

:?:!увд::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/УМВД] %Rank% с личным позывным - %Teg%, на связь{!} {left 1}
Return

:?:!увдд::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/УМВД] %Rank% с личным позывным - %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!гаии::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/ГАИ] %Rank% с личным позывным - %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!гаи::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/ГАИ] %Rank% с личным позывным - %Teg%, на связь{!} {left 1}
Return

:?:!пр::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/ПР] %Rank% с личным позывным - %Teg%, на связь{!} {left 1}
Return

:?:!прр::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/ПР] %Rank% с личным позывным - %Teg% на связи, слушаю Вас... {left 1}
Return


:?:!ес::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/ЕСС] %Rank% с личным позывным - %Teg%, на связь{!} {left 1}
Return


:?:!есс::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/ЕСС] %Rank% с личным позывным - %Teg% на связи, слушаю Вас... {left 1}
Return

:?:!фс::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/УФСИН] %Rank% с личным позывным - %Teg%, на связь{!} {left 1}
Return

:?:!фсс::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ/УФСИН] %Rank% с личным позывным - %Teg% на связи, слушаю Вас... {left 1}
Return


:?:!поме::
SendMessage, 0x50,, 0x4190419,, A
SendInput /d [ВЧ] Помехи... {left 1}
Return

:?:!аудиовидео::
SendInput /do Есть ли у человека аудио/фото/видеозаписывающие устройства?{Enter}
Sleep 1000
sendChat("/b /do Да или Нет")
Return

!X::
State3:=!State3

If state3

{

Gui Destroy

CustomColor3 = EEAA99

Gui +LastFound +AlwaysOnTop -Caption +ToolWindow 

Gui, Color, black

Gui, Font, s7

Gui, Font, cWhite

Gui, Font, w%Скорость1%0

If UserID
{
GUI, ADD, TEXT,, ID = %UserID%
}                                                                                                                                 
GUI, ADD, TEXT,,     [КОМБИНАЦИИ]         [ОТЫГРОВКИ]                                                 
GUI, ADD, TEXT,,       Alt 1          	Ввести в базу данных ID
GUI, ADD, TEXT,,       Alt 2            	/chase
GUI, ADD, TEXT,,       Alt 3              	Миранда
GUI, ADD, TEXT,,       Alt 4              	Преды
GUI, ADD, TEXT,,       Alt 5           	Вести за собой
GUI, ADD, TEXT,,       Alt E             	/id - рег
GUI, ADD, TEXT,,       Ctrl 1             	Представиться
GUI, ADD, TEXT,,       Ctrl 2             	/cuff
GUI, ADD, TEXT,,       Ctrl 4             	/deject
GUI, ADD, TEXT,,       F9             	Загрузка матов (Верт)
GUI, ADD, TEXT,,       F10             	Разгрузка матов
GUI, ADD, TEXT,,       F11             	Посадить в авто
GUI, ADD, TEXT,,       F12             	Кинуть /sos
GUI, ADD, TEXT,,       (!протокол)        Протокол (АПН)
GUI, ADD, TEXT,,       (!док)             	Ксива
GUI, ADD, TEXT,,       (!дп)             	На связь любой
GUI, ADD, TEXT,,       (!вн)             	Внутренний SOS
GUI, ADD, TEXT,,       (!дпп)             	На связи любой
GUI, ADD, TEXT,,       (!фсбб)             	На связи ФСБ
GUI, ADD, TEXT,,       (!фсб)             	На связь ФСБ
GUI, ADD, TEXT,,       (!увдд)             	На связи МВД
GUI, ADD, TEXT,,       (!увд)             	На связь МВД
GUI, ADD, TEXT,,       (!гаии)             	На связи ГАИ
GUI, ADD, TEXT,,       (!гаи)             	На связь ГАИ
GUI, ADD, TEXT,,       (!прр)             	На связи ПР
GUI, ADD, TEXT,,       (!пр)             	На связь ПР
GUI, ADD, TEXT,,       (!есс)             	На связи ЕСС
GUI, ADD, TEXT,,       (!ес)             	На связь ЕСС
GUI, ADD, TEXT,,       (!фсс)             	На связи ФСИН
GUI, ADD, TEXT,,       (!фс)             	На связь ФСИН
GUI, ADD, TEXT,,       (!поме)             	Помехи
GUI, ADD, TEXT,,       (!аудиовидео)    Досмотр
GUI, ADD, TEXT,,       LAlt & B             	Перезагрузка

                                                                                                                    
WinSet, TransColor, %CustomColor3% 180

Gui, Show, x5 y50 NoActivate, window. 

}

Else

Gui Destroy



