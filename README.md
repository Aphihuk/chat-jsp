# Chat LINE - Web Chat Application

แอปพลิเคชันแชทเว็บที่ออกแบบให้คล้ายกับ LINE โดยใช้ JSP, Servlet, Bootstrap 5, CSS และ JavaScript

## คุณสมบัติ

- ✅ ระบบเข้าสู่ระบบและสมัครสมาชิก
- ✅ หน้าจอแชทแบบ LINE (สีเขียว, ฟองข้อความ)
- ✅ ส่งและรับข้อความแบบ Real-time
- ✅ รายชื่อผู้ติดต่อ
- ✅ ระบบฐานข้อมูล MySQL
- ✅ Responsive Design

## เทคโนโลยีที่ใช้

- **Backend**: JSP, Java Servlet
- **Frontend**: Bootstrap 5, CSS3, JavaScript
- **Database**: MySQL
- **Server**: Apache Tomcat

## การติดตั้ง

### 1. ฐานข้อมูล

รันไฟล์ `database.sql` เพื่อสร้างฐานข้อมูลและตาราง:

```sql
mysql -u root -p < database.sql
```

หรือรันคำสั่ง SQL ใน MySQL:

```bash
mysql -u root -p
source database.sql
```

### 2. การตั้งค่า

แก้ไขไฟล์ `src/config/db/DBconnect.java` เพื่อตั้งค่าการเชื่อมต่อฐานข้อมูล:

```java
private static String url = "jdbc:mysql://localhost:3306/chatgtdb?useSSL=false&serverTimezone=UTC";
private static String username = "root";
private static String password = "your_password";
```

### 3. ไลบรารีที่จำเป็น

- MySQL JDBC Driver (mysql-connector-java-8.0.x.jar)
  - วางไฟล์ใน `WEB-INF/lib/`

### 4. การคอมไพล์

คอมไพล์ไฟล์ Java ทั้งหมด:

```bash
javac -cp "%TOMCAT%\lib\servlet-api.jar;%TOMCAT%\lib\jsp-api.jar" -d WEB-INF\classes src\config\db\DBconnect.java
javac -cp "%TOMCAT%\lib\servlet-api.jar;%TOMCAT%\lib\jsp-api.jar;WEB-INF\classes" -d WEB-INF\classes src\model\Message.java
javac -cp "%TOMCAT%\lib\servlet-api.jar;%TOMCAT%\lib\jsp-api.jar;WEB-INF\classes" -d WEB-INF\classes src\dao\MessageDAO.java
javac -cp "%TOMCAT%\lib\servlet-api.jar;%TOMCAT%\lib\jsp-api.jar;WEB-INF\classes" -d WEB-INF\classes src\servlet\*.java
```

หรือใช้ IDE เช่น Eclipse/IntelliJ IDEA

### 5. รันแอปพลิเคชัน

1. วางโฟลเดอร์ `chat-jsp` ใน `webapps` ของ Tomcat
2. เริ่มต้น Tomcat Server
3. เปิดเบราว์เซอร์ไปที่: `http://localhost:8080/chat-jsp`

## การใช้งาน

### สมัครสมาชิก
1. ไปที่หน้า Sign Up
2. กรอกข้อมูล: ชื่อ, นามสกุล, ชื่อผู้ใช้, รหัสผ่าน
3. คลิก "สมัครสมาชิก"

### เข้าสู่ระบบ
1. ไปที่หน้า Login
2. กรอกชื่อผู้ใช้และรหัสผ่าน
3. คลิก "เข้าสู่ระบบ"

### ส่งข้อความ
1. เลือกผู้ติดต่อจากรายชื่อด้านซ้าย
2. พิมพ์ข้อความในช่องด้านล่าง
3. กด Enter หรือคลิกปุ่มส่ง

## โครงสร้างโปรเจกต์

```
chat-jsp/
├── src/
│   ├── config/
│   │   └── db/
│   │       └── DBconnect.java
│   ├── dao/
│   │   └── MessageDAO.java
│   ├── model/
│   │   └── Message.java
│   ├── servlet/
│   │   ├── LoginServlet.java
│   │   ├── SignupServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── SendMessageServlet.java
│   │   ├── GetMessagesServlet.java
│   │   └── GetLastMessageServlet.java
│   ├── page/
│   │   ├── login.jsp
│   │   ├── signup.jsp
│   │   ├── welcome.jsp
│   │   └── chat.jsp
│   └── includes/
│       ├── sidebar.html
│       └── sidecontent.html
├── WEB-INF/
│   ├── web.xml
│   └── lib/
│       └── mysql-connector-java-8.0.x.jar
├── chat.css
├── chat.js
├── main.css
├── database.sql
└── index.jsp
```

## ฐานข้อมูล

### ตาราง users
- id (INT, PRIMARY KEY)
- firstname (VARCHAR)
- lastname (VARCHAR)
- username (VARCHAR, UNIQUE)
- password (VARCHAR)
- email (VARCHAR)
- phone (VARCHAR)
- created_at (TIMESTAMP)

### ตาราง messages
- id (INT, PRIMARY KEY)
- from_user (VARCHAR)
- to_user (VARCHAR)
- message (TEXT)
- timestamp (TIMESTAMP)

## หมายเหตุ

- แอปพลิเคชันนี้ใช้การ Polling (ตรวจสอบข้อความใหม่ทุก 2 วินาที) สำหรับ Real-time chat
- สำหรับ Production ควรใช้ WebSocket สำหรับประสิทธิภาพที่ดีกว่า
- รหัสผ่านควรเข้ารหัสก่อนเก็บในฐานข้อมูล (ใช้ BCrypt หรือ SHA-256)

## ผู้พัฒนา

สร้างด้วย JSP, Servlet, Bootstrap 5 และ MySQL
