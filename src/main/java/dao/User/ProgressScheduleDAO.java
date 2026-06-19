package dao.User;

import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ProgressScheduleDAO {

    public int createProgressSchedule(int userId, int userScheduleId, java.sql.Date startDate) {
        String sql = "INSERT INTO Progress (userId, userScheduleId, startDate, completedWorkouts, skippedWorkouts, totalCaloriesBurned) "
                   + "VALUES (?, ?, ?, 0, 0, 0)";

        Connection con = DBContext.getConnection();
        if (con == null) return -1;

        try (PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, userScheduleId);
            stmt.setDate(3, startDate);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi Progress: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return -1;
    }
}
