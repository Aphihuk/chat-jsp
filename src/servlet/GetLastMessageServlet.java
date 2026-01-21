package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Message;
import dao.MessageDAO;

@WebServlet("/servlet/GetLastMessageServlet")
public class GetLastMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageDAO messageDAO = new MessageDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String currentUser = (String) session.getAttribute("user");
        
        if(currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "ກະລຸນາເຂົ້າສູ່ລະບົບ");
            return;
        }
        
        String userId = request.getParameter("userId");
        
        if(!currentUser.equals(userId)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized");
            return;
        }
        
        List<Message> messages = messageDAO.getLastMessages(userId);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        // Build JSON manually
        out.print("[");
        for(int i = 0; i < messages.size(); i++) {
            Message msg = messages.get(i);
            // Determine the other user
            String otherUser = msg.getFromUser().equals(userId) ? msg.getToUser() : msg.getFromUser();
            
            if(i > 0) out.print(",");
            out.print("{");
            out.print("\"username\":\"" + escapeJson(otherUser) + "\",");
            out.print("\"message\":\"" + escapeJson(msg.getMessage()) + "\",");
            out.print("\"timestamp\":" + msg.getTimestamp().getTime());
            out.print("}");
        }
        out.print("]");
        out.flush();
    }
    
    private String escapeJson(String str) {
        if(str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
