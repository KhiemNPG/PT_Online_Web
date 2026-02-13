package dao;

import model.entity.Account;
import utils.DBContext;

import java.sql.*;

public class AccountDAO extends DBContext {

    public Account findByUsername(String username) throws Exception {
        String sql = "SELECT accountId, username, passwordHash, role, isActive, createdAt " +
                "FROM Account WHERE username = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setAccountId(rs.getInt("accountId"));
                a.setUsername(rs.getString("username"));
                a.setPasswordHash(rs.getString("passwordHash"));
                a.setRole(rs.getString("role"));
                a.setActive(rs.getBoolean("isActive"));
                a.setCreatedAt(rs.getTimestamp("createdAt"));
                return a;
            }
            return null;
        }
    }

    public Account findById(int id) throws Exception {
        String sql = "SELECT accountId, username, passwordHash, role, isActive, createdAt " +
                "FROM Account WHERE accountId = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setAccountId(rs.getInt("accountId"));
                a.setUsername(rs.getString("username"));
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
        String sql = "INSERT INTO Account(username, passwordHash, role, isActive) VALUES(?,?,?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, a.getUsername());
            ps.setString(2, a.getPasswordHash());
            ps.setString(3, a.getRole());
            ps.setBoolean(4, a.isActive());

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
}
