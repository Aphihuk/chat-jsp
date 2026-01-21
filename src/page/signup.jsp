<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>สมัครสมาชิก - Chat LINE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #00c300 0%, #00a000 100%);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            min-height: 100vh;
            padding: 20px 0;
        }
        .signup-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            padding: 40px;
            max-width: 600px;
            margin: 0 auto;
        }
        .logo-container {
            text-align: center;
            margin-bottom: 30px;
        }
        .logo-container img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-bottom: 15px;
        }
        .logo-container h2 {
            color: #00c300;
            font-weight: 700;
            margin-bottom: 5px;
        }
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            padding: 12px 15px;
            transition: all 0.3s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #00c300;
            box-shadow: 0 0 0 0.2rem rgba(0, 195, 0, 0.25);
        }
        .btn-signup {
            background: linear-gradient(135deg, #00c300 0%, #00a000 100%);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: transform 0.2s;
        }
        .btn-signup:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 195, 0, 0.3);
        }
        .btn-login {
            border: 2px solid #00c300;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            color: #00c300;
            width: 100%;
            background: white;
            transition: all 0.3s;
        }
        .btn-login:hover {
            background: #00c300;
            color: white;
        }
        .alert {
            border-radius: 10px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="logo-container">
            <img src="../assets/images/logo.jpg" alt="Logo">
            <h2>สมัครสมาชิก</h2>
            <p>สร้างบัญชีใหม่เพื่อเริ่มสนทนา</p>
        </div>
        
        <% 
            String error = (String) request.getAttribute("error");
            if(error != null) {
        %>
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i><%= error %>
        </div>
        <% } %>
        
        <form method="post" action="<%= request.getContextPath() %>/servlet/SignupServlet" id="signupForm">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="firstname" class="form-label">
                        <i class="fas fa-user me-2"></i>ชื่อ
                    </label>
                    <input type="text" class="form-control" id="firstname" name="firstname" required>
                </div>
                
                <div class="col-md-6">
                    <label for="lastname" class="form-label">
                        <i class="fas fa-user me-2"></i>นามสกุล
                    </label>
                    <input type="text" class="form-control" id="lastname" name="lastname" required>
                </div>
                
                <div class="col-12">
                    <label for="username" class="form-label">
                        <i class="fas fa-at me-2"></i>ชื่อผู้ใช้
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">@</span>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                </div>
                
                <div class="col-12">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock me-2"></i>รหัสผ่าน
                    </label>
                    <input type="password" class="form-control" id="password" name="password" required minlength="6">
                </div>
                
                <div class="col-12">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope me-2"></i>อีเมล (ไม่บังคับ)
                    </label>
                    <input type="email" class="form-control" id="email" name="email">
                </div>
                
                <div class="col-12">
                    <label for="phone" class="form-label">
                        <i class="fas fa-phone me-2"></i>เบอร์โทรศัพท์
                    </label>
                    <input type="text" class="form-control" id="phone" name="phone">
                </div>
            </div>
            
            <div class="mt-4">
                <button type="submit" class="btn btn-signup mb-3">
                    <i class="fas fa-user-plus me-2"></i>สมัครสมาชิก
                </button>
                
                <a href="login.jsp" class="btn btn-login">
                    <i class="fas fa-sign-in-alt me-2"></i>มีบัญชีแล้ว? เข้าสู่ระบบ
                </a>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            if(password.length < 6) {
                e.preventDefault();
                alert('รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร');
                return false;
            }
        });
    </script>
</body>
</html>
