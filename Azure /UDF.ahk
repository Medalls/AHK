#CommentFlag //
#include common.ahk



/*
	
	AHK UDF для CR:MP и SA:MP версии 0.3.7 R3
	Перевел, обновил, доработал и отредактировал Снегирев Максим
	
	
	vk.com/drygok | vk.com/idDrygok | яМаксим.рф
	
*/

/*
	
	Доступные функции:
	
	*** Функции чтения, связанные с локальным персонажем ***
	- getPlayerHealth()																получить уровень здоровья (HP) игрока
	- getPlayerArmour()																получить уровень брони игрока
	- getPlayerMoney()																получить количество денег игрока
	- getPlayerInteriorId()															получить ID интерьера игрока
	- getPlayerSkinId()																получить ID скина игрока
	- getPlayerWeaponId()															получить ID оружия в руках
	
	*** Функции чтения, связанные с текущим транспортом ***
	- isPlayerInAnyVehicle()														проверить, находится ли игрок в транспорте (0 - если игрок не в транспорте, иначе вернется указатель на этот транспорт)
	- getVehicleHealth()															получить уровень здоровья текущего транспорта
	- isPlayerDriver()																проверить, за рулем ли игрок
	- getVehicleColor()																получить ID цветов текущего транспорта (возвращается одномерный массив с первым и вторым цветом)
	- getVehicleSpeed()																получить скорость транспорта
	
	*** Функции, связанные с координатами ***
	- getCoordinates()																получить координаты игрока или транспорта, в котором находится игрок (возвращается одномерный массив [X, Y, Z])
	- getPlayerCoordinates()														получить координаты игрока (возвращается одномерный массив [X, Y, Z])
	- getCameraCoordinates()														получить координаты камеры (возвращается одномерный массив [X, Y, Z])
	
	*** Функции, связанные с модулем мультиплеера ***
	- addChatMessageEx(Color, Text)													отправить сообщение в локальный чат (вывести самому себе)
	- sendChat(Text)																отправить сообщение/команду в чат
	- showDialog(Style, Caption, Text, Button1, Button2 := "", Id := 1)				вывести диалог (функция практически не отредактирована); Благодарю MurKotik за ее реализацию ;)
	- isInChat()																	проверить, открыт ли чат у пользователя скрипта (true - чат открыт, false - чат закрыт)
	
*/


// Если Вы не понимаете, что делаете - дальше путь закрыт. Ниже идет РЕАЛИЗАЦИЯ функций, трогать это не стоит.


// Функции чтения, связанные с локальным игроком
getPlayerHealth() {
	if (!checkHandles())
		return -1
		
	return readFloat(hGTA, readDWORD(hGTA, 0xB6F5F0) + 0x540)
}
getPlayerArmour() {
	if (!checkHandles())
		return -1
		
	return readFloat(hGTA, readDWORD(hGTA, 0xB6F5F0) + 0x548)
}
getPlayerMoney() {
	if (!checkHandles())
		return -1
		
	return readDWORD(hGTA, 0x0B7CE54)
}
getPlayerInteriorId() {
	if (!checkHandles())
		return -1
		
	return readDWORD(hGTA, 0xA4ACE8)
}
getPlayerSkinId() {
	if (!checkHandles())
		return -1
		
	return readMem(hGTA, readDWORD(hGTA, 0xB6F5F0) + 0x22, 2, "byte")
}
getPlayerWeaponId() {
	if (!checkHandles())
		return -1
		
	return readDWORD(hGTA, 0xBAA410)
}

// Функции чтения, связанные с текущим транспортом
isPlayerInAnyVehicle() {
	if (!checkHandles())
		return -1
		
	return readDWORD(hGTA, 0xBA18FC)
}
getVehicleHealth() {
	if (!checkHandles())
		return -1
		
	return readFloat(hGTA, readDWORD(hGTA, 0xBA18FC) + 0x4C0)
}
isPlayerDriver() {
	if (!checkHandles())
		return -1
		
	return (readDWORD(hGTA, readDWORD(hGTA, 0xBA18FC) + 0x460) == readDWORD(hGTA, 0xB6F5F0))
}
getVehicleColor() {
	if (!checkHandles())
		return -1
		
	dwAddress := isPlayerInAnyVehicle()
	return [readMem(hGTA, dwAddress + 1076, 1, "byte"), readMem(hGTA, dwAddress + 1077, 1, "byte")]
}
getVehicleSpeed() {
	if(!checkHandles())
		return -1
 
	dwAddress := isPlayerInAnyVehicle()
	
	fSpeedX := readMem(hGTA, dwAddress + 0x44, 4, "float")
	fSpeedY := readMem(hGTA, dwAddress + 0x48, 4, "float")
	fSpeedZ := readMem(hGTA, dwAddress + 0x4C, 4, "float")
	
	fVehicleSpeed := sqrt((fSpeedX * fSpeedX) + (fSpeedY * fSpeedY) + (fSpeedZ * fSpeedZ))
	fVehicleSpeed := (fVehicleSpeed * 100) * 1.43
 
	return Round(fVehicleSpeed)
}

// Функции, связанные с координатами
getCoordinates() {
	if (!checkHandles())
		return -1
		
	dwAddress := isPlayerInAnyVehicle()
	if (dwAddress == 0)
		dwAddress := readDWORD(hGTA, 0xB6F5F0)
	dwAddress := readDWORD(hGTA, dwAddress + 0x14)
	
	return [readFloat(hGTA, dwAddress + 0x30), readFloat(hGTA, dwAddress + 0x34), readFloat(hGTA, dwAddress + 0x38)]
}
getPlayerCoordinates() {
	if (!checkHandles())
		return -1
		
	dwAddress := readDWORD(hGTA, readDWORD(hGTA, 0xB6F5F0) + 0x14)
	
	return [readFloat(hGTA, dwAddress + 0x30), readFloat(hGTA, dwAddress + 0x34), readFloat(hGTA, dwAddress + 0x38)]
}
getCameraCoordinates() {
	if (!checkHandles())
		return -1
	
	return [readFloat(hGTA, 0xB6F9CC), readFloat(hGTA, 0xB6F9D0), readFloat(hGTA, 0xB6F9D4)]
}

// Функции, связанные с модулем мультиплеера
addChatMessageEx(Color, Text) {
	if (!checkHandles())
		return -1
   
	VarSetCapacity(data2, 4, 0)
	NumPut(HexToDec(Color), data2, 0, "Int")
	
	dwAddress := readDWORD(hGTA, dwSAMP + 0x26E8C8)
	VarSetCapacity(data1, 4, 0)
	NumPut(readDWORD(hGTA, dwAddress + 0x4), data1, 0, "Int") 
	WriteRaw(hGTA, dwAddress + 0x4, &data2, 4)
   
	callWithParams(hGTA, dwSAMP + 0x67970, [["p", readDWORD(hGTA, dwSAMP + 0x26E8C8)], ["s", "" Text]], true)
	WriteRaw(hGTA, dwAddress + 0x4, &data1, 4)
}
sendChat(Text) {	
	if (!checkHandles())
		return -1
	
	dwFunc := 0
	if (SubStr(Text, 1, 1) == "/") {
		dwFunc := dwSAMP + 0x69190
	} else {
		dwFunc := dwSAMP + 0x5820
	}
	
	callWithParams(hGTA, dwFunc, [["s", "" Text]], false)
}
isInChat() {	
	if (!checkHandles())
		return -1
	
	return (readDWORD(hGTA, readDWORD(hGTA, dwSAMP + 0x26E8F4) + 0x61) > 0)
}
getAuthor() {
	return "vk.com/idDrygok"
}
showDialog(style, caption, text, button1, button2 := "", id := 1) {
	style += 0
	style := Floor(style)
	id += 0
	id := Floor(id)
	caption := "" caption
	text := "" text
	button1 := "" button1
	button2 := "" button2

	if (id < 0 || id > 32767 || style < 0 || style > 5 || StrLen(caption) > 64 || StrLen(text) > 4096 || StrLen(button1) > 10 || StrLen(button2) > 10)
		return false

	if (!checkHandles())
		return -1

	dwFunc := dwSAMP + 0x6F8C0
	sleep 200
	dwAddress := readDWORD(hGTA, dwSAMP + 0x26E898)
	if (!dwAddress) {
		return -1
	}

	writeString(hGTA, pParam5, caption)
	writeString(hGTA, pParam1, text)
	writeString(hGTA, pParam5 + 512, button1)
	writeString(hGTA, pParam5+StrLen(caption) + 1, button2)

	dwLen := 5 + 7 * 5 + 5 + 1
	VarSetCapacity(injectData, dwLen, 0)

	NumPut(0xB9, injectData, 0, "UChar")
	NumPut(dwAddress, injectData, 1, "UInt")
	NumPut(0x68, injectData, 5, "UChar")
	NumPut(1, injectData, 6, "UInt")
	NumPut(0x68, injectData, 10, "UChar")
	NumPut(pParam5 + StrLen(caption) + 1, injectData, 11, "UInt")
	NumPut(0x68, injectData, 15, "UChar")
	NumPut(pParam5 + 512, injectData, 16, "UInt")
	NumPut(0x68, injectData, 20, "UChar")
	NumPut(pParam1, injectData, 21, "UInt")
	NumPut(0x68, injectData, 25, "UChar")
	NumPut(pParam5, injectData, 26, "UInt")
	NumPut(0x68, injectData, 30, "UChar")
	NumPut(style, injectData, 31, "UInt")
	NumPut(0x68, injectData, 35, "UChar")
	NumPut(id, injectData, 36, "UInt")

	NumPut(0xE8, injectData, 40, "UChar")
	offset := dwFunc - (pInjectFunc + 45)
	NumPut(offset, injectData, 41, "Int")
	NumPut(0xC3, injectData, 45, "UChar")

	writeRaw(hGTA, pInjectFunc, &injectData, dwLen)

	hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)

	waitForSingleObject(hThread, 0xFFFFFFFF)
	closeProcess(hThread)
}
getClosestPlayerId() {
dist := 0x7fffffff
p := getStreamedInPlayersInfo()
if(!p)
return -1
lpos := getCoordinates()
if(!lpos)
return -1
id := -1
For i, o in p
{
t:=getDist(lpos,o.POS)
if(t<dist)
{
dist := t
id := i
}
}
return id
}
getStreamedInPlayersInfo() {
r:=[]
if(iRefreshScoreboard+iUpdateTick > A_TickCount)
{
For i, o in oScoreboardData
{
if(o.HasKey("PED"))
{
p := getPedCoordinates(o.PED)
if(p)
{
o.POS := p
r[i] := o
}
}
}
return r
}
if(!updateOScoreboardData())
return ""
For i, o in oScoreboardData
{
if(o.HasKey("PED"))
{
p := getPedCoordinates(o.PED)
if(p)
{
o.POS := p
r[i] := o
}
}
}
return r
}
getDist(pos1,pos2) {
if(!pos1 || !pos2)
return 0
return Sqrt((pos1[1]-pos2[1])*(pos1[1]-pos2[1])+(pos1[2]-pos2[2])*(pos1[2]-pos2[2])+(pos1[3]-pos2[3])*(pos1[3]-pos2[3]))
}
getPedCoordinates(dwPED) {
dwPED += 0
dwPED := Floor(dwPED)
if(!dwPED)
return ""
if(!checkHandles())
return ""
dwAddress := readDWORD(hGTA, dwPED + 0x14)
if(ErrorLevel || dwAddress==0) {
ErrorLevel := ERROR_READ_MEMORY
return ""
}
fX := readFloat(hGTA, dwAddress + 0x30)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return ""
}
fY := readFloat(hGTA, dwAddress + 0x34)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return ""
}
fZ := readFloat(hGTA, dwAddress + 0x38)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return ""
}
ErrorLevel := ERROR_OK
return [fX, fY, fZ]
}
getPedById(dwId) {
dwId += 0
dwId := Floor(dwId)
if(dwId < 0 || dwId >= SAMP_PLAYER_MAX)
return 0
if(iRefreshScoreboard+iUpdateTick > A_TickCount)
{
if(oScoreboardData[dwId])
{
if(oScoreboardData[dwId].HasKey("PED"))
return oScoreboardData[dwId].PED
}
return 0
}
if(!updateOScoreboardData())
return 0
if(oScoreboardData[dwId])
{
if(oScoreboardData[dwId].HasKey("PED"))
return oScoreboardData[dwId].PED
}
return 0
}
updateOScoreboardData() {
if(!checkHandles())
return 0
oScoreboardData := []
if(!updateScoreboardDataEx())
return 0
iRefreshScoreboard := A_TickCount
dwAddress := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)
if(ErrorLevel || dwAddress==0) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
dwAddress := readDWORD(hGTA, dwAddress + SAMP_PPOOLS_OFFSET)
if(ErrorLevel || dwAddress==0) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
dwPlayers := readDWORD(hGTA, dwAddress + SAMP_PPOOL_PLAYER_OFFSET)
if(ErrorLevel || dwPlayers==0) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
wID := readMem(hGTA, dwPlayers + SAMP_SLOCALPLAYERID_OFFSET, 2, "Short")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
dwPing := readMem(hGTA, dwPlayers + SAMP_ILOCALPLAYERPING_OFFSET, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
dwScore := readMem(hGTA, dwPlayers + SAMP_ILOCALPLAYERSCORE_OFFSET, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
dwTemp := readMem(hGTA, dwPlayers + SAMP_ISTRLEN_LOCALPLAYERNAME_OFFSET, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
sUsername := ""
if(dwTemp <= 0xf) {
sUsername := readString(hGTA, dwPlayers + SAMP_SZLOCALPLAYERNAME_OFFSET, 16)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
}
else {
dwAddress := readDWORD(hGTA, dwPlayers + SAMP_PSZLOCALPLAYERNAME_OFFSET)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
sUsername := readString(hGTA, dwAddress, 25)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
}
oScoreboardData[wID] := Object("NAME", sUsername, "ID", wID, "PING", dwPing, "SCORE", dwScore, "ISNPC", 0)
Loop, % SAMP_PLAYER_MAX
{
i := A_Index-1
dwRemoteplayer := readDWORD(hGTA, dwPlayers+SAMP_PREMOTEPLAYER_OFFSET+i*4)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
if(dwRemoteplayer==0)
continue
dwPing := readMem(hGTA, dwRemoteplayer + SAMP_IPING_OFFSET, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
dwScore := readMem(hGTA, dwRemoteplayer + SAMP_ISCORE_OFFSET, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
dwIsNPC := readMem(hGTA, dwRemoteplayer + SAMP_ISNPC_OFFSET, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
dwTemp := readMem(hGTA, dwRemoteplayer + SAMP_ISTRLENNAME___OFFSET, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
sUsername := ""
if(dwTemp <= 0xf)
{
sUsername := readString(hGTA, dwRemoteplayer+SAMP_SZPLAYERNAME_OFFSET, 16)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
}
else {
dwAddress := readDWORD(hGTA, dwRemoteplayer + SAMP_PSZPLAYERNAME_OFFSET)
if(ErrorLevel || dwAddress==0) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
sUsername := readString(hGTA, dwAddress, 25)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
}
o := Object("NAME", sUsername, "ID", i, "PING", dwPing, "SCORE", dwScore, "ISNPC", dwIsNPC)
oScoreboardData[i] := o
dwRemoteplayerData := readDWORD(hGTA, dwRemoteplayer + 0x0)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
if(dwRemoteplayerData==0)
continue
dwAddress := readDWORD(hGTA, dwRemoteplayerData + 489)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
if(dwAddress)
{
ix := readMem(hGTA, dwRemoteplayerData + 493, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
iy := readMem(hGTA, dwRemoteplayerData + 497, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
iz := readMem(hGTA, dwRemoteplayerData + 501, 4, "Int")
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
o.MPOS := [ix, iy, iz]
}
dwpSAMP_Actor := readDWORD(hGTA, dwRemoteplayerData + 0x0)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
if(dwpSAMP_Actor==0)
continue
dwPed := readDWORD(hGTA, dwpSAMP_Actor + 676)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
if(dwPed==0)
continue
o.PED := dwPed
fHP := readFloat(hGTA, dwRemoteplayerData + 444)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
fARMOR := readFloat(hGTA, dwRemoteplayerData + 440)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return 0
}
o.HP := fHP
o.ARMOR := fARMOR
}
ErrorLevel := ERROR_OK
return 1
}
updateScoreboardDataEx() {
if(!checkHandles())
return false
dwAddress := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)
if(ErrorLevel || dwAddress==0) {
ErrorLevel := ERROR_READ_MEMORY
return false
}
dwFunc := dwSAMP + FUNC_UPDATESCOREBOARD
VarSetCapacity(injectData, 11, 0)
NumPut(0xB9, injectData, 0, "UChar")
NumPut(dwAddress, injectData, 1, "UInt")
NumPut(0xE8, injectData, 5, "UChar")
offset := dwFunc - (pInjectFunc + 10)
NumPut(offset, injectData, 6, "Int")
NumPut(0xC3, injectData, 10, "UChar")
writeRaw(hGTA, pInjectFunc, &injectData, 11)
if(ErrorLevel)
return false
hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
if(ErrorLevel)
return false
waitForSingleObject(hThread, 0xFFFFFFFF)
closeProcess(hThread)
return true
}
