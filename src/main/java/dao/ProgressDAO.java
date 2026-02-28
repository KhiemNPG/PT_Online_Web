package dao;

import model.tracking.Progress;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProgressDAO extends DBContext {

    public Progress getProgressByUserIdAndUserScheduleId(int userId, int userScheduleId) {

        Progress progress = null;

        String sql = "SELECT * FROM Progress WHERE userId = ? AND userScheduleId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, userScheduleId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Double finalWeight = null;
                    if (rs.getObject("final_weight") != null) {
                        finalWeight = rs.getDouble("final_weight");
                    }

                    progress = new Progress(
                            rs.getInt("progressId"),
                            userId,
                            userScheduleId,
                            rs.getInt("completedWorkouts"),
                            rs.getInt("skippedWorkouts"),
                            rs.getDouble("totalCaloriesBurned"),
                            rs.getString("status"),
                            rs.getTimestamp("lastUpdate"),
                            finalWeight
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return progress;
    }

    public List<Progress> getProgressByUserId(int userId) {

        List<Progress> list = new ArrayList<>();

        String sql = "SELECT * FROM Progress WHERE userId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Double finalWeight = null;
                    if (rs.getObject("final_weight") != null) {
                        finalWeight = rs.getDouble("final_weight");
                    }

                    list.add(new Progress(
                            rs.getInt("progressId"),
                            rs.getInt("userId"),
                            rs.getInt("userScheduleId"),
                            rs.getInt("completedWorkouts"),
                            rs.getInt("skippedWorkouts"),
                            rs.getDouble("totalCaloriesBurned"),
                            rs.getString("status"),
                            rs.getTimestamp("lastUpdate"),
                            finalWeight
                    ));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void updateFinalWeight(int userId, int userScheduleId, double weight) {

        String sql = "UPDATE Progress "
                + "SET final_weight = ? "
                + "WHERE userId = ? AND userScheduleId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, weight);
            ps.setInt(2, userId);
            ps.setInt(3, userScheduleId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}