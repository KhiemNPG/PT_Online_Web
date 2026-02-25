package dao;

import model.entity.HealthProfile;
import model.entity.TrainingRequirement;
import utils.DBContext;

import java.sql.*;

public class HealthProfileDAO extends DBContext {

    public HealthProfile findByRequirementId(int requirementId) throws Exception {

        String sql =
                "SELECT healthProfileId, userId, requirementId, " +
                        "ageRange, gender, jointIssues, updatedAt " +
                        "FROM HealthProfile " +
                        "WHERE requirementId = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, requirementId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                HealthProfile hp = new HealthProfile();
                hp.setHealthProfileId(rs.getInt("healthProfileId"));
                hp.setUserId(rs.getInt("userId"));
                hp.setRequirementId(rs.getInt("requirementId"));
                hp.setAgeRange(rs.getString("ageRange"));
                hp.setGender(rs.getString("gender"));
                hp.setJointIssues(rs.getString("jointIssues"));
                hp.setUpdatedAt(rs.getTimestamp("updatedAt"));

                return hp;
            }
        }
    }


    public void insertNew(HealthProfile hp) throws Exception {

        String sql =
                "INSERT INTO HealthProfile " +
                        "(userId, requirementId, ageRange, gender, jointIssues, updatedAt) " +
                        "VALUES (?, ?, ?, ?, ?, GETDATE())";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, hp.getUserId());
            ps.setInt(2, hp.getRequirementId());
            ps.setString(3, hp.getAgeRange());
            ps.setString(4, hp.getGender());
            ps.setString(5, hp.getJointIssues());

            ps.executeUpdate();
        }
    }

    public HealthProfile getHealthProfileByUserId(int userId) {
        HealthProfile healthProfile = null; // Khởi đầu là null
        String sql = "SELECT * FROM HealthProfile WHERE userId = ?";

        // Tự động đóng ps và rs sau khi kết thúc khối try
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { // Dùng IF vì 1 user chỉ có 1 Profile
                    healthProfile = new HealthProfile(
                            rs.getInt("healthProfileId"),
                            rs.getInt("userId"),
                            rs.getInt("requirementId"),
                            rs.getString("ageRange"),
                            rs.getString("gender"),
                            rs.getString("jointIssues"),
                            rs.getTimestamp("updatedAt")
                    );
                }
            }
        } catch (SQLException e) {
            // Ghi log lỗi để dễ debug
            System.err.println("Lỗi khi lấy HealthProfile: " + e.getMessage());
            e.printStackTrace();
        }
        return healthProfile;
    }

}
