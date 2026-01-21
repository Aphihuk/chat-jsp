package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import config.db.DBconnect;

@WebServlet("/servlet/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if(username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "กรุณากรอกชื่อผู้ใช้และรหัสผ่าน");
            request.getRequestDispatcher("/src/page/login.jsp").forward(request, response);
            return;
        }
        
        try {
            Connection conn = DBconnect.getConnection();
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username.trim());
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", username.trim());
                session.setAttribute("userid", rs.getInt("id"));
                session.setAttribute("firstname", rs.getString("firstname"));
                session.setAttribute("lastname", rs.getString("lastname"));
                
                rs.close();
                pstmt.close();
                conn.close();
                
                response.sendRedirect(request.getContextPath() + "/src/page/chat.jsp");
            } else {
                rs.close();
                pstmt.close();
                conn.close();
                
                request.setAttribute("error", "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
                request.getRequestDispatcher("/src/page/login.jsp").forward(request, response);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "เกิดข้อผิดพลาดในการเข้าสู่ระบบ");
            request.getRequestDispatcher("/src/page/login.jsp").forward(request, response);
        }
    }
}
