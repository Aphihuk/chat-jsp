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
import config.db.DBconnect;

@WebServlet("/servlet/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        // Validate required fields
        if(username == null || password == null || firstname == null || lastname == null ||
           username.trim().isEmpty() || password.trim().isEmpty() || 
           firstname.trim().isEmpty() || lastname.trim().isEmpty()) {
            request.setAttribute("error", "กรุณากรอกข้อมูลที่จำเป็นให้ครบถ้วน");
            request.getRequestDispatcher("/src/page/signup.jsp").forward(request, response);
            return;
        }
        
        if(password.length() < 6) {
            request.setAttribute("error", "รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร");
            request.getRequestDispatcher("/src/page/signup.jsp").forward(request, response);
            return;
        }
        
        try {
            Connection conn = DBconnect.getConnection();
            
            // Check if username already exists
            String checkSql = "SELECT * FROM users WHERE username = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, username.trim());
            ResultSet rs = checkStmt.executeQuery();
            
            if(rs.next()) {
                rs.close();
                checkStmt.close();
                conn.close();
                request.setAttribute("error", " ຊື່ຜູ້ໃຊ້ນີ້ຖືກໃຊ້ແລ້ວ.");
                request.getRequestDispatcher("/src/page/signup.jsp").forward(request, response);
                return;
            }
            rs.close();
            checkStmt.close();
            
            // Insert new user
            String insertSql = "INSERT INTO users (firstname, lastname, username, password, email, phone) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setString(1, firstname.trim());
            insertStmt.setString(2, lastname.trim());
            insertStmt.setString(3, username.trim());
            insertStmt.setString(4, password);
            insertStmt.setString(5, email != null && !email.trim().isEmpty() ? email.trim() : null);
            insertStmt.setString(6, phone != null && !phone.trim().isEmpty() ? phone.trim() : null);
            
            int result = insertStmt.executeUpdate();
            insertStmt.close();
            conn.close();
            
            if(result > 0) {
                response.sendRedirect(request.getContextPath() + "/src/page/login.jsp?success=1");
            } else {
                request.setAttribute("error", "ເກີດຄວາມຜິດພາດຂຶ້ນໃນລະຫວ່າງການລົງທະບຽນສະມາຊິກ.");
                request.getRequestDispatcher("/src/page/signup.jsp").forward(request, response);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "ເກີດຄວາມຜິດພາດຂຶ້ນ.: " + e.getMessage());
            request.getRequestDispatcher("/src/page/signup.jsp").forward(request, response);
        }
    }
}
