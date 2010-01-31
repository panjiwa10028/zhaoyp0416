cd ./mysql-5.1.30-win32/bin/
mysqld -install
set temp_path=%path%
@reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t reg_expand_sz /d "%temp_path%;%cd%;" /f
pause