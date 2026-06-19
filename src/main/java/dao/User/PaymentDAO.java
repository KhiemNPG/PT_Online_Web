package dao.User;

import model.entity.User;
import model.payment.PaymentTransaction;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public boolean createPaymentOrder(int userId, long orderCode, double amount,
                                      String transactionType, String status, String description,
                                      String senderName, String transferContent) {

        String sqlTransaction = "INSERT INTO PaymentTransaction (user_id, order_code, amount, transaction_type, status, sender_name, transfer_content) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sqlNotification = "INSERT INTO Notification (user_id, title, content, notification_type, is_read) VALUES (?, ?, ?, ?, 0)";

        Connection con = DBContext.getConnection();
        if (con == null) return false;

        PreparedStatement psTrans = null;
        PreparedStatement psNoti = null;

        try {
            con.setAutoCommit(false);
            psTrans = con.prepareStatement(sqlTransaction);
            psTrans.setInt(1, userId);
            psTrans.setLong(2, orderCode);
            psTrans.setDouble(3, amount);
            psTrans.setString(4, transactionType);
            psTrans.setString(5, status);
            psTrans.setString(6, senderName);
            psTrans.setString(7, transferContent);
            int rowsTrans = psTrans.executeUpdate();

            psNoti = con.prepareStatement(sqlNotification);
            String notiTitle = "Yêu cầu mua gói PRO mới";
            String notiContent = "Học viên (ID: " + userId + ") đã khởi tạo đơn hàng #" + orderCode + ". Số tiền: " + String.format("%,.0f", amount) + "đ. Nội dung chuyển: [" + transferContent + "]";
            psNoti.setInt(1, userId);
            psNoti.setString(2, notiTitle);
            psNoti.setString(3, notiContent);
            psNoti.setString(4, transactionType);
            int rowsNoti = psNoti.executeUpdate();

            if (rowsTrans > 0 && rowsNoti > 0) {
                con.commit();
                return true;
            } else {
                con.rollback();
                return false;
            }
        } catch (SQLException e) {
            try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (psTrans != null) psTrans.close();
                if (psNoti != null) psNoti.close();
                con.setAutoCommit(true);
                con.close();
            } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    public double getTotalAmount() {
        double total = 0;
        String sql = "SELECT SUM(amount) FROM PaymentTransaction WHERE status = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "SUCCESS");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) total = rs.getDouble(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return total;
    }

    public double getTotalAmountForToday() {
        double total = 0;
        String sql = "SELECT ISNULL(SUM(amount), 0) AS total FROM PaymentTransaction WHERE CAST(created_at AS DATE) = CAST(GETDATE() AS DATE) and status = 'SUCCESS'";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) total = rs.getDouble("total");
        } catch (Exception e) { e.printStackTrace(); }
        return total;
    }

    public int getTotalPendingTrading() {
        int total = 0;
        String sql = "SELECT Count(*) FROM PaymentTransaction WHERE status = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "PENDING_TRADING");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) total = rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return total;
    }

    public int getTotalPendingApproval() {
        int total = 0;
        String sql = "SELECT Count(*) FROM PaymentTransaction WHERE status = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "PENDING_APPROVAL");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) total = rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return total;
    }

    public int getTotalSuccessTrading() {
        int total = 0;
        String sql = "SELECT Count(*) FROM PaymentTransaction WHERE status = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "SUCCESS");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) total = rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return total;
    }

    public int getTotalTransaction() {
        int total = 0;
        String sql = "SELECT Count(*) FROM PaymentTransaction";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) total = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return total;
    }

    public double getTotalRevenueBuyProAccount() {
        double total = 0;
        String sql = "SELECT Sum(amount) FROM PaymentTransaction where transaction_type = 'BUY_PRO' AND status = 'SUCCESS'";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) total = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return total;
    }

    public int getTotalTransactionByProAccount() {
        int total = 0;
        String sql = "SELECT count(*) FROM PaymentTransaction where transaction_type = 'BUY_PRO'";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) total = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return total;
    }

    public List<PaymentTransaction> allTransactionList(int month, int year) {
        List<PaymentTransaction> transactionList = new ArrayList<>();
        String sql = "SELECT pt.*, u.userId, u.accountId, u.name, u.age, u.gender, u.height, u.weight, u.fitnessLevel, u.remainingTokens FROM PaymentTransaction pt LEFT JOIN [User] u ON pt.user_id = u.userId WHERE MONTH(pt.created_at) = ? AND YEAR(pt.created_at) = ? ORDER BY pt.created_at DESC";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    transactionList.add(mapResultSetToTransaction(rs));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return transactionList;
    }

    public List<PaymentTransaction> allTransactionListById(int id) {
        List<PaymentTransaction> transactionList = new ArrayList<>();
        String sql = "SELECT pt.*, u.userId, u.accountId, u.name, u.age, u.gender, u.height, u.weight, u.fitnessLevel, u.remainingTokens FROM PaymentTransaction pt LEFT JOIN [User] u ON pt.user_id = u.userId WHERE u.userId = ? ORDER BY pt.created_at DESC";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    transactionList.add(mapResultSetToTransaction(rs));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return transactionList;
    }

    public List<PaymentTransaction> allTransactionSuccessListForMonthAdnYear(int month, int year) {
        List<PaymentTransaction> transactionList = new ArrayList<>();
        String sql = "SELECT pt.*, u.userId, u.accountId, u.name, u.age, u.gender, u.height, u.weight, u.fitnessLevel, u.remainingTokens FROM PaymentTransaction pt LEFT JOIN [User] u ON pt.user_id = u.userId WHERE MONTH(pt.created_at) = ? AND YEAR(pt.created_at) = ? AND status = 'SUCCESS' ORDER BY pt.created_at DESC";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    transactionList.add(mapResultSetToTransaction(rs));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return transactionList;
    }

    public List<PaymentTransaction> allTransactionListPending() {
        List<PaymentTransaction> transactionList = new ArrayList<>();
        String sql = "SELECT pt.*, u.userId, u.accountId, u.name, u.age, u.gender, u.height, u.weight, u.fitnessLevel, u.remainingTokens FROM PaymentTransaction pt LEFT JOIN [User] u ON pt.user_id = u.userId WHERE pt.status IN ('PENDING_TRADING', 'PENDING_APPROVAL') ORDER BY pt.created_at DESC";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                transactionList.add(mapResultSetToTransaction(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return transactionList;
    }

    public boolean approveTransaction(int transactionId) {
        Connection con = DBContext.getConnection();
        if (con == null) return false;
        PreparedStatement psUpdate = null, psInsert = null;
        try {
            con.setAutoCommit(false);
            psUpdate = con.prepareStatement("UPDATE PaymentTransaction SET status = 'SUCCESS', approved_at = GETDATE() WHERE transaction_id = ? AND status IN ('PENDING_TRADING', 'PENDING_APPROVAL')");
            psUpdate.setInt(1, transactionId);
            if (psUpdate.executeUpdate() == 0) { con.rollback(); return false; }

            psInsert = con.prepareStatement("INSERT INTO UserSubscription (accountId, planType, startDate, endDate) SELECT u.accountId, CASE pt.transaction_type WHEN 'BUY_PRO' THEN 'PRO' WHEN 'RENT_PT' THEN 'PT' ELSE 'FREE' END, GETDATE(), DATEADD(MONTH, 1, GETDATE()) FROM PaymentTransaction pt INNER JOIN [User] u ON pt.user_id = u.userId WHERE pt.transaction_id = ?");
            psInsert.setInt(1, transactionId);
            if (psInsert.executeUpdate() == 0) { con.rollback(); return false; }

            con.commit();
            return true;
        } catch (SQLException e) {
            try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            return false;
        } finally {
            try {
                if (psUpdate != null) psUpdate.close();
                if (psInsert != null) psInsert.close();
                con.setAutoCommit(true);
                con.close();
            } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    public boolean rejectTransaction(int transactionId) {
        String sql = "UPDATE PaymentTransaction SET status = 'FAILED' WHERE transaction_id = ? AND status IN ('PENDING_TRADING', 'PENDING_APPROVAL')";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, transactionId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // Hàm phụ trợ để tránh lặp code mapping
    private PaymentTransaction mapResultSetToTransaction(ResultSet rs) throws SQLException {
        User user = new User(
            rs.getInt("userId"), rs.getInt("accountId"), rs.getString("name"),
            (rs.getObject("age") != null ? rs.getInt("age") : 0),
            (rs.getObject("gender") != null ? rs.getString("gender") : ""),
            (rs.getObject("height") != null ? rs.getDouble("height") : 0.0),
            (rs.getObject("weight") != null ? rs.getDouble("weight") : 0.0),
            (rs.getObject("fitnessLevel") != null ? rs.getString("fitnessLevel") : "BEGINNER"),
            (rs.getObject("remainingTokens") != null ? rs.getInt("remainingTokens") : 0)
        );
        return new PaymentTransaction(
            rs.getInt("transaction_id"), user, rs.getLong("order_code"),
            rs.getBigDecimal("amount"), rs.getString("transaction_type"),
            rs.getString("status"), rs.getTimestamp("created_at"),
            (rs.getObject("approved_at") != null ? rs.getTimestamp("approved_at") : new Timestamp(0)),
            (rs.getObject("sender_name") != null ? rs.getString("sender_name") : ""),
            (rs.getObject("transfer_content") != null ? rs.getString("transfer_content") : "")
        );
    }
}
