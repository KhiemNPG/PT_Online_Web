package dao.User;

import model.training.TrainingDay;
import model.training.TrainingWorkoutExercise;
import utils.DBContext;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TrainingDayDAO {

    public List<TrainingDay> getOneTrainingDayFromTemplate(int masterScheduleId) {
        List<TrainingDay> list = new ArrayList<>();
        String sql = "SELECT * FROM MasterDay WHERE masterScheduleId = ? ORDER BY weekIndex, dayIndex";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, masterScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                Timestamp time = Timestamp.valueOf("2024-05-20 10:30:00");
                while (rs.next()) {
                    list.add(new TrainingDay(
                        rs.getInt("masterDayId"),
                        masterScheduleId,
                        rs.getInt("dayIndex"),
                        rs.getInt("weekIndex"),
                        rs.getString("workoutLabel"),
                        rs.getString("dayType"),
                        false,
                        time
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<TrainingDay> createTrainingDay(List<TrainingDay> list, String dayOfWeek, int userScheduleId) {
        java.time.DayOfWeek targetDay = switch (dayOfWeek.toUpperCase()) {
            case "T3" -> java.time.DayOfWeek.TUESDAY;
            case "T4" -> java.time.DayOfWeek.WEDNESDAY;
            case "T5" -> java.time.DayOfWeek.THURSDAY;
            case "T6" -> java.time.DayOfWeek.FRIDAY;
            case "T7" -> java.time.DayOfWeek.SATURDAY;
            case "CN" -> java.time.DayOfWeek.SUNDAY;
            default -> java.time.DayOfWeek.MONDAY;
        };
        LocalDate runningDate = LocalDate.now().with(java.time.temporal.TemporalAdjusters.nextOrSame(targetDay));
        String sql = "INSERT INTO UserDay (userScheduleId, dayIndex, weekIndex, workoutLabel, dayType, isCompleted, scheduledDate) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                for (TrainingDay td : list) {
                    stmt.setInt(1, userScheduleId);
                    stmt.setInt(2, td.getDayIndex());
                    stmt.setInt(3, td.getWeekIndex());
                    stmt.setString(4, td.getWorkoutLabel());
                    stmt.setString(5, td.getDayType());
                    stmt.setBoolean(6, false);
                    stmt.setDate(7, Date.valueOf(runningDate));
                    stmt.executeUpdate();
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) td.setMasterDayId(rs.getInt(1));
                    }
                    runningDate = runningDate.plusDays(1);
                }
                conn.commit();
                return list;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<TrainingDay> getOneTrainingDayFromUser(int userScheduleId) {
        List<TrainingDay> list = new ArrayList<>();
        String sql = "SELECT * FROM UserDay WHERE userScheduleId = ? ORDER BY weekIndex, dayIndex";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new TrainingDay(
                        rs.getInt("userDayId"),
                        userScheduleId,
                        rs.getInt("dayIndex"),
                        rs.getInt("weekIndex"),
                        rs.getString("workoutLabel"),
                        rs.getString("dayType"),
                        rs.getBoolean("isCompleted"),
                        rs.getTimestamp("scheduledDate")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<TrainingWorkoutExercise> getTrainingWorkoutExercise(int masterScheduleId) {
        List<TrainingWorkoutExercise> list = new ArrayList<>();
        String sql = "SELECT mwe.* FROM MasterWorkoutExercise mwe JOIN MasterDay md ON mwe.masterDayId = md.masterDayId WHERE md.masterScheduleId = ? ORDER BY md.dayIndex ASC, mwe.orderInWorkout ASC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, masterScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new TrainingWorkoutExercise(
                        rs.getInt("masterWorkoutExerciseId"),
                        rs.getInt("masterDayId"),
                        rs.getInt("exerciseId"),
                        rs.getInt("sets"),
                        rs.getInt("reps"),
                        rs.getInt("restTime"),
                        rs.getInt("orderInWorkout"),
                        rs.getInt("dayIndex"),
                        false
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void createTrainingWorkoutExercise(List<TrainingWorkoutExercise> exList, List<TrainingDay> dayList) {
        if (exList == null || dayList == null) return;
        String sql = "INSERT INTO UserWorkoutExercise (userDayId, exerciseId, orderInWorkout, targetSets, targetReps, targetRestTime, actualWeight, actualReps, isFinished) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                Map<Integer, Integer> dayMap = new HashMap<>();
                for (TrainingDay td : dayList) dayMap.put(td.getDayIndex(), td.getMasterDayId());
                for (TrainingWorkoutExercise ex : exList) {
                    Integer userDayId = dayMap.get(ex.getDayIndex());
                    if (userDayId != null) {
                        stmt.setInt(1, userDayId);
                        stmt.setInt(2, ex.getExerciseId());
                        stmt.setInt(3, ex.getOrderInWorkout());
                        stmt.setInt(4, ex.getSets());
                        stmt.setInt(5, ex.getReps());
                        stmt.setInt(6, ex.getRestTime());
                        stmt.setFloat(7, 0);
                        stmt.setInt(8, 0);
                        stmt.setBoolean(9, false);
                        stmt.addBatch();
                    }
                }
                stmt.executeBatch();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean updateUserDayByUserDayId(int userDayId) {
        String sql = "UPDATE UserDay SET isCompleted = 1, completedDate = GETDATE() WHERE userDayId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userDayId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean getStatusByUserDayId(int userDayId) {
        String sql = "SELECT isCompleted FROM UserDay WHERE userDayId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userDayId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getBoolean("isCompleted");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
