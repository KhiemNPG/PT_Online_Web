package dao.User;

import model.tracking.UserSchedule;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserScheduleDAO {

    public List<UserSchedule> getUserSchedulesByUserId(int userId) {
        List<UserSchedule> list = new ArrayList<>();
        String sql = "SELECT * FROM UserSchedule WHERE userId = ? ORDER BY startDate DESC";

        // Sử dụng try-with-resources để lấy Connection và PreparedStatement
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserSchedule us = new UserSchedule(
                            rs.getInt("userScheduleId"),
                            rs.getInt("userId"),
                            rs.getInt("masterScheduleId"),
                            rs.getString("name"),
                            rs.getString("goal"),
                            rs.getString("fitnessLevel"),
                            rs.getString("gender"),
                            rs.getString("ageRange"),
                            rs.getInt("totalWeeks"),
                            rs.getDate("startDate"),
                            rs.getString("status")
                    );
                    list.add(us);
                }
            }
        } catch (SQLException e) {
            // Nên dùng logger trong dự án thực tế
            e.printStackTrace();
        }

        return list;
    }
}
