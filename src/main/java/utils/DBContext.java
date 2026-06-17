package utils;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    private static final String DB_URL = "jdbc:sqlserver://SmartPTData.mssql.somee.com:1433;databaseName=Smart_PT;encrypt=true;trustServerCertificate=true;";
    private static final String DB_USER = "Khiem2704_SQLLogin_1";
    private static final String DB_PASSWORD = "mj4lwo566m";

    protected Connection conn = null;

    public DBContext() {
        conn = getConnection();
        if (conn != null) {
            try {
                DatabaseMetaData dm = conn.getMetaData();
                System.out.println("--- Ket noi DB thanh cong ---");
                System.out.println("Driver name: " + dm.getDriverName());
                System.out.println("Database: " + dm.getDatabaseProductName());
            } catch (SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Lỗi kết nối DB", ex);
            return null; // Trả về null khi có lỗi
        }
    }
}