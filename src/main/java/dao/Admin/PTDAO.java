package dao.Admin;

import model.entity.PersonalTrainer;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PTDAO {

    public List<PersonalTrainer> getAllPT() {
        List<PersonalTrainer> list = new ArrayList<>();
        String sql = "SELECT * FROM PersonalTrainer";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new PersonalTrainer(
                        rs.getInt("ptId"),
                        rs.getInt("accountId"),
                        rs.getString("ptName"),
                        rs.getString("avatarUrl"),
                        rs.getString("title"),
                        rs.getString("slogan"),
                        rs.getInt("experienceYears"),
                        rs.getInt("successfulStudents"),
                        rs.getString("tags"),
                        rs.getString("bio"),
                        rs.getString("phoneZalo"),
                        rs.getString("email"),
                        rs.getString("facebookUrl"),
                        rs.getString("instagramUrl"),
                        rs.getBoolean("isActive")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addPersonalTrainer(PersonalTrainer pt) {
        String sql = "INSERT INTO PersonalTrainer (ptName, accountId, title, slogan, experienceYears, successfulStudents, " +
                     "avatarUrl, bio, phoneZalo, email, facebookUrl, instagramUrl, isActive, tags) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Cấu trúc set parameter với kiểm tra null/empty chặt chẽ
            ps.setString(1, pt.getName());
            if (pt.getAccountId() > 0) ps.setInt(2, pt.getAccountId()); else ps.setNull(2, Types.INTEGER);
            ps.setString(3, (pt.getTitleLabel() != null) ? pt.getTitleLabel() : "MASTER TRAINER");
            ps.setString(4, pt.getSlogan());
            
            if (pt.getExperienceYears() != null) ps.setInt(5, pt.getExperienceYears()); else ps.setNull(5, Types.INTEGER);
            if (pt.getSuccessfulStudents() != null) ps.setInt(6, pt.getSuccessfulStudents()); else ps.setNull(6, Types.INTEGER);
            
            ps.setString(7, pt.getAvatarUrl());
            ps.setString(8, pt.getBioSummary());
            ps.setString(9, pt.getPhone());
            ps.setString(10, pt.getEmail());
            ps.setString(11, pt.getFacebookUrl());
            ps.setString(12, pt.getInstagramUrl());
            ps.setBoolean(13, pt.isActive());
            ps.setString(14, pt.getTags());

            int rowsInserted = ps.executeUpdate();

            // Cập nhật role trong bảng Account nếu có accountId
            if (rowsInserted > 0 && pt.getAccountId() > 0) {
                updateAccountRole(con, pt.getAccountId(), "PT");
            }

            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void updateAccountRole(Connection con, int accountId, String role) throws SQLException {
        String sqlUpdateRole = "UPDATE Account SET role = ? WHERE accountId = ?";
        try (PreparedStatement psUpdate = con.prepareStatement(sqlUpdateRole)) {
            psUpdate.setString(1, role);
            psUpdate.setInt(2, accountId);
            psUpdate.executeUpdate();
        }
    }
}
