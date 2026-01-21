package dao;

import model.Message;
import config.db.DBconnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {
    
    // Send a message
    public boolean sendMessage(Message message) {
        String sql = "INSERT INTO messages (from_user, to_user, message, timestamp) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBconnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, message.getFromUser());
            pstmt.setString(2, message.getToUser());
            pstmt.setString(3, message.getMessage());
            pstmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get messages between two users
    public List<Message> getMessages(String user1, String user2) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM messages WHERE (from_user = ? AND to_user = ?) OR (from_user = ? AND to_user = ?) ORDER BY timestamp ASC";
        
        try (Connection conn = DBconnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user1);
            pstmt.setString(2, user2);
            pstmt.setString(3, user2);
            pstmt.setString(4, user1);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setFromUser(rs.getString("from_user"));
                msg.setToUser(rs.getString("to_user"));
                msg.setMessage(rs.getString("message"));
                msg.setTimestamp(rs.getTimestamp("timestamp"));
                messages.add(msg);
            }
            
            rs.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return messages;
    }
    
    // Get last message for each contact
    public List<Message> getLastMessages(String userId) {
        List<Message> messages = new ArrayList<>();
        // Simplified query: get the most recent message for each conversation
        String sql = "SELECT m.* FROM messages m " +
                     "INNER JOIN ( " +
                     "  SELECT " +
                     "    CASE WHEN from_user = ? THEN to_user ELSE from_user END as other_user, " +
                     "    MAX(timestamp) as max_time " +
                     "  FROM messages " +
                     "  WHERE from_user = ? OR to_user = ? " +
                     "  GROUP BY other_user " +
                     ") latest ON " +
                     "  ((m.from_user = ? AND m.to_user = latest.other_user) OR " +
                     "   (m.from_user = latest.other_user AND m.to_user = ?)) " +
                     "  AND m.timestamp = latest.max_time " +
                     "ORDER BY m.timestamp DESC";
        
        try (Connection conn = DBconnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userId);
            pstmt.setString(2, userId);
            pstmt.setString(3, userId);
            pstmt.setString(4, userId);
            pstmt.setString(5, userId);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setFromUser(rs.getString("from_user"));
                msg.setToUser(rs.getString("to_user"));
                msg.setMessage(rs.getString("message"));
                msg.setTimestamp(rs.getTimestamp("timestamp"));
                messages.add(msg);
            }
            
            rs.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return messages;
    }
}
