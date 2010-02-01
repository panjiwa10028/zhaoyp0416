cd ./mysql-5.1.30-win32/bin/
net stop mysql
mysqld -remove
@reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v MYSQL_HOME /f
@echo remove mysql
pause