# PowerShell script to compile Java files for Tomcat 10

Write-Host "Compiling Java files..." -ForegroundColor Green

# Set Tomcat home (adjust this path to your Tomcat installation)
$TOMCAT_HOME = "d:\apache-tomcat-10.1.48"
$CATALINA_HOME = $TOMCAT_HOME

# Set classpath - Tomcat 10 uses Jakarta EE
$CLASSPATH = "$TOMCAT_HOME\lib\servlet-api.jar;$TOMCAT_HOME\lib\jsp-api.jar;WEB-INF\lib\*"

# Create directories if they don't exist
if (-not (Test-Path "WEB-INF\classes")) {
    New-Item -ItemType Directory -Path "WEB-INF\classes" | Out-Null
}
if (-not (Test-Path "WEB-INF\lib")) {
    New-Item -ItemType Directory -Path "WEB-INF\lib" | Out-Null
}

# Compile config first
Write-Host "Compiling config..." -ForegroundColor Yellow
javac -cp "$CLASSPATH" -d WEB-INF\classes src\config\db\DBconnect.java

# Compile model
Write-Host "Compiling model..." -ForegroundColor Yellow
javac -cp "$CLASSPATH;WEB-INF\classes" -d WEB-INF\classes src\model\Message.java

# Compile dao
Write-Host "Compiling dao..." -ForegroundColor Yellow
javac -cp "$CLASSPATH;WEB-INF\classes" -d WEB-INF\classes src\dao\MessageDAO.java

# Compile servlets
Write-Host "Compiling servlets..." -ForegroundColor Yellow
javac -cp "$CLASSPATH;WEB-INF\classes" -d WEB-INF\classes src\servlet\*.java

Write-Host "Compilation complete!" -ForegroundColor Green
