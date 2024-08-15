@echo off

REM Сбор информации о системе
systeminfo > C:\Users\%USERNAME%\Desktop\diagnostic_report.txt

REM Информация о процессоре и оперативной памяти
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt
wmic memorychip get Capacity >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt

REM Сетевые интерфейсы и IP-адреса
ipconfig /all >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt

REM Список установленных программ
wmic product get Name,Version >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt

REM Информация о текущем пользователе
echo Имя пользователя: %USERNAME% >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt
echo Домашний каталог: %USERPROFILE% >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt

REM Сбор информации об учетной записи пользователя из Active Directory (если компьютер в домене)
if exist %windir%\System32\dsquery.exe (
    dsquery user -samid %USERNAME% >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt
    dsget user %USERNAME% -email -display -memberof >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt
)

echo Сбор данных завершен. Отчет сохранен на рабочем столе.

pause
