package dao.User;

import model.training.TrainingDay;
import model.training.TrainingWorkoutExercise;
import utils.DBContext;

import java.sql.*;
import java.util.*;

public class TrainingDayDAO {

    public List<TrainingDay> getOneTrainingDayFromTemplate(int masterScheduleId) {
        List<TrainingDay> trainingDayList = new ArrayList<>();
        String sql = "SELECT * from MasterDay WHERE masterScheduleId = ? ORDER BY weekIndex, dayIndex";
        
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, masterScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                Timestamp time = Timestamp.valueOf("2024-05-20 10:30:00");
                while (rs.next()) {
                    trainingDayList.add(new TrainingDay(
                        rs.getInt("masterDayId"), masterScheduleId, rs.getInt("dayIndex"), 
                        rs.getInt("weekIndex"), rs.getString("workoutLabel"), 
                        rs.getString("dayType"), false, time
                    ));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return trainingDayList;
    }

    public List<TrainingDay> createTrainingDay(List<TrainingDay> trainingDayList, String dayOfWeek, int userScheduleId) {
        if (trainingDayList == null || trainingDayList.isEmpty()) return null;

        java.time.DayOfWeek targetDay = switch (dayOfWeek.toUpperCase()) {
            case "T2" -> java.time.DayOfWeek.MONDAY;
            case "T3" -> java.time.DayOfWeek.TUESDAY;
            case "T4" -> java.time.DayOfWeek.WEDNESDAY;
            case "T5" -> java.time.DayOfWeek.THURSDAY;
            case "T6" -> java.time.DayOfWeek.FRIDAY;
            case "T7" -> java.time.DayOfWeek.SATURDAY;
            case "CN" -> java.time.DayOfWeek.SUNDAY;
            default -> java.time.DayOfWeek.MONDAY;
        };

        java.time.LocalDate runningDate = java.time.LocalDate.now().with(java.time.temporal.TemporalAdjusters.nextOrSame(targetDay));
        String sql = "INSERT INTO UserDay (userScheduleId, dayIndex, weekIndex, workoutLabel, dayType, isCompleted, scheduledDate) VALUES (?, ?, ?, ?, ?, 0, ?)";

        Connection con = DBContext.getConnection();
        try {
            con.setAutoCommit(false);
            try (PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                for (TrainingDay td : trainingDayList) {
                    stmt.setInt(1, userScheduleId);
                    stmt.setInt(2, td.getDayIndex());
                    stmt.setInt(3, td.getWeekIndex());
                    stmt.setString(4, td.getWorkoutLabel());
                    stmt.setString(5, td.getDayType());
                    stmt.setDate(6, Date.valueOf(runningDate));
                    stmt.executeUpdate();

                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) td.setMasterDayId(rs.getInt(1));
                    }
                    runningDate = runningDate.plusDays(1);
                }
            }
            con.commit();
            return trainingDayList;
        } catch (SQLException e) {
            try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return null;
        } finally {
            try { con.setAutoCommit(true); con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    public List<TrainingWorkoutExercise> getTrainingWorkoutExercise(int masterScheduleId) {
        List<TrainingWorkoutExercise> list = new ArrayList<>();
        String sql = "SELECT mwe.*, md.dayIndex FROM MasterWorkoutExercise mwe " +
                     "JOIN MasterDay md ON mwe.masterDayId = md.masterDayId " +
                     "WHERE md.masterScheduleId = ? ORDER BY md.dayIndex ASC, mwe.orderInWorkout ASC";
        
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, masterScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new TrainingWorkoutExercise(
                        rs.getInt("masterWorkoutExerciseId"), rs.getInt("masterDayId"),
                        rs.getInt("exerciseId"), rs.getInt("sets"), rs.getInt("reps"),
                        rs.getInt("restTime"), rs.getInt("orderInWorkout"), rs.getInt("dayIndex"), false
                    ));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public void createTrainingWorkoutExercise(List<TrainingWorkoutExercise> masterExList, List<TrainingDay> checkTrainingDayList) {
        if (masterExList == null || masterExList.isEmpty() || checkTrainingDayList == null) return;

        String sql = "INSERT INTO UserWorkoutExercise (userDayId, exerciseId, orderInWorkout, targetSets, targetReps, targetRestTime, actualWeight, actualReps, isFinished) VALUES (?, ?, ?, ?, ?, ?, 0, 0, 0)";
        Map<Integer, Integer> dayMap = new HashMap<>();
        for (TrainingDay td : checkTrainingDayList) dayMap.put(td.getDayIndex(), td.getMasterDayId());

        Connection con = DBContext.getConnection();
        try {
            con.setAutoCommit(false);
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                for (TrainingWorkoutExercise ex : masterExList) {
                    Integer realUserDayId = dayMap.get(ex.getDayIndex());
                    if (realUserDayId != null) {
                        stmt.setInt(1, realUserDayId);
                        stmt.setInt(2, ex.getExerciseId());
                        stmt.setInt(3, ex.getOrderInWorkout());
                        stmt.setInt(4, ex.getSets());
                        stmt.setInt(5, ex.getReps());
                        stmt.setInt(6, ex.getRestTime());
                        stmt.addBatch();
                    }
                }
                stmt.executeBatch();
            }
            con.commit();
        } catch (SQLException e) {
            try { con.rollback(); } catch (SQLException ex) { }
            e.printStackTrace();
        } finally {
            try { con.setAutoCommit(true); con.close(); } catch (SQLException e) { }
        }
    }

    public boolean updateUserDayByUserDayId(int userDayId) {
        String sql = "UPDATE UserDay SET isCompleted = 1, completedDate = GETDATE() WHERE userDayId = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, userDayId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean getStatusByUserDayId(int userDayId) {
        String sql = "SELECT isCompleted FROM UserDay WHERE userDayId = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userDayId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getBoolean("isCompleted");
            }
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}
