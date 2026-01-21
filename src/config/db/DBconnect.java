package config.db;

import java.sql.Connection;

public class DBconnect {
    private static String url = "jdbc:mysql://localhost:3306/chatgtdb?useSSL=false&serverTimezone=UTC";
    private static String username = "root";
    private static String password = "aphihuk";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = java.sql.DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
            return  null;
        }
        return conn;
    }
}
