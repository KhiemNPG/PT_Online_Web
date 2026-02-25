package dao;

import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProgressScheduleDAO extends DBContext {

    public int createProgressSchedule(int userId, int userScheduleId, java.sql.Date startDate) {
        // Chỉ chèn những thông tin cơ bản nhất, còn lại để DEFAULT 0
        String sql = "INSERT INTO Progress (userId, userScheduleId, startDate, completedWorkouts, skippedWorkouts, totalCaloriesBurned) "
                + "VALUES (?, ?, ?, 0, 0, 0)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, userScheduleId);
            stmt.setDate(3, startDate);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi Progress: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

}
