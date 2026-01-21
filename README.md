# Chat LINE - ແອັບພລິເຄຊັນເວັບແຊັດ (Web Chat Application)

ແອັບພລິເຄຊັນເວັບແຊັດທີ່ອອກແບບມາໃຫ້ຄ້າຍຄືກັບ LINE ໂດຍໃຊ້ JSP, Servlet, Bootstrap 5, CSS ແລະ JavaScript.

## ຄຸນສົມບັດ

-  ລະບົບເຂົ້າສູ່ລະບົບ ແລະ ສະໝັກສະມາຊິກ
-  ໜ້າຈໍແຊັດແບບ LINE (ສີຂຽວ, ຟອງຂໍ້ຄວາມ)
-  ສົ່ງ ແລະ ຮັບຂໍ້ຄວາມແບບ Real-time
-  ລາຍຊື່ຜູ້ຕິດຕໍ່
-  ລະບົບຖານຂໍ້ມູນ MySQL
-  Responsive Design (ຮອງຮັບການສະແດງຜົນທຸກໜ້າຈໍ)

## ເຕັກໂນໂລຊີທີ່ໃຊ້

- **Backend**: JSP, Java Servlet
- **Frontend**: Bootstrap 5, CSS3, JavaScript
- **Database**: MySQL
- **Server**: Apache Tomcat

## ການຕິດຕັ້ງ

### 1. ຖານຂໍ້ມູນ

ລັນ (Run) ໄຟລ໌ `database.sql` ເພື່ອສ້າງຖານຂໍ້ມູນ ແລະ ຕາຕະລາງ:

```sql
mysql -u root -p < database.sql
```

ຫຼື ລັນຄຳສັ່ງ SQL ໃນ MySQL:

```bash
mysql -u root -p
source database.sql
```

### 2. ການຕັ້ງຄ່າ

ແກ້ໄຂໄຟລ໌ `src/config/db/DBconnect.java` ເພື່ອຕັ້ງຄ່າການເຊື່ອມຕໍ່ຖານຂໍ້ມູນ:

```java
private static String url = "jdbc:mysql://localhost:3306/chatgtdb?useSSL=false&serverTimezone=UTC";
private static String username = "root";
private static String password = "your_password";
```

### 3. ໄລບຣາຣີ (Library) ທີ່ຈຳເປັນ

- MySQL JDBC Driver (mysql-connector-java-8.0.x.jar)
  - ວາງໄຟລ໌ໃນ `WEB-INF/lib/`

### 4. ການຄອມໄພລ໌ (Compile)

ຄອມໄພລ໌ໄຟລ໌ Java ທັງໝົດ:

```bash
javac -cp "%TOMCAT%\lib\servlet-api.jar;%TOMCAT%\lib\jsp-api.jar" -d WEB-INF\classes src\config\db\DBconnect.java
javac -cp "%TOMCAT%\lib\servlet-api.jar;%TOMCAT%\lib\jsp-api.jar;WEB-INF\classes" -d WEB-INF\classes src\model\Message.java
javac -cp "%TOMCAT%\lib\servlet-api.jar;%TOMCAT%\lib\jsp-api.jar;WEB-INF\classes" -d WEB-INF\classes src\dao\MessageDAO.java
javac -cp "%TOMCAT%\lib\servlet-api.jar;%TOMCAT%\lib\jsp-api.jar;WEB-INF\classes" -d WEB-INF\classes src\servlet\*.java
```

ຫຼື ໃຊ້ IDE ເຊັ່ນ Eclipse/IntelliJ IDEA

### 5. ລັນແອັບພລິເຄຊັນ (Run Application)

1. ວາງໂຟນເດີ `chat-jsp` ໃນ `webapps` ຂອງ Tomcat
2. ເລີ່ມຕົ້ນ Tomcat Server
3. ເປີດບຣາວເຊີໄປທີ່: `http://localhost:8080/chat-jsp`

## ການໃຊ້ງານ

### ສະໝັກສະມາຊິກ
1. ໄປທີ່ໜ້າ Sign Up
2. ປ້ອນຂໍ້ມູນ: ຊື່, ນາມສະກຸນ, ຊື່ຜູ້ໃຊ້, ລະຫັດຜ່ານ
3. ຄລິກ "ສະໝັກສະມາຊິກ"

### ເຂົ້າສູ່ລະບົບ
1. ໄປທີ່ໜ້າ Login
2. ປ້ອນຊື່ຜູ້ໃຊ້ ແລະ ລະຫັດຜ່ານ
3. ຄລິກ "ເຂົ້າສູ່ລະບົບ"

### ສົ່ງຂໍ້ຄວາມ
1. ເລືອກຜູ້ຕິດຕໍ່ຈາກລາຍຊື່ດ້ານຊ້າຍ
2. ພິມຂໍ້ຄວາມໃນຊ່ອງດ້ານລຸ່ມ
3. ກົດ Enter ຫຼື ຄລິກປຸ່ມສົ່ງ

## ໂຄງສ້າງໂປຣເຈັກ

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

## ຖານຂໍ້ມູນ

### ຕາຕະລາງ users
- id (INT, PRIMARY KEY)
- firstname (VARCHAR)
- lastname (VARCHAR)
- username (VARCHAR, UNIQUE)
- password (VARCHAR)
- email (VARCHAR)
- phone (VARCHAR)
- created_at (TIMESTAMP)

### ຕາຕະລາງ messages
- id (INT, PRIMARY KEY)
- from_user (VARCHAR)
- to_user (VARCHAR)
- message (TEXT)
- timestamp (TIMESTAMP)

## ຜູ້ພັດທະນາ

ສ້າງດ້ວຍ JSP, Servlet, Bootstrap 5 ແລະ MySQL.
