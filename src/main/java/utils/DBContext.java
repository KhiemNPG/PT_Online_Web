package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    // 1. Chuỗi kết nối đã bổ sung tối ưu cho SQL Server trên Cloud
    private static final String DB_URL = "jdbc:sqlserver://SmartPTData.mssql.somee.com:1433;databaseName=SmartPTData;encrypt=true;trustServerCertificate=true;";
    private static final String DB_USER = "Khiem2704_SQLLogin_1";
    private static final String DB_PASSWORD = "mj4lwo566m";

    // 2. Chỉ giữ lại hàm này, xóa bỏ constructor cũ đi
    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException | SQLException ex) {
            // In lỗi chi tiết ra log để bro debug
            System.err.println("DB ERROR: " + ex.getMessage());
            return null; 
        }
    }
}
