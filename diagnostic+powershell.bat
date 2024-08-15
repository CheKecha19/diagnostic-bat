@echo off

REM Перенаправление вывода команд в файл с кодировкой UTF-16
powershell -command "systeminfo | Out-File -FilePath 'C:\Users\%USERNAME%\Desktop\diagnostic_report.txt' -Encoding Unicode"
powershell -command "wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors | Out-File -Append -FilePath 'C:\Users\%USERNAME%\Desktop\diagnostic_report.txt' -Encoding Unicode"
powershell -command "wmic memorychip get Capacity | Out-File -Append -FilePath 'C:\Users\%USERNAME%\Desktop\diagnostic_report.txt' -Encoding Unicode"
powershell -command "ipconfig /all | Out-File -Append -FilePath 'C:\Users\%USERNAME%\Desktop\diagnostic_report.txt' -Encoding Unicode"
powershell -command "wmic product get Name,Version | Out-File -Append -FilePath 'C:\Users\%USERNAME%\Desktop\diagnostic_report.txt' -Encoding Unicode"

REM Информация о текущем пользователе
echo Имя пользователя: %USERNAME% >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt
echo Домашний каталог: %USERPROFILE% >> C:\Users\%USERNAME%\Desktop\diagnostic_report.txt

REM Добавление информации из AD (если доступно)
if exist %windir%\System32\dsquery.exe (
    powershell -command "dsquery user -samid %USERNAME% | Out-File -Append -FilePath 'C:\Users\%USERNAME%\Desktop\diagnostic_report.txt' -Encoding Unicode"
    powershell -command "dsget user %USERNAME% -email -display -memberof | Out-File -Append -FilePath 'C:\Users\%USERNAME%\Desktop\diagnostic_report.txt' -Encoding Unicode"
)

echo Сбор данных завершен. Отчет сохранен на рабочем столе.

pause
