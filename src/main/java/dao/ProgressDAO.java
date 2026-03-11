package dao;

import model.tracking.Progress;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProgressDAO extends DBContext {

    public Progress getProgressByUserIdAndUserScheduleId(int userId, int userScheduleId){
        Progress progress = null;

        String sql = "select * from Progress where userId = ? and userScheduleId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) { // Dùng try-with-resources để tự đóng ps
            ps.setInt(1, userId);
            ps.setInt(2, userScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { // Dùng if vì chỉ có 1 dòng dữ liệu
                    int progressId = rs.getInt("progressId");
                    int completedWorkouts = rs.getInt("completedWorkouts");
                    int skippedWorkouts = rs.getInt("skippedWorkouts");
                    double totalCaloriesBurned = rs.getDouble("totalCaloriesBurned");
                    String status = rs.getString("status");
                    java.sql.Timestamp lastUpdate = rs.getTimestamp("lastUpdate");

                    progress = new Progress(
                            progressId,
                            userId,
                            userScheduleId,
                            completedWorkouts,
                            skippedWorkouts,
                            totalCaloriesBurned,
                            status,
                            lastUpdate
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
}
