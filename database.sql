
CREATE DATABASE IF NOT EXISTS chatgtdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE chatgtdb;

-- Table: users
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: messages
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    from_user VARCHAR(50) NOT NULL,
    to_user VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_from_user (from_user),
    INDEX idx_to_user (to_user),
    INDEX idx_timestamp (timestamp),
    INDEX idx_conversation (from_user, to_user, timestamp),
    FOREIGN KEY (from_user) REFERENCES users(username) ON DELETE CASCADE,
    FOREIGN KEY (to_user) REFERENCES users(username) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO users (firstname, lastname, username, password, email, phone) VALUES
('ສົນ', 'ໃຈດີ', 'somchai', 'password123', 'somchai@example.com', '0812345678'),
('ເປັນຍີງ', 'ຮັກດີ', 'somying', 'password123', 'somying@example.com', '0823456789'),
('ລອງ', 'ດີ', 'test', 'password123', 'test@example.com', '0834567890')
ON DUPLICATE KEY UPDATE username=username;
