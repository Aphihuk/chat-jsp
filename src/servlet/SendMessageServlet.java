package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Message;
import dao.MessageDAO;

@WebServlet("/servlet/SendMessageServlet")
public class SendMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageDAO messageDAO = new MessageDAO();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String currentUser = (String) session.getAttribute("user");
        
        if(currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "ກະລຸນາເຂົ້າສູ່ລະບົບ");
            return;
        }
        
        String fromUser = request.getParameter("fromUser");
        String toUser = request.getParameter("toUser");
        String message = request.getParameter("message");
        
        // Verify that the sender is the current logged-in user
        if(!currentUser.equals(fromUser)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized");
            return;
        }
        
        if(message == null || message.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Message cannot be empty");
            return;
        }
        
        Message msg = new Message(fromUser, toUser, message.trim());
        boolean success = messageDAO.sendMessage(msg);
        
        if(success) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Message sent successfully");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to send message");
        }
    }
}
