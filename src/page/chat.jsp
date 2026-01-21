<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.db.DBconnect" %>
<%
    String userId = (String) session.getAttribute("user");
    if(userId == null){
        response.sendRedirect("login.jsp");
        return;
    }
    
    String chatWith = request.getParameter("chatWith");
    if(chatWith == null) chatWith = "";
%>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat - LINE Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../../chat.css">
</head>
<body>
    <div class="chat-container">
        <!-- Sidebar - Contact List -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="user-profile">
                    <img src="../../assets/images/logo.jpg" alt="Profile" class="profile-img">
                    <span class="username"><%= userId %></span>
                </div>
                <div class="header-actions">
                    <button class="btn-icon" title="New Chat"><i class="fas fa-edit"></i></button>
                    <button class="btn-icon" title="Settings"><i class="fas fa-cog"></i></button>
                </div>
            </div>
            
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="ค้นหาเพื่อน..." id="searchContact">
            </div>
            
            <div class="contact-list" id="contactList">
                <%
                    try {
                        Connection conn = DBconnect.getConnection();
                        String sql = "SELECT DISTINCT u.username, u.firstname, u.lastname FROM users u WHERE u.username != ? ORDER BY u.username";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, userId);
                        ResultSet rs = pstmt.executeQuery();
                        
                        while(rs.next()) {
                            String contactUser = rs.getString("username");
                            String firstName = rs.getString("firstname");
                            String lastName = rs.getString("lastname");
                            String displayName = (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : "");
                            if(displayName.trim().isEmpty()) displayName = contactUser;
                            
                            String activeClass = chatWith.equals(contactUser) ? "active" : "";
                %>
                <div class="contact-item <%= activeClass %>" onclick="loadChat('<%= contactUser %>')">
                    <div class="contact-avatar">
                        <img src="../../assets/images/logo.jpg" alt="<%= displayName %>">
                    </div>
                    <div class="contact-info">
                        <div class="contact-name"><%= displayName %></div>
                        <div class="contact-preview" id="preview_<%= contactUser %>">เริ่มสนทนา</div>
                    </div>
                    <div class="contact-time" id="time_<%= contactUser %>"></div>
                </div>
                <%
                        }
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                %>
            </div>
        </div>
        
        <!-- Main Chat Area -->
        <div class="chat-main">
            <% if(chatWith.isEmpty()) { %>
            <div class="empty-chat">
                <i class="fas fa-comments fa-4x"></i>
                <h3>เลือกการสนทนา</h3>
                <p>เลือกเพื่อนจากรายชื่อเพื่อเริ่มสนทนา</p>
            </div>
            <% } else { %>
            <!-- Chat Header -->
            <div class="chat-header">
                <div class="chat-user-info">
                    <img src="../../assets/images/logo.jpg" alt="User" class="chat-avatar">
                    <div>
                        <div class="chat-user-name" id="chatUserName"><%= chatWith %></div>
                        <div class="chat-status">ออนไลน์</div>
                    </div>
                </div>
                <div class="chat-actions">
                    <button class="btn-icon" title="โทร"><i class="fas fa-phone"></i></button>
                    <button class="btn-icon" title="วิดีโอคอล"><i class="fas fa-video"></i></button>
                    <button class="btn-icon" title="ข้อมูลเพิ่มเติม"><i class="fas fa-info-circle"></i></button>
                </div>
            </div>
            
            <!-- Messages Area -->
            <div class="messages-container" id="messagesContainer">
                <div class="messages" id="messages">
                    <!-- Messages will be loaded here via AJAX -->
                </div>
            </div>
            
            <!-- Input Area -->
            <div class="chat-input-area">
                <button class="btn-icon" title="แนบไฟล์"><i class="fas fa-paperclip"></i></button>
                <button class="btn-icon" title="อีโมจิ"><i class="far fa-smile"></i></button>
                <input type="text" class="chat-input" id="messageInput" placeholder="พิมพ์ข้อความ..." onkeypress="handleKeyPress(event)">
                <button class="btn-send" id="sendBtn" onclick="sendMessage()">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
            <% } %>
        </div>
    </div>
    
    <input type="hidden" id="currentChatWith" value="<%= chatWith %>">
    <input type="hidden" id="currentUserId" value="<%= userId %>">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../../chat.js"></script>
</body>
</html>
