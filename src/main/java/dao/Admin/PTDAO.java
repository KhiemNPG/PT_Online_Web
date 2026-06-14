package dao.Admin;

import model.entity.Account;
import model.entity.PersonalTrainer;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class PTDAO extends DBContext {

    public List<PersonalTrainer> getAllPT(){
        List<PersonalTrainer> personalTrainerList = new ArrayList<>();
        String sql = "SELECT * FROM PersonalTrainer";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PersonalTrainer p = new PersonalTrainer(
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

                    );
                    personalTrainerList.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return personalTrainerList;
    }

    public boolean addPersonalTrainer(PersonalTrainer pt) {
        // Không insert ptId vì là IDENTITY (tự động tăng)
        String sql = "INSERT INTO PersonalTrainer (" +
                "ptName, accountId, title, slogan, experienceYears, successfulStudents, " +
                "avatarUrl, bio, phoneZalo, email, facebookUrl, instagramUrl, isActive, tags" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            // 1. ptName (NOT NULL) - từ pt.getName()
            ps.setString(1, pt.getName());

            // 2. accountId (NULL) - nếu = 0 thì set null
            if (pt.getAccountId() > 0) {
                ps.setInt(2, pt.getAccountId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }

            // 3. title - từ pt.getTitleLabel(), default 'MASTER TRAINER'
            String title = pt.getTitleLabel();
            ps.setString(3, (title != null && !title.trim().isEmpty()) ? title : "MASTER TRAINER");

            // 4. slogan (NULL)
            if (pt.getSlogan() != null && !pt.getSlogan().trim().isEmpty()) {
                ps.setString(4, pt.getSlogan());
            } else {
                ps.setNull(4, Types.NVARCHAR);
            }

            // 5. experienceYears (NULL)
            if (pt.getExperienceYears() != null) {
                ps.setInt(5, pt.getExperienceYears());
            } else {
                ps.setNull(5, Types.INTEGER);
            }

            // 6. successfulStudents (NULL)
            if (pt.getSuccessfulStudents() != null) {
                ps.setInt(6, pt.getSuccessfulStudents());
            } else {
                ps.setNull(6, Types.INTEGER);
            }

            // 7. avatarUrl (NULL)
            if (pt.getAvatarUrl() != null && !pt.getAvatarUrl().trim().isEmpty()) {
                ps.setString(7, pt.getAvatarUrl());
            } else {
                ps.setNull(7, Types.VARCHAR);
            }

            // 8. bio - từ pt.getBioSummary() (NULL)
            if (pt.getBioSummary() != null && !pt.getBioSummary().trim().isEmpty()) {
                ps.setString(8, pt.getBioSummary());
            } else {
                ps.setNull(8, Types.NVARCHAR);
            }

            // 9. phoneZalo - từ pt.getPhone() (NOT NULL)
            ps.setString(9, pt.getPhone());

            // 10. email (NOT NULL)
            ps.setString(10, pt.getEmail());

            // 11. facebookUrl (NULL)
            if (pt.getFacebookUrl() != null && !pt.getFacebookUrl().trim().isEmpty()) {
                ps.setString(11, pt.getFacebookUrl());
            } else {
                ps.setNull(11, Types.VARCHAR);
            }

            // 12. instagramUrl (NULL)
            if (pt.getInstagramUrl() != null && !pt.getInstagramUrl().trim().isEmpty()) {
                ps.setString(12, pt.getInstagramUrl());
            } else {
                ps.setNull(12, Types.VARCHAR);
            }

            // 13. isActive (BIT) - từ pt.isActive()
            ps.setBoolean(13, pt.isActive());

            // 14. tags (NULL)
            if (pt.getTags() != null && !pt.getTags().trim().isEmpty()) {
                ps.setString(14, pt.getTags());
            } else {
                ps.setNull(14, Types.NVARCHAR);
            }

            // Thực thi INSERT
            int rowsInserted = ps.executeUpdate();

            // Nếu INSERT thành công và có accountId, UPDATE Account.role = 'PT'
            if (rowsInserted > 0 && pt.getAccountId() > 0) {
                String sqlUpdateRole = "UPDATE Account SET role = 'PT' WHERE accountId = ?";
                try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdateRole)) {
                    psUpdate.setInt(1, pt.getAccountId());
                    psUpdate.executeUpdate();
                }
            }

            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
