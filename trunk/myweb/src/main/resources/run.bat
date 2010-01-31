set CATALINA_HOME=./apache-tomcat-6.0.18
set JAVA_HOME=./jdk1.6.0_11
set classpath=%classpath%;./jdk1.6.0_11/bin;./mysql-5.1.30-win32/bin
net start mysql
./apache-tomcat-6.0.18/bin/startup.bat