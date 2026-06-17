package utils;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    private static final String DB_URL = "workstation id=SmartPTData.mssql.somee.com;packet size=4096;user id=Khiem2704_SQLLogin_1;pwd=mj4lwo566m;data source=SmartPTData.mssql.somee.com;persist security info=False;initial catalog=SmartPTData;TrustServerCertificate=True";
    private static final String DB_USER = "Khiem2704_SQLLogin_1";

    private static final String DB_PASSWORD = "mj4lwo566m";

    protected Connection conn = null;

    public DBContext() {
        try {
            conn = getConnection();
            if (conn != null) {
                DatabaseMetaData dm = conn.getMetaData();
                System.out.println("--- Ket noi DB thanh cong ---");
                System.out.println("Driver name: " + dm.getDriverName());
                System.out.println("Database: " + dm.getDatabaseProductName());
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Lỗi khởi tạo DBContext", ex);
        }
    }

    public Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
