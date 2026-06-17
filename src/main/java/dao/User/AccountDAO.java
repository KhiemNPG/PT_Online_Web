package dao.User;

import model.entity.Account;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO extends DBContext {

    public Account findByUsername(String username) throws Exception {
    String sql = "SELECT accountId, username, email, passwordHash, role, isActive, createdAt FROM Account WHERE username = ?";
    
    // 1. Lấy kết nối
    Connection con = getConnection();
    
    // 2. KIỂM TRA NULL NGAY TẠI ĐÂY
    if (con == null) {
        System.err.println("Kết nối database bị null, không thể truy vấn!");
        return null; // Trả về null để Controller biết và xử lý
    }
    
    // 3. Nếu con không null thì mới dùng try-with-resources
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, username);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Account a = new Account();
                a.setAccountId(rs.getInt("accountId"));
                a.setUsername(rs.getString("username"));
                a.setPasswordHash(rs.getString("passwordHash"));
                a.setRole(rs.getString("role"));
                a.setActive(rs.getBoolean("isActive"));
                a.setCreatedAt(rs.getTimestamp("createdAt"));
                a.setEmail(rs.getString("email"));
                return a;
            }
        }
    } finally {
        // Đừng quên đóng kết nối nếu bro không dùng pool connection
        if (con != null) con.close();
    }
    return null;
}

    public Account findById(int id) throws Exception {

        String sql = "SELECT accountId, username, email, passwordHash, role, isActive, createdAt FROM Account WHERE accountId = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setAccountId(rs.getInt("accountId"));
                a.setUsername(rs.getString("username"));
                a.setEmail(rs.getString("email"));
                a.setPasswordHash(rs.getString("passwordHash"));
                a.setRole(rs.getString("role"));
                a.setActive(rs.getBoolean("isActive"));
                a.setCreatedAt(rs.getTimestamp("createdAt"));
                return a;
            }
            return null;
        }
    }

    public int insert(Account a) throws Exception {
        String sql = "INSERT INTO Account(username, email, passwordHash, role, isActive) VALUES(?,?,?,?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, a.getUsername());
            ps.setString(2, a.getEmail());
            ps.setString(3, a.getPasswordHash());
            ps.setString(4, a.getRole());
            ps.setBoolean(5, a.isActive());

            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            return keys.next() ? keys.getInt(1) : -1;
        }
    }

    public boolean updatePasswordHash(int accountId, String passwordHash) throws Exception {
        String sql = "UPDATE Account SET passwordHash=? WHERE accountId=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, passwordHash);
            ps.setInt(2, accountId);
            return ps.executeUpdate() == 1;
        }
    }
    public Account findByEmail(String email) throws Exception {
    String sql = "SELECT accountId, username, email, passwordHash, role, isActive, createdAt FROM Account WHERE email = ?";
    
    // 1. Lấy kết nối rời ra ngoài
    Connection con = getConnection();
    
    // 2. KIỂM TRA NULL NGAY TẠI ĐÂY
    if (con == null) {
        System.err.println("DB ERROR: Kết nối database bị null tại findByEmail!");
        return null; // Trả về null để app không bị sập
    }
    
    // 3. Nếu con khác null thì mới thực hiện truy vấn
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, email);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Account a = new Account();
                a.setAccountId(rs.getInt("accountId"));
                a.setUsername(rs.getString("username"));
                a.setEmail(rs.getString("email"));
                a.setPasswordHash(rs.getString("passwordHash"));
                a.setRole(rs.getString("role"));
                a.setActive(rs.getBoolean("isActive"));
                a.setCreatedAt(rs.getTimestamp("createdAt"));
                return a;
            }
        }
    } finally {
        // Luôn đóng kết nối sau khi dùng xong
        if (con != null) {
            con.close();
        }
    }
    return null;
}
    public boolean setActive(int accountId, boolean active) {

        String sql = "UPDATE Account SET isActive=? WHERE accountId=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, active);
            ps.setInt(2, accountId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Integer> getAllAccountPro() {
        List<Integer> allAccountProList = new ArrayList<>();

        String sql = "SELECT DISTINCT accountId FROM UserSubscription " +
                "WHERE planType = ? " +           // ← Check lại tên cột
                "AND endDate > GETDATE()";       // ← Chưa hết hạn

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "PRO");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("accountId");
                    allAccountProList.add(id);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allAccountProList;
    }
}
