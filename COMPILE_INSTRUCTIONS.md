# วิธีคอมไพล์ Java Files

## วิธีที่ 1: ใช้ Script (แนะนำ)

### Windows (Batch)
```cmd
compile.bat
```

### Windows PowerShell
```powershell
.\compile.ps1
```

## วิธีที่ 2: คอมไพล์ด้วยมือ

เปิด Command Prompt หรือ PowerShell ในโฟลเดอร์โปรเจกต์:

```cmd
cd d:\apache-tomcat-10.1.48\webapps\chat-jsp

REM Set Tomcat path
set TOMCAT_HOME=d:\apache-tomcat-10.1.48

REM คอมไพล์ config ก่อน
javac -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar" -d WEB-INF\classes src\config\db\DBconnect.java

REM คอมไพล์ model
javac -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;WEB-INF\classes" -d WEB-INF\classes src\model\Message.java

REM คอมไพล์ dao
javac -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;WEB-INF\classes" -d WEB-INF\classes src\dao\MessageDAO.java

REM คอมไพล์ servlets
javac -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;WEB-INF\classes" -d WEB-INF\classes src\servlet\*.java
```

## วิธีที่ 3: ใช้ IDE (Eclipse/IntelliJ IDEA)

1. สร้าง Dynamic Web Project ใน Eclipse หรือเปิดโปรเจกต์ใน IntelliJ
2. กำหนด Tomcat 10 เป็น Server Runtime
3. เพิ่ม JAR files จาก `TOMCAT_HOME/lib/`:
   - servlet-api.jar
   - jsp-api.jar
4. Build โปรเจกต์

## หมายเหตุ

- Tomcat 10 ใช้ **Jakarta EE** ไม่ใช่ Java EE
- ต้องใช้ `jakarta.servlet.*` แทน `javax.servlet.*`
- ต้องคอมไพล์ในลำดับ: config → model → dao → servlets
- ต้องมี MySQL JDBC Driver ใน `WEB-INF/lib/` สำหรับรันแอปพลิเคชัน

## เพิ่ม MySQL JDBC Driver

1. ดาวน์โหลด MySQL Connector/J จาก: https://dev.mysql.com/downloads/connector/j/
2. คัดลอกไฟล์ `mysql-connector-java-8.0.x.jar` ไปไว้ใน `WEB-INF/lib/`
