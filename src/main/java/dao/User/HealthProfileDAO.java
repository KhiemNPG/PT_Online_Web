package dao.User;

import model.entity.HealthProfile;
import utils.DBContext;

import java.sql.*;

public class HealthProfileDAO {

    public HealthProfile findByRequirementId(int requirementId) throws Exception {
        String sql = "SELECT healthProfileId, userId, requirementId, ageRange, gender, jointIssues, updatedAt " +
                     "FROM HealthProfile WHERE requirementId = ?";
        
        Connection con = DBContext.getConnection();
        if (con == null) return null;
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
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
        } finally {
            if (con != null) con.close();
        }
    }

    public void insertNew(HealthProfile hp) throws Exception {
        String sql = "INSERT INTO HealthProfile (userId, requirementId, ageRange, gender, jointIssues, updatedAt) VALUES (?, ?, ?, ?, ?, GETDATE())";
        
        Connection con = DBContext.getConnection();
        if (con == null) throw new SQLException("Không thể kết nối Database");
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, hp.getUserId());
            ps.setInt(2, hp.getRequirementId());
            ps.setString(3, hp.getAgeRange());
            ps.setString(4, hp.getGender());
            ps.setString(5, hp.getJointIssues());
            ps.executeUpdate();
        } finally {
            if (con != null) con.close();
        }
    }

    public HealthProfile getHealthProfileByUserId(int userId) {
        HealthProfile healthProfile = null;
        String sql = "SELECT * FROM HealthProfile WHERE userId = ? ORDER BY healthProfileId DESC";
        
        Connection con = DBContext.getConnection();
        if (con == null) return null;

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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
            System.err.println("Lỗi khi lấy HealthProfile: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return healthProfile;
    }

    public boolean updateJointIssues(String jointIssues, int userId) {
        String sql = "UPDATE HealthProfile SET jointIssues = ? WHERE userId = ?";
        
        Connection con = DBContext.getConnection();
        if (con == null) return false;

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, jointIssues);
            stmt.setInt(2, userId);
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                System.out.println("Cập nhật chấn thương " + jointIssues + " thành công cho User ID: " + userId);
            }
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
