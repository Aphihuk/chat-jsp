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
                    <img 
                    src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAV1BMVEX6+vqPj4////+Li4u5ubn8/PyIiIiFhYWJiYnk5OShoaGnp6fT09Pn5+eRkZHu7u7Z2dn19fXCwsKamprHx8exsbHOzs7X19eurq6/v7+jo6Pe3t6WlpZaNtXmAAAE3UlEQVR4nO2d25aqOhBFsUIRbgqI4AX//zsP0fa0vUfbBoKm4ljzpfvROapIIGSFKAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIEWamG+P/vn/Owhi5Juu3XZHnp6Lblutm1PT9q5aDKRriVulEqZVBqUSr9pjxh0gyrWOlr273KL05Vh/gyDTkv+jdJIsscEemrNUP9K7oU0W+f6UD1Bz+9rs4xuEOrFSrR/15T7rJwiwjU/y8gF9l3IWoyHxKLAVHxS68AYej1qZDbyRFaIocbaYIjhNHHlajTqygIS2CUqRiquDYqHFAinS0H2S+0WUwijzYThP/KFahjDY8vUWvtIEUkeK5hkkYMz9X83rUoJsQ+pTy2YIrFcJ4ytn8EoZRRCocBEMoostVeFH0LfAUOs4dSK8kpfQ2pbOT4Gp1Et6mvHZr0vEOXPhYQ7vU0TCphRueHAXFj6bsKij95pSrOY9N/xQxktymPLgbJqKfobh3HWhGw0GyIW3d5vuLoeg5f/6j4TdpL9qwczdUoh+DYWhDuhPdpY5PFhdD2dfhboGxdC/ZkMsFZvxMtOH64+9pGnfDjWTBBR7xxT/ku08XqejpcGzTvWub6rXsLnW/EIVfhu7LGNIXMdxnRC16NjRw5FZD2as0F9xuTWU//l7hxmVNeCO/hKaI89dqdAAljBxe4wdxFRp4P7dPpc/2/zNnv5AhFT8X3uBonuE5FMG57/IT4e/VfkDldEU9hFPCyCx+T1XU+6AEzaw4TVH3gQmaZbcpisFV0DDlWkzD3K1Pa8ud0EnbBClotut3NmXUx9B2sd9B2fmZo86DjgVFTOXmr4d+fa4DLuAV4rJ9EF5TOg/fz2ACiBud/rRUiT5vPyF+eIWJ1v3hnGidGMY/566sPione00CR1U21HU9rCs2YWffP+kV8A3fPwQAAIAP7k/1WApJkwpTM/THeFmOfRYJuelhGgo13nYuTaJX3VqCI1W5awDhIUof/K+hzlkZneKY+F7Bmb4uOhXPq3DUv1rQ85t916CaHcrjtegSF51gePDWp1y/o4Q+X5y+p4RjETtPRVxiq6UlnmrovkvPFl9tusS2dTt87SNaInpgh68IBh3eJLhSWxjCcK7h265DX4afP9IsEDa0w1cUaomQkx2+olBLhJwsDT09IrqfEGFt6CkKxY17cNsOb3ujqX2Tobfj+N41mCbeUqVzT56bis+T6t4i6HN/+3va1Gde7z3zhdfd0e4H7jzHb5rN7fg5OzwfUjc3WmGPOvp9NeOW47Iy9P16jXavvf3W/o/+ovyVfeptufsO19Do34IiwmxLnO/1EP8vuQ30sttTJeWIjFcpihE0W/Jf0KhqI0fQbDmZeIz+c9JWxjV4g7lYtlN1LGGz0A+of/jBnOkoJTGMSM1iZdSdzNMhmYbzEiOObkVsZ/sVpv7PDJCdn+wcDfH+UQbIhiByQkzZQc8qpEqSWG5/3sMUlYVOJn5nRieHOpxPzfEoWXcbW0uT8oqHcPS+GH9wVXZ33wT81c18JzCP96F+DfGS5lrvt4d8oy65tTS9bJZOr/k1dc67XV1Foae8Lrv4uamqoS77frfd7nZ9X9ZZ1TQsbEe+E1+Zte+gARJsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACJP/AAFSQ7wNy+LTAAAAAElFTkSuQmCC" 
                    alt="Profile" 
                    class="profile-img">
                    <span class="username"><%= userId %></span>
                </div>
                <div class="header-actions">
                    <button class="btn-icon" title="New Chat"><i class="fas fa-edit"></i></button>
                    <button class="btn-icon" title="Settings"><i class="fas fa-cog"></i></button>
                    <a href="<%= request.getContextPath() %>/servlet/LogoutServlet" class="btn-icon btn-logout" title="ອອກຈາກລະບົບ" onclick="return confirm('ທ່ານຕ້ອງການອອກຈາກລະບົບບໍ??');">
                        <i class="fas fa-sign-out-alt"></i>
                    </a>
                </div>
            </div>
            
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="ຊອກຫາຫມູ່ເພື່ອນ..." id="searchContact">
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
                        <img 
                        src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAV1BMVEX6+vqPj4////+Li4u5ubn8/PyIiIiFhYWJiYnk5OShoaGnp6fT09Pn5+eRkZHu7u7Z2dn19fXCwsKamprHx8exsbHOzs7X19eurq6/v7+jo6Pe3t6WlpZaNtXmAAAE3UlEQVR4nO2d25aqOhBFsUIRbgqI4AX//zsP0fa0vUfbBoKm4ljzpfvROapIIGSFKAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIEWamG+P/vn/Owhi5Juu3XZHnp6Lblutm1PT9q5aDKRriVulEqZVBqUSr9pjxh0gyrWOlr273KL05Vh/gyDTkv+jdJIsscEemrNUP9K7oU0W+f6UD1Bz+9rs4xuEOrFSrR/15T7rJwiwjU/y8gF9l3IWoyHxKLAVHxS68AYej1qZDbyRFaIocbaYIjhNHHlajTqygIS2CUqRiquDYqHFAinS0H2S+0WUwijzYThP/KFahjDY8vUWvtIEUkeK5hkkYMz9X83rUoJsQ+pTy2YIrFcJ4ytn8EoZRRCocBEMoostVeFH0LfAUOs4dSK8kpfQ2pbOT4Gp1Et6mvHZr0vEOXPhYQ7vU0TCphRueHAXFj6bsKij95pSrOY9N/xQxktymPLgbJqKfobh3HWhGw0GyIW3d5vuLoeg5f/6j4TdpL9qwczdUoh+DYWhDuhPdpY5PFhdD2dfhboGxdC/ZkMsFZvxMtOH64+9pGnfDjWTBBR7xxT/ku08XqejpcGzTvWub6rXsLnW/EIVfhu7LGNIXMdxnRC16NjRw5FZD2as0F9xuTWU//l7hxmVNeCO/hKaI89dqdAAljBxe4wdxFRp4P7dPpc/2/zNnv5AhFT8X3uBonuE5FMG57/IT4e/VfkDldEU9hFPCyCx+T1XU+6AEzaw4TVH3gQmaZbcpisFV0DDlWkzD3K1Pa8ud0EnbBClotut3NmXUx9B2sd9B2fmZo86DjgVFTOXmr4d+fa4DLuAV4rJ9EF5TOg/fz2ACiBud/rRUiT5vPyF+eIWJ1v3hnGidGMY/566sPione00CR1U21HU9rCs2YWffP+kV8A3fPwQAAIAP7k/1WApJkwpTM/THeFmOfRYJuelhGgo13nYuTaJX3VqCI1W5awDhIUof/K+hzlkZneKY+F7Bmb4uOhXPq3DUv1rQ85t916CaHcrjtegSF51gePDWp1y/o4Q+X5y+p4RjETtPRVxiq6UlnmrovkvPFl9tusS2dTt87SNaInpgh68IBh3eJLhSWxjCcK7h265DX4afP9IsEDa0w1cUaomQkx2+olBLhJwsDT09IrqfEGFt6CkKxY17cNsOb3ujqX2Tobfj+N41mCbeUqVzT56bis+T6t4i6HN/+3va1Gde7z3zhdfd0e4H7jzHb5rN7fg5OzwfUjc3WmGPOvp9NeOW47Iy9P16jXavvf3W/o/+ovyVfeptufsO19Do34IiwmxLnO/1EP8vuQ30sttTJeWIjFcpihE0W/Jf0KhqI0fQbDmZeIz+c9JWxjV4g7lYtlN1LGGz0A+of/jBnOkoJTGMSM1iZdSdzNMhmYbzEiOObkVsZ/sVpv7PDJCdn+wcDfH+UQbIhiByQkzZQc8qpEqSWG5/3sMUlYVOJn5nRieHOpxPzfEoWXcbW0uT8oqHcPS+GH9wVXZ33wT81c18JzCP96F+DfGS5lrvt4d8oy65tTS9bJZOr/k1dc67XV1Foae8Lrv4uamqoS77frfd7nZ9X9ZZ1TQsbEe+E1+Zte+gARJsAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACJP/AAFSQ7wNy+LTAAAAAElFTkSuQmCC"
                         alt="<%= displayName %>">
                    </div>
                    <div class="contact-info">
                        <div class="contact-name"><%= displayName %></div>
                        <div class="contact-preview" id="preview_<%= contactUser %>">ເລີ່ມການສົນທະນາ</div>
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
                <h3>ເລືອກການສົນທະນາ</h3>
                <p>ເລືອກເພື່ອນຈາກລາຍຊື່ເພື່ອເລີ່ມຕົ້ນສົນທະນາ</p>
            </div>
            <% } else { %>
            <!-- Chat Header -->
            <div class="chat-header">
                <div class="chat-user-info">
                    <img src="https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png" alt="User" class="chat-avatar">
                    <div>
                        <div class="chat-user-name" id="chatUserName"><%= chatWith %></div>
                        <div class="chat-status">ອອນລາຍ</div>
                    </div>
                </div>
                <div class="chat-actions">
                    <button class="btn-icon" title="ໂທ"><i class="fas fa-phone"></i></button>
                    <button class="btn-icon" title="ວິດີໂອ"><i class="fas fa-video"></i></button>
                    <button class="btn-icon" title="ເພີ່ມເຕີມ"><i class="fas fa-info-circle"></i></button>
                </div>
            </div>
            
            <!-- Messages Area -->
            <div class="messages-container" id="messagesContainer">
                <div class="messages" id="messages">
                    <!-- ຂໍ້ຄວາມ -->
                </div>
            </div>
            
            <!-- Input Area -->
            <div class="chat-input-area">
                <button class="btn-icon" title="Attach-file" style="color:black;"><i class="fas fa-paperclip"></i></button>
                <button class="btn-icon" title="email"><i class="far fa-smile" style="color:black;"></i></button>
                <input type="text" class="chat-input" id="messageInput" placeholder="ພິມຂໍ້ຄວາມ..." onkeypress="handleKeyPress(event)">
                <button class="btn-send" id="sendBtn" onclick="sendMessage()">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
            <% } %>
        </div>
    </div>
    
    <input type="hidden" id="currentChatWith" value="<%= chatWith %>">
    <input type="hidden" id="currentUserId" value="<%= userId %>">
    <input type="hidden" id="contextPath" value="<%= request.getContextPath() %>">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../../chat.js"></script>
</body>
</html>
