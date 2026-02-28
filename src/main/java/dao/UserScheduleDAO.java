package dao;

import model.tracking.UserSchedule;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserScheduleDAO extends DBContext {

    public List<UserSchedule> getUserSchedulesByUserId(int userId) {

        List<UserSchedule> list = new ArrayList<>();

        String sql = "SELECT * FROM UserSchedule WHERE userId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

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

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}