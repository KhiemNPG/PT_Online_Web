package dao.User;

import model.entity.User;
import model.payment.PaymentTransaction;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO extends DBContext {

    public boolean createPaymentOrder(int userId, long orderCode, double amount,
                                      String transactionType, String status, String description,
                                      String senderName, String transferContent) { // Đã thêm 2 tham số

        String sqlTransaction = "INSERT INTO PaymentTransaction (user_id, order_code, amount, transaction_type, status, sender_name, transfer_content) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)"; // Đã thêm 2 dấu ?
        String sqlNotification = "INSERT INTO Notification (user_id, title, content, notification_type, is_read) VALUES (?, ?, ?, ?, 0)";

        PreparedStatement psTrans = null;
        PreparedStatement psNoti = null;

        try {
            if (conn == null || conn.isClosed()) {
                return false;
            }

            conn.setAutoCommit(false);

            // 1. Insert Transaction
            psTrans = conn.prepareStatement(sqlTransaction);
            psTrans.setInt(1, userId);
            psTrans.setLong(2, orderCode);
            psTrans.setDouble(3, amount);
            psTrans.setString(4, transactionType);
            psTrans.setString(5, status);
            psTrans.setString(6, senderName);      // SET cột sender_name
            psTrans.setString(7, transferContent); // SET cột transfer_content

            int rowsTrans = psTrans.executeUpdate();

            // 2. Insert Notification
            psNoti = conn.prepareStatement(sqlNotification);
            String notiTitle = "Yêu cầu mua gói PRO mới";
            String notiContent = "Học viên (ID: " + userId + ") đã khởi tạo đơn hàng #" + orderCode + ". Số tiền: " + String.format("%,.0f", amount) + "đ. "
                    + "Nội dung chuyển: [" + transferContent + "]";

            psNoti.setInt(1, userId);
            psNoti.setString(2, notiTitle);
            psNoti.setString(3, notiContent);
            psNoti.setString(4, transactionType);
            int rowsNoti = psNoti.executeUpdate();

            // Chốt giao dịch
            if (rowsTrans > 0 && rowsNoti > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (psTrans != null) psTrans.close();
                if (psNoti != null) psNoti.close();
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public double getTotalAmount() {
        double total = 0;
        String sql = "SELECT SUM(amount) FROM PaymentTransaction WHERE status = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "SUCCESS"); // Chỉ cộng tiền các giao dịch thành công

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getDouble(1); // Lấy giá trị tổng
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public double getTotalAmountForToday() {
        double total = 0;
        String sql = "SELECT ISNULL(SUM(amount), 0) AS total " +
                "FROM PaymentTransaction " +
                "WHERE CAST(created_at AS DATE) = CAST(GETDATE() AS DATE) and status = 'SUCCESS'";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getDouble("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public int getTotalPendingTrading() {
        int total = 0;
        // Sử dụng hàm SQL để lọc theo ngày (cú pháp có thể thay đổi tùy hệ quản trị CSDL)
        // Ví dụ này sử dụng cú pháp chuẩn cho MySQL:
        String sql = "SELECT Count(*) FROM PaymentTransaction " +
                "WHERE status = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "PENDING_TRADING");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public int getTotalPendingApproval() {
        int total = 0;
        // Sử dụng hàm SQL để lọc theo ngày (cú pháp có thể thay đổi tùy hệ quản trị CSDL)
        // Ví dụ này sử dụng cú pháp chuẩn cho MySQL:
        String sql = "SELECT Count(*) FROM PaymentTransaction " +
                "WHERE status = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "PENDING_APPROVAL");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public int getTotalSuccessTrading() {
        int total = 0;
        // Sử dụng hàm SQL để lọc theo ngày (cú pháp có thể thay đổi tùy hệ quản trị CSDL)
        // Ví dụ này sử dụng cú pháp chuẩn cho MySQL:
        String sql = "SELECT Count(*) FROM PaymentTransaction " +
                "WHERE status = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "SUCCESS");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public int getTotalTransaction() {
        int total = 0;
        // Sử dụng hàm SQL để lọc theo ngày (cú pháp có thể thay đổi tùy hệ quản trị CSDL)
        // Ví dụ này sử dụng cú pháp chuẩn cho MySQL:
        String sql = "SELECT Count(*) FROM PaymentTransaction";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public double getTotalRevenueBuyProAccount() {
        double total = 0;
        String sql = "SELECT Sum(amount) FROM PaymentTransaction where transaction_type = 'BUY_PRO' AND status = 'SUCCESS'";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public int getTotalTransactionByProAccount() {
        int total = 0;
        String sql = "SELECT count(*) FROM PaymentTransaction where transaction_type = 'BUY_PRO'";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<PaymentTransaction> allTransactionList(int month, int year) {
        List<PaymentTransaction> transactionList = new ArrayList<>();

        // Bỏ alias, dùng trực tiếp tên cột gốc
        String sql = "SELECT pt.*, " +
                "u.userId, u.accountId, u.name, u.age, u.gender, " +
                "u.height, u.weight, u.fitnessLevel, u.remainingTokens " +
                "FROM PaymentTransaction pt " +
                "LEFT JOIN [User] u ON pt.user_id = u.userId " +
                "WHERE MONTH(pt.created_at) = ? AND YEAR(pt.created_at) = ? " +
                "ORDER BY pt.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);  // ? thứ 1 = MONTH
            ps.setInt(2, year);   // ? thứ 2 = YEAR
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    // 2. Lấy dữ liệu có thể NULL cho User - dùng tên cột gốc và gán giá trị mặc định
                    Integer ageVal = (rs.getObject("age") != null) ? rs.getInt("age") : 0;
                    String genderVal = (rs.getObject("gender") != null) ? rs.getString("gender") : "";
                    Double heightVal = (rs.getObject("height") != null) ? rs.getDouble("height") : 0.0;
                    Double weightVal = (rs.getObject("weight") != null) ? rs.getDouble("weight") : 0.0;
                    String fitnessLevelVal = (rs.getObject("fitnessLevel") != null) ? rs.getString("fitnessLevel") : "BEGINNER";
                    int remainingTokensVal = (rs.getObject("remainingTokens") != null) ? rs.getInt("remainingTokens") : 0;

                    // 3. Tạo object User - dùng tên cột gốc
                    User user = new User(
                            rs.getInt("userId"),
                            rs.getInt("accountId"),
                            rs.getString("name"),
                            ageVal,
                            genderVal,
                            heightVal,
                            weightVal,
                            fitnessLevelVal,
                            remainingTokensVal
                    );

                    // 1. Lấy dữ liệu có thể NULL cho PaymentTransaction - gán giá trị mặc định
                    Timestamp approvedAtVal = (rs.getObject("approved_at") != null)
                            ? rs.getTimestamp("approved_at")
                            : new Timestamp(0); // Hoặc null nếu muốn giữ null
                    String senderNameVal = (rs.getObject("sender_name") != null)
                            ? rs.getString("sender_name")
                            : ""; // Chuỗi rỗng
                    String transferContentVal = (rs.getObject("transfer_content") != null)
                            ? rs.getString("transfer_content")
                            : ""; // Chuỗi rỗng

                    // 4. Tạo object PaymentTransaction
                    PaymentTransaction transaction = new PaymentTransaction(
                            rs.getInt("transaction_id"),
                            user,
                            rs.getLong("order_code"),
                            rs.getBigDecimal("amount"),
                            rs.getString("transaction_type"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"),
                            approvedAtVal,
                            senderNameVal,
                            transferContentVal
                    );

                    transactionList.add(transaction);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return transactionList;
    }

    public List<PaymentTransaction> allTransactionListById(int id) {
        List<PaymentTransaction> transactionList = new ArrayList<>();

        // Bỏ alias, dùng trực tiếp tên cột gốc
        String sql = "SELECT pt.*, " +
                "u.userId, u.accountId, u.name, u.age, u.gender, " +
                "u.height, u.weight, u.fitnessLevel, u.remainingTokens " +
                "FROM PaymentTransaction pt " +
                "LEFT JOIN [User] u ON pt.user_id = u.userId " +
                "WHERE u.userId = ? " +
                "ORDER BY pt.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);  // ? thứ 1 = MONTH
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    // 2. Lấy dữ liệu có thể NULL cho User - dùng tên cột gốc và gán giá trị mặc định
                    Integer ageVal = (rs.getObject("age") != null) ? rs.getInt("age") : 0;
                    String genderVal = (rs.getObject("gender") != null) ? rs.getString("gender") : "";
                    Double heightVal = (rs.getObject("height") != null) ? rs.getDouble("height") : 0.0;
                    Double weightVal = (rs.getObject("weight") != null) ? rs.getDouble("weight") : 0.0;
                    String fitnessLevelVal = (rs.getObject("fitnessLevel") != null) ? rs.getString("fitnessLevel") : "BEGINNER";
                    int remainingTokensVal = (rs.getObject("remainingTokens") != null) ? rs.getInt("remainingTokens") : 0;

                    // 3. Tạo object User - dùng tên cột gốc
                    User user = new User(
                            rs.getInt("userId"),
                            rs.getInt("accountId"),
                            rs.getString("name"),
                            ageVal,
                            genderVal,
                            heightVal,
                            weightVal,
                            fitnessLevelVal,
                            remainingTokensVal
                    );

                    // 1. Lấy dữ liệu có thể NULL cho PaymentTransaction - gán giá trị mặc định
                    Timestamp approvedAtVal = (rs.getObject("approved_at") != null)
                            ? rs.getTimestamp("approved_at")
                            : new Timestamp(0); // Hoặc null nếu muốn giữ null
                    String senderNameVal = (rs.getObject("sender_name") != null)
                            ? rs.getString("sender_name")
                            : ""; // Chuỗi rỗng
                    String transferContentVal = (rs.getObject("transfer_content") != null)
                            ? rs.getString("transfer_content")
                            : ""; // Chuỗi rỗng

                    // 4. Tạo object PaymentTransaction
                    PaymentTransaction transaction = new PaymentTransaction(
                            rs.getInt("transaction_id"),
                            user,
                            rs.getLong("order_code"),
                            rs.getBigDecimal("amount"),
                            rs.getString("transaction_type"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"),
                            approvedAtVal,
                            senderNameVal,
                            transferContentVal
                    );

                    transactionList.add(transaction);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return transactionList;
    }

    public List<PaymentTransaction> allTransactionSuccessListForMonthAdnYear(int month, int year) {
        List<PaymentTransaction> transactionList = new ArrayList<>();

        // Bỏ alias, dùng trực tiếp tên cột gốc
        String sql = "SELECT pt.*, " +
                "u.userId, u.accountId, u.name, u.age, u.gender, " +
                "u.height, u.weight, u.fitnessLevel, u.remainingTokens " +
                "FROM PaymentTransaction pt " +
                "LEFT JOIN [User] u ON pt.user_id = u.userId " +
                "WHERE MONTH(pt.created_at) = ? AND YEAR(pt.created_at) = ? AND status = 'SUCCESS'" +
                "ORDER BY pt.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);  // ? thứ 1 = MONTH
            ps.setInt(2, year);   // ? thứ 2 = YEAR
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    // 2. Lấy dữ liệu có thể NULL cho User - dùng tên cột gốc và gán giá trị mặc định
                    Integer ageVal = (rs.getObject("age") != null) ? rs.getInt("age") : 0;
                    String genderVal = (rs.getObject("gender") != null) ? rs.getString("gender") : "";
                    Double heightVal = (rs.getObject("height") != null) ? rs.getDouble("height") : 0.0;
                    Double weightVal = (rs.getObject("weight") != null) ? rs.getDouble("weight") : 0.0;
                    String fitnessLevelVal = (rs.getObject("fitnessLevel") != null) ? rs.getString("fitnessLevel") : "BEGINNER";
                    int remainingTokensVal = (rs.getObject("remainingTokens") != null) ? rs.getInt("remainingTokens") : 0;

                    // 3. Tạo object User - dùng tên cột gốc
                    User user = new User(
                            rs.getInt("userId"),
                            rs.getInt("accountId"),
                            rs.getString("name"),
                            ageVal,
                            genderVal,
                            heightVal,
                            weightVal,
                            fitnessLevelVal,
                            remainingTokensVal
                    );

                    // 1. Lấy dữ liệu có thể NULL cho PaymentTransaction - gán giá trị mặc định
                    Timestamp approvedAtVal = (rs.getObject("approved_at") != null)
                            ? rs.getTimestamp("approved_at")
                            : new Timestamp(0); // Hoặc null nếu muốn giữ null
                    String senderNameVal = (rs.getObject("sender_name") != null)
                            ? rs.getString("sender_name")
                            : ""; // Chuỗi rỗng
                    String transferContentVal = (rs.getObject("transfer_content") != null)
                            ? rs.getString("transfer_content")
                            : ""; // Chuỗi rỗng

                    // 4. Tạo object PaymentTransaction
                    PaymentTransaction transaction = new PaymentTransaction(
                            rs.getInt("transaction_id"),
                            user,
                            rs.getLong("order_code"),
                            rs.getBigDecimal("amount"),
                            rs.getString("transaction_type"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"),
                            approvedAtVal,
                            senderNameVal,
                            transferContentVal
                    );

                    transactionList.add(transaction);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return transactionList;
    }

    public List<PaymentTransaction> allTransactionListPending() {
        List<PaymentTransaction> transactionList = new ArrayList<>();

        // Bỏ alias, dùng trực tiếp tên cột gốc
        String sql = "SELECT pt.*, " +
                "u.userId, u.accountId, u.name, u.age, u.gender, " +
                "u.height, u.weight, u.fitnessLevel, u.remainingTokens " +
                "FROM PaymentTransaction pt " +
                "LEFT JOIN [User] u ON pt.user_id = u.userId " +
                "WHERE pt.status IN ('PENDING_TRADING', 'PENDING_APPROVAL') " +
                "ORDER BY pt.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    // 2. Lấy dữ liệu có thể NULL cho User - dùng tên cột gốc và gán giá trị mặc định
                    Integer ageVal = (rs.getObject("age") != null) ? rs.getInt("age") : 0;
                    String genderVal = (rs.getObject("gender") != null) ? rs.getString("gender") : "";
                    Double heightVal = (rs.getObject("height") != null) ? rs.getDouble("height") : 0.0;
                    Double weightVal = (rs.getObject("weight") != null) ? rs.getDouble("weight") : 0.0;
                    String fitnessLevelVal = (rs.getObject("fitnessLevel") != null) ? rs.getString("fitnessLevel") : "BEGINNER";
                    int remainingTokensVal = (rs.getObject("remainingTokens") != null) ? rs.getInt("remainingTokens") : 0;

                    // 3. Tạo object User - dùng tên cột gốc
                    User user = new User(
                            rs.getInt("userId"),
                            rs.getInt("accountId"),
                            rs.getString("name"),
                            ageVal,
                            genderVal,
                            heightVal,
                            weightVal,
                            fitnessLevelVal,
                            remainingTokensVal
                    );

                    // 1. Lấy dữ liệu có thể NULL cho PaymentTransaction - gán giá trị mặc định
                    Timestamp approvedAtVal = (rs.getObject("approved_at") != null)
                            ? rs.getTimestamp("approved_at")
                            : new Timestamp(0); // Hoặc null nếu muốn giữ null
                    String senderNameVal = (rs.getObject("sender_name") != null)
                            ? rs.getString("sender_name")
                            : ""; // Chuỗi rỗng
                    String transferContentVal = (rs.getObject("transfer_content") != null)
                            ? rs.getString("transfer_content")
                            : ""; // Chuỗi rỗng

                    // 4. Tạo object PaymentTransaction
                    PaymentTransaction transaction = new PaymentTransaction(
                            rs.getInt("transaction_id"),
                            user,
                            rs.getLong("order_code"),
                            rs.getBigDecimal("amount"),
                            rs.getString("transaction_type"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"),
                            approvedAtVal,
                            senderNameVal,
                            transferContentVal
                    );

                    transactionList.add(transaction);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return transactionList;
    }

    public boolean approveTransaction(int transactionId) {
        Connection localConn = null;
        PreparedStatement psUpdate = null;
        PreparedStatement psInsert = null;

        try {
            // Bắt đầu transaction
            localConn = conn;
            localConn.setAutoCommit(false);

            // Bước 1: Update PaymentTransaction (bỏ approved_by)
            String sqlUpdate = "UPDATE PaymentTransaction " +
                    "SET status = 'SUCCESS', " +
                    "    approved_at = GETDATE() " +
                    "WHERE transaction_id = ? AND status IN ('PENDING_TRADING', 'PENDING_APPROVAL')";

            psUpdate = localConn.prepareStatement(sqlUpdate);
            psUpdate.setInt(1, transactionId);
            int updatedRows = psUpdate.executeUpdate();

            if (updatedRows == 0) {
                localConn.rollback();
                return false;
            }

            // Bước 2: Insert UserSubscription
            String sqlInsert = "INSERT INTO UserSubscription (accountId, planType, startDate, endDate) " +
                    "SELECT u.accountId, " +
                    "       CASE pt.transaction_type " +
                    "           WHEN 'BUY_PRO' THEN 'PRO' " +
                    "           WHEN 'RENT_PT' THEN 'PT' " +
                    "           ELSE 'FREE' " +
                    "       END, " +
                    "       GETDATE(), " +
                    "       DATEADD(MONTH, 1, GETDATE()) " +
                    "FROM PaymentTransaction pt " +
                    "INNER JOIN [User] u ON pt.user_id = u.userId " +
                    "WHERE pt.transaction_id = ?";

            psInsert = localConn.prepareStatement(sqlInsert);
            psInsert.setInt(1, transactionId);
            int insertedRows = psInsert.executeUpdate();

            if (insertedRows == 0) {
                localConn.rollback();
                return false;
            }

            // Commit transaction
            localConn.commit();
            return true;

        } catch (SQLException e) {
            // Rollback nếu có lỗi
            try {
                if (localConn != null) localConn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            // Đóng resources và reset autoCommit
            try {
                if (psUpdate != null) psUpdate.close();
                if (psInsert != null) psInsert.close();
                if (localConn != null) localConn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean rejectTransaction(int transactionId) {
        String sql = "UPDATE PaymentTransaction " +
                "SET status = 'FAILED' " +
                "WHERE transaction_id = ? AND status IN ('PENDING_TRADING', 'PENDING_APPROVAL')";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, transactionId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}