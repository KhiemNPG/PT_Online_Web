package dao;

import model.entity.TrainingRequirement;
import utils.DBContext;

import java.sql.*;

public class TrainingRequirementDAO extends DBContext {

    public TrainingRequirement findActiveByUserId(int userId) throws Exception {
        String sql =
                "SELECT TOP 1 requirementId, userId, goal, availableTime, preferredDays, isCompleted, createdAt " +
                        "FROM TrainingRequirement " +
                        "WHERE userId = ? AND isCompleted = 0 " +
                        "ORDER BY createdAt DESC, requirementId DESC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                TrainingRequirement tr = new TrainingRequirement();
                tr.setRequirementId(rs.getInt("requirementId"));
                tr.setUserId(rs.getInt("userId"));
                tr.setGoal(rs.getString("goal"));
                tr.setAvailableTime(rs.getString("availableTime"));
                tr.setPreferredDays(rs.getString("preferredDays"));
                tr.setCompleted(rs.getBoolean("isCompleted"));
                tr.setCreatedAt(rs.getTimestamp("createdAt"));
                return tr;
            }
        }
    }

    public TrainingRequirement findLatestByUserId(int userId) throws Exception {
        String sql =
                "SELECT TOP 1 requirementId, userId, goal, availableTime, preferredDays, isCompleted, createdAt " +
                        "FROM TrainingRequirement " +
                        "WHERE userId = ? " +
                        "ORDER BY createdAt DESC, requirementId DESC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                TrainingRequirement tr = new TrainingRequirement();
                tr.setRequirementId(rs.getInt("requirementId"));
                tr.setUserId(rs.getInt("userId"));
                tr.setGoal(rs.getString("goal"));
                tr.setAvailableTime(rs.getString("availableTime"));
                tr.setPreferredDays(rs.getString("preferredDays"));
                tr.setCompleted(rs.getBoolean("isCompleted"));
                tr.setCreatedAt(rs.getTimestamp("createdAt"));
                return tr;
            }
        }
    }

    public int insertNew(TrainingRequirement tr) throws Exception {
        String sql =
                "INSERT INTO TrainingRequirement(userId, goal, availableTime, preferredDays, isCompleted) " +
                        "VALUES(?, ?, ?, ?, 0)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, tr.getUserId());
            ps.setString(2, tr.getGoal());
            ps.setString(3, tr.getAvailableTime());
            ps.setString(4, tr.getPreferredDays());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
            return 0;
        }
    }

    public void markCompleted(int requirementId) throws Exception {
        String sql = "UPDATE TrainingRequirement SET isCompleted = 1 WHERE requirementId = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, requirementId);
            ps.executeUpdate();
        }
    }
}
