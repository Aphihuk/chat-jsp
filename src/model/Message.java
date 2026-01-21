package model;

import java.sql.Timestamp;

public class Message {
    private int id;
    private String fromUser;
    private String toUser;
    private String message;
    private Timestamp timestamp;
    
    public Message() {}
    
    public Message(String fromUser, String toUser, String message) {
        this.fromUser = fromUser;
        this.toUser = toUser;
        this.message = message;
        this.timestamp = new Timestamp(System.currentTimeMillis());
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getFromUser() {
        return fromUser;
    }
    
    public void setFromUser(String fromUser) {
        this.fromUser = fromUser;
    }
    
    public String getToUser() {
        return toUser;
    }
    
    public void setToUser(String toUser) {
        this.toUser = toUser;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public Timestamp getTimestamp() {
        return timestamp;
    }
    
    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }
}
