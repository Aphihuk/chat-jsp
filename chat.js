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
    
    const params = new URLSearchParams({
        fromUser: currentUserId,
        toUser: currentChatWith,
        message: message
    });
    
    fetch(contextPath + '/servlet/SendMessageServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params
    })
    .then(response => response.ok ? response : Promise.reject(response))
    .then(() => {
        messageInput.value = '';
        loadMessages();
    })
    .catch(() => alert('ເກີດຄວາມຜິດພາດໃນລະຫວ່າງການສົ່ງຂໍ້ຄວາມ.'));
}

// Load messages
function loadMessages() {
    if(!currentChatWith) return;
    
    const url = new URL(contextPath + '/servlet/GetMessagesServlet', window.location.origin);
    url.searchParams.append('fromUser', currentUserId);
    url.searchParams.append('toUser', currentChatWith);
    
    fetch(url)
    .then(response => response.json())
    .then(messages => displayMessages(messages))
    .catch(error => console.error('Error loading messages:', error));
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
            avatarHtml = '<img src="https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png" alt="User" class="message-avatar">';
        }
        
        const time = formatTime(msg.timestamp);
        
        messageDiv.innerHTML = avatarHtml + 
            '<div class="message-bubble">' +
                '<div class="message-text">' + escapeHtml(msg.message) + '</div>' +
                '<div class="message-time">' + time + '</div>' +
            '</div>';
        
        if(msg.fromUser === currentUserId) {
            messageDiv.innerHTML += '<img src="https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png" alt="User" class="message-avatar">';
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
    
    if(diff < 60000) {
        return 'ພຽງ​ແຕ່​ບໍ່​ດົນ​ມາ​ນີ້​';
    } else if(diff < 3600000) {
        const minutes = Math.floor(diff / 60000);
        return minutes + ' ນາທີທີເເລ້ວ';
    } else if(diff < 86400000) {
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
    messageInterval = setInterval(loadMessages, 2000);
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
    
    const url = new URL(contextPath + '/servlet/GetLastMessageServlet', window.location.origin);
    url.searchParams.append('userId', currentUserId);
    
    fetch(url)
    .then(response => response.json())
    .then(previews => {
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
    })
    .catch(error => console.error('Error updating previews:', error));
}

// Update previews periodically
setInterval(updateContactPreviews, 5000);
