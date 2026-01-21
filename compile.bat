@echo off
echo Compiling Java files...

REM Set Tomcat home (adjust this path to your Tomcat installation)
set TOMCAT_HOME=d:\apache-tomcat-10.1.48
set CATALINA_HOME=%TOMCAT_HOME%

REM Set classpath - Tomcat 10 uses Jakarta EE
set CLASSPATH=%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;WEB-INF\lib\*

REM Create directories if they don't exist
if not exist "WEB-INF\classes" mkdir WEB-INF\classes
if not exist "WEB-INF\lib" mkdir WEB-INF\lib

REM Compile config first
echo Compiling config...
javac -cp "%CLASSPATH%" -d WEB-INF\classes src\config\db\DBconnect.java

REM Compile model
echo Compiling model...
javac -cp "%CLASSPATH%;WEB-INF\classes" -d WEB-INF\classes src\model\Message.java

REM Compile dao
echo Compiling dao...
javac -cp "%CLASSPATH%;WEB-INF\classes" -d WEB-INF\classes src\dao\MessageDAO.java

REM Compile servlets
echo Compiling servlets...
javac -cp "%CLASSPATH%;WEB-INF\classes" -d WEB-INF\classes src\servlet\*.java

echo Compilation complete!
pause
