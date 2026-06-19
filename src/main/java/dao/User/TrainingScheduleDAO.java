package dao.User;

import model.training.TrainingSchedule;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrainingScheduleDAO {

    public TrainingSchedule getOneTrainingScheduleFromTemplate(String goal, String gender, String ageRange) {
        String sql = "SELECT * FROM MasterSchedule WHERE goal=? AND gender=? AND ageRange=?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, goal);
            ps.setString(2, gender);
            ps.setString(3, ageRange);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new TrainingSchedule(
                            rs.getInt("masterScheduleId"),
                            rs.getString("name"),
                            goal, "kHONG", gender, ageRange,
                            rs.getInt("totalWeeks"),
                            "Không"
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int createTrainingSchedule(TrainingSchedule trainingSchedule, int userId) {
        String sql = "INSERT INTO UserSchedule (userId, name, goal, fitnessLevel, gender, ageRange, totalWeeks, masterScheduleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBContext.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.setString(2, trainingSchedule.getName());
            stmt.setString(3, trainingSchedule.getGoal());
            stmt.setString(4, trainingSchedule.getFitnessLevel());
            stmt.setString(5, trainingSchedule.getGender());
            stmt.setString(6, trainingSchedule.getAgeRange());
            stmt.setInt(7, trainingSchedule.getTotalWeeks());
            stmt.setInt(8, trainingSchedule.getMasterScheduleId());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<TrainingSchedule> getAllTrainingSchedule(int userId) {
        List<TrainingSchedule> list = new ArrayList<>();
        String sql = "SELECT * FROM UserSchedule WHERE userId = ? ORDER BY userScheduleId DESC";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new TrainingSchedule(
                            rs.getInt("userScheduleId"),
                            rs.getString("name"),
                            rs.getString("goal"),
                            rs.getString("fitnessLevel"),
                            rs.getString("gender"),
                            rs.getString("ageRange"),
                            rs.getInt("totalWeeks"),
                            rs.getString("status"),
                            rs.getInt("masterScheduleId")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getUserScheduleIdByUserDayId(int userDayId) {
        String sql = "SELECT userScheduleId FROM UserDay WHERE userDayId = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userDayId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("userScheduleId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean updateProgress(int userScheduleId) {
        String sql = "UPDATE Progress SET completedWorkouts = completedWorkouts + 1, lastUpdate = GETDATE() WHERE userScheduleId = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userScheduleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
