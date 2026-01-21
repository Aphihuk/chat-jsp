<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="config.db.DBconnect"%>
<%@ page import="java.sql.*"%>
<%
if(session.getAttribute("user") != null){
    response.sendRedirect("chat.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome - Chat LINE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #00c300 0%, #00a000 100%);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .welcome-container {
            text-align: center;
            color: white;
            padding: 40px;
        }
        .welcome-container img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 30px;
            border: 5px solid rgba(255,255,255,0.3);
        }
        .welcome-container h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 15px;
        }
        .welcome-container p {
            font-size: 1.2rem;
            margin-bottom: 40px;
            opacity: 0.9;
        }
        .btn-welcome {
            padding: 15px 40px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 30px;
            margin: 10px;
            transition: transform 0.2s;
        }
        .btn-welcome:hover {
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <img src="../assets/images/logo.jpg" alt="Logo">
        <h1>ยินดีต้อนรับสู่ Chat LINE</h1>
        <p>บริการข้อความฟรี, การโทรเสียง และวิดีโอที่ขับเคลื่อนด้วย AI</p>
        <%
        Connection conn = DBconnect.getConnection();
        if(conn != null) {
        %>
        <div>
            <a href="login.jsp" class="btn btn-light btn-welcome">
                <i class="fas fa-sign-in-alt me-2"></i>เข้าสู่ระบบ
            </a>
            <a href="signup.jsp" class="btn btn-outline-light btn-welcome">
                <i class="fas fa-user-plus me-2"></i>สมัครสมาชิก
            </a>
        </div>
        <% } else { %>
        <div class="alert alert-warning">
            <i class="fas fa-exclamation-triangle me-2"></i>ไม่สามารถเชื่อมต่อฐานข้อมูลได้
        </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>