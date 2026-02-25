package dao;

import model.entity.User;
import model.training.TrainingSchedule;
import utils.DBContext;

import java.sql.*;

public class UserDAO extends DBContext {

    private User map(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("userId"));
        u.setAccountId(rs.getInt("accountId"));
        u.setName(rs.getString("name"));

        int age = rs.getInt("age");
        u.setAge(rs.wasNull() ? null : age);

        u.setGender(rs.getString("gender"));

        double h = rs.getDouble("height");
        u.setHeight(rs.wasNull() ? null : h);

        double w = rs.getDouble("weight");
        u.setWeight(rs.wasNull() ? null : w);

        u.setFitnessLevel(rs.getString("fitnessLevel"));
        return u;
    }

    public User findByAccountId(int accountId) throws Exception {
        String sql = "SELECT userId, accountId, name, age, gender, height, weight, fitnessLevel " +
                "FROM dbo.[User] WHERE accountId = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
                return null;
            }
        }
    }

    public int getUserIdByAccountId(int accountId){
        int userId = 0;
        String sql = "select userId from [User] where accountId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getInt("userId");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userId;
    }

    public int insert(User u) throws Exception {
        String sql = "INSERT INTO dbo.[User] (accountId, name, age, gender, height, weight, fitnessLevel) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, u.getAccountId());
            ps.setString(2, u.getName());

            if (u.getAge() == null) ps.setNull(3, Types.INTEGER);
            else ps.setInt(3, u.getAge());

            ps.setString(4, u.getGender());

            if (u.getHeight() == null) ps.setNull(5, Types.FLOAT);
            else ps.setDouble(5, u.getHeight());

            if (u.getWeight() == null) ps.setNull(6, Types.FLOAT);
            else ps.setDouble(6, u.getWeight());

            ps.setString(7, u.getFitnessLevel());

            int affected = ps.executeUpdate();
            if (affected <= 0) return 0;

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
                return 0;
            }
        }
    }

    public boolean updateByAccountId(User u) throws Exception {
        String sql = "UPDATE dbo.[User] " +
                "SET name=?, age=?, gender=?, height=?, weight=?, fitnessLevel=? " +
                "WHERE accountId=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getName());

            if (u.getAge() == null) ps.setNull(2, Types.INTEGER);
            else ps.setInt(2, u.getAge());

            ps.setString(3, u.getGender());

            if (u.getHeight() == null) ps.setNull(4, Types.FLOAT);
            else ps.setDouble(4, u.getHeight());

            if (u.getWeight() == null) ps.setNull(5, Types.FLOAT);
            else ps.setDouble(5, u.getWeight());

            ps.setString(6, u.getFitnessLevel());
            ps.setInt(7, u.getAccountId());

            return ps.executeUpdate() > 0;
        }
    }

    public void upsertByAccountId(User u) throws Exception {
        User existing = findByAccountId(u.getAccountId());
        if (existing == null) {
            insert(u);
        } else {
            updateByAccountId(u);
        }
    }
}
