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
    <title>เข้าสู่ระบบ - Chat LINE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            padding: 40px;
            width: 100%;
            max-width: 400px;
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
        .logo-container p {
            color: #666;
            font-size: 14px;
        }
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            padding: 12px 15px;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: #00c300;
            box-shadow: 0 0 0 0.2rem rgba(0, 195, 0, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #00c300 0%, #00a000 100%);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: transform 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 195, 0, 0.3);
        }
        .btn-signup {
            border: 2px solid #00c300;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            color: #00c300;
            width: 100%;
            background: white;
            transition: all 0.3s;
        }
        .btn-signup:hover {
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
    <div class="login-container">
        <div class="logo-container">
            <img src="../assets/images/logo.jpg" alt="Logo">
            <h2>Chat LINE</h2>
            <p>ເຂົ້າສູ່ລະບົບເພື່ອເລີ່ມຕົ້ນການສົນທະນາ.</p>
        </div>
        
        <% 
            String error = (String) request.getAttribute("error");
            if(error != null) {
        %>
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i><%= error %>
        </div>
        <% } %>
        
        <form method="post" action="<%= request.getContextPath() %>/servlet/LoginServlet">
            <div class="mb-3">
                <label for="username" class="form-label">
                    <i class="fas fa-user me-2"></i>ຊື່ຜູ້ໃຊ້
                </label>
                <input type="text" class="form-control" id="username" name="username" required autofocus>
            </div>
            
            <div class="mb-4">
                <label for="password" class="form-label">
                    <i class="fas fa-lock me-2"></i>ລະຫັດຜ່ານ
                </label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn btn-login mb-3">
                <i class="fas fa-sign-in-alt me-2"></i>ເຂົ້າສູ່ລະບົບ
            </button>
            
            <a href="signup.jsp" class="btn btn-signup">
                <i class="fas fa-user-plus me-2"></i>ສະໝັກສະມາຊິກ
            </a>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
