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

@WebServlet("/servlet/GetMessagesServlet")
public class GetMessagesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageDAO messageDAO = new MessageDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String currentUser = (String) session.getAttribute("user");
        
        if(currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "กรุณาเข้าสู่ระบบ");
            return;
        }
        
        String fromUser = request.getParameter("fromUser");
        String toUser = request.getParameter("toUser");
        
        // Verify that the requester is one of the participants
        if(!currentUser.equals(fromUser) && !currentUser.equals(toUser)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized");
            return;
        }
        
        List<Message> messages = messageDAO.getMessages(fromUser, toUser);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        // Build JSON manually
        out.print("[");
        for(int i = 0; i < messages.size(); i++) {
            Message msg = messages.get(i);
            if(i > 0) out.print(",");
            out.print("{");
            out.print("\"id\":" + msg.getId() + ",");
            out.print("\"fromUser\":\"" + escapeJson(msg.getFromUser()) + "\",");
            out.print("\"toUser\":\"" + escapeJson(msg.getToUser()) + "\",");
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
