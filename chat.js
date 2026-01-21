
let currentChatWith = document.getElementById('currentChatWith').value;
let currentUserId = document.getElementById('currentUserId').value;
let contextPath = document.getElementById('contextPath') ? document.getElementById('contextPath').value : '';
let messageInterval;

// Load chat when page loads
if(currentChatWith) {
    loadMessages();
    startMessagePolling();
}

// Load chat with a user
function loadChat(username) {
    window.location.href = 'chat.jsp?chatWith=' + encodeURIComponent(username);
}

// Send message
function sendMessage() {
    const messageInput = document.getElementById('messageInput');
    const message = messageInput.value.trim();
    
    if(!message || !currentChatWith) {
        return;
    }
    
    const xhr = new XMLHttpRequest();
    xhr.open('POST', contextPath + '/servlet/SendMessageServlet', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    
    xhr.onreadystatechange = function() {
        if(xhr.readyState === 4) {
            if(xhr.status === 200) {
                messageInput.value = '';
                loadMessages();
            } else {
                alert('เกิดข้อผิดพลาดในการส่งข้อความ');
            }
        }
    };
    
    const params = 'fromUser=' + encodeURIComponent(currentUserId) + 
                   '&toUser=' + encodeURIComponent(currentChatWith) + 
                   '&message=' + encodeURIComponent(message);
    xhr.send(params);
}

// Load messages
function loadMessages() {
    if(!currentChatWith) return;
    
    const xhr = new XMLHttpRequest();
    xhr.open('GET', contextPath + '/servlet/GetMessagesServlet?fromUser=' + encodeURIComponent(currentUserId) + 
             '&toUser=' + encodeURIComponent(currentChatWith), true);
    
    xhr.onreadystatechange = function() {
        if(xhr.readyState === 4 && xhr.status === 200) {
            const messages = JSON.parse(xhr.responseText);
            displayMessages(messages);
        }
    };
    
    xhr.send();
}

// Display messages
function displayMessages(messages) {
    const messagesContainer = document.getElementById('messages');
    messagesContainer.innerHTML = '';
    
    messages.forEach(function(msg) {
        const messageDiv = document.createElement('div');
        messageDiv.className = 'message ' + (msg.fromUser === currentUserId ? 'my-message' : 'other-message');
        
        let avatarHtml = '';
        if(msg.fromUser !== currentUserId) {
            avatarHtml = '<img src="../../assets/images/logo.jpg" alt="User" class="message-avatar">';
        }
        
        const time = formatTime(msg.timestamp);
        
        messageDiv.innerHTML = avatarHtml + 
            '<div class="message-bubble">' +
                '<div class="message-text">' + escapeHtml(msg.message) + '</div>' +
                '<div class="message-time">' + time + '</div>' +
            '</div>';
        
        if(msg.fromUser === currentUserId) {
            messageDiv.innerHTML += '<img src="../../assets/images/logo.jpg" alt="User" class="message-avatar">';
        }
        
        messagesContainer.appendChild(messageDiv);
    });
    
    // Scroll to bottom
    const container = document.getElementById('messagesContainer');
    container.scrollTop = container.scrollHeight;
}

// Format time
function formatTime(timestamp) {
    const date = new Date(timestamp);
    const now = new Date();
    const diff = now - date;
    
    if(diff < 60000) { // Less than 1 minute
        return 'เมื่อสักครู่';
    } else if(diff < 3600000) { // Less than 1 hour
        const minutes = Math.floor(diff / 60000);
        return minutes + ' นาทีที่แล้ว';
    } else if(diff < 86400000) { // Less than 1 day
        return date.toLocaleTimeString('th-TH', { hour: '2-digit', minute: '2-digit' });
    } else {
        return date.toLocaleDateString('th-TH', { month: 'short', day: 'numeric' }) + 
               ' ' + date.toLocaleTimeString('th-TH', { hour: '2-digit', minute: '2-digit' });
    }
}

// Escape HTML
function escapeHtml(text) {
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };
    return text.replace(/[&<>"']/g, function(m) { return map[m]; });
}

// Handle Enter key press
function handleKeyPress(event) {
    if(event.key === 'Enter' && !event.shiftKey) {
        event.preventDefault();
        sendMessage();
    }
}

// Start polling for new messages
function startMessagePolling() {
    if(messageInterval) {
        clearInterval(messageInterval);
    }
    messageInterval = setInterval(loadMessages, 2000); // Poll every 2 seconds
}

// Stop polling
function stopMessagePolling() {
    if(messageInterval) {
        clearInterval(messageInterval);
    }
}

// Search contacts
document.getElementById('searchContact')?.addEventListener('input', function(e) {
    const searchTerm = e.target.value.toLowerCase();
    const contactItems = document.querySelectorAll('.contact-item');
    
    contactItems.forEach(function(item) {
        const name = item.querySelector('.contact-name').textContent.toLowerCase();
        if(name.includes(searchTerm)) {
            item.style.display = 'flex';
        } else {
            item.style.display = 'none';
        }
    });
});

// Update contact previews
function updateContactPreviews() {
    if(!currentChatWith) return;
    
    const xhr = new XMLHttpRequest();
    xhr.open('GET', contextPath + '/servlet/GetLastMessageServlet?userId=' + encodeURIComponent(currentUserId), true);
    
    xhr.onreadystatechange = function() {
        if(xhr.readyState === 4 && xhr.status === 200) {
            const previews = JSON.parse(xhr.responseText);
            previews.forEach(function(preview) {
                const previewEl = document.getElementById('preview_' + preview.username);
                const timeEl = document.getElementById('time_' + preview.username);
                if(previewEl) {
                    previewEl.textContent = preview.message || 'เริ่มสนทนา';
                }
                if(timeEl && preview.timestamp) {
                    timeEl.textContent = formatTime(preview.timestamp);
                }
            });
        }
    };
    
    xhr.send();
}

// Update previews periodically
setInterval(updateContactPreviews, 5000);
