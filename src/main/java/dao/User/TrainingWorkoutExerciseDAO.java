package dao.User;

import model.training.Exercise;
import model.training.TrainingDay;
import model.training.TrainingWorkoutExercise;
import model.training.Video;
import utils.DBContext;

import java.sql.*;
import java.util.*;

public class TrainingWorkoutExerciseDAO {

    public List<TrainingWorkoutExercise> getTrainingWorkoutExercise(int masterScheduleId) {
        List<TrainingWorkoutExercise> list = new ArrayList<>();
        String sql = "SELECT mwe.*, md.dayIndex FROM MasterWorkoutExercise mwe " +
                     "JOIN MasterDay md ON mwe.masterDayId = md.masterDayId " +
                     "WHERE md.masterScheduleId = ? " +
                     "ORDER BY md.dayIndex ASC, mwe.orderInWorkout ASC";

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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void createTrainingWorkoutExercise(List<TrainingWorkoutExercise> masterExList, List<TrainingDay> checkTrainingDayList) {
        if (masterExList == null || masterExList.isEmpty() || checkTrainingDayList == null) return;

        String sql = "INSERT INTO UserWorkoutExercise (userDayId, exerciseId, orderInWorkout, targetSets, targetReps, targetRestTime, actualWeight, actualReps, isFinished) VALUES (?, ?, ?, ?, ?, ?, 0, 0, 0)";
        
        Map<Integer, Integer> dayMap = new HashMap<>();
        for (TrainingDay td : checkTrainingDayList) {
            dayMap.put(td.getDayIndex(), td.getMasterDayId());
        }

        try (Connection con = DBContext.getConnection()) {
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
                con.commit();
            } catch (SQLException e) {
                con.rollback();
                throw e;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<TrainingWorkoutExercise> getTrainingWorkoutExerciseByUserDayId(int userDayId) {
        List<TrainingWorkoutExercise> list = new ArrayList<>();
        String sql = "SELECT * FROM UserWorkoutExercise WHERE userDayId = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userDayId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new TrainingWorkoutExercise(
                        rs.getInt("userWorkoutExerciseId"), userDayId, rs.getInt("exerciseId"),
                        rs.getInt("targetSets"), rs.getInt("targetReps"), rs.getInt("targetRestTime"),
                        rs.getInt("orderInWorkout")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Exercise> getExerciseByExerciseId(List<TrainingWorkoutExercise> trainingWorkoutExerciseList, String userContraindication) {
        List<Exercise> exerciseList = new ArrayList<>();
        if (trainingWorkoutExerciseList == null || trainingWorkoutExerciseList.isEmpty()) return exerciseList;

        String sql = "SELECT e.*, v.title, v.url, v.thumbnailUrl, v.duration FROM Exercise e " +
                     "LEFT JOIN Video v ON e.videoId = v.videoId WHERE e.exerciseId = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            for (TrainingWorkoutExercise twe : trainingWorkoutExerciseList) {
                ps.setInt(1, twe.getExerciseId());
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String dbContra = rs.getNString("contraindications");
                        if (isForbidden(userContraindication, dbContra)) continue;

                        Exercise ex = mapResultSetToExercise(rs);
                        exerciseList.add(ex);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exerciseList;
    }

    private boolean isForbidden(String userContra, String dbContra) {
        if (userContra == null || userContra.equalsIgnoreCase("Không") || userContra.equalsIgnoreCase("None") || dbContra == null) return false;
        return Arrays.asList(dbContra.split("-")).contains(userContra);
    }

    private Exercise mapResultSetToExercise(ResultSet rs) throws SQLException {
        Exercise ex = new Exercise();
        
        // Thông tin cơ bản
        ex.setExerciseId(rs.getInt("exerciseId"));
        ex.setExerciseName(rs.getNString("exerciseName"));
        ex.setExerciseType(rs.getNString("exerciseType"));
        ex.setDifficultyLevel(rs.getNString("difficultyLevel"));
        
        // Cơ bắp
        ex.setPrimaryMuscle(rs.getNString("primaryMuscle"));
        ex.setSecondaryMuscles(rs.getNString("secondaryMuscles"));
        
        // Thông tin tập luyện
        ex.setEquipmentRequired(rs.getNString("equipmentRequired"));
        ex.setContraindications(rs.getNString("contraindications"));
        ex.setInjuryRiskLevel(rs.getNString("injuryRiskLevel"));
        
        // Thông số mặc định
        ex.setDefaultSets(rs.getInt("defaultSets"));
        ex.setDefaultReps(rs.getInt("defaultReps"));
        ex.setDefaultRestTime(rs.getInt("defaultRestTime"));
        ex.setCaloriesBurnedPerMinute(rs.getDouble("caloriesBurnedPerMinute"));
        
        // Mô tả và hướng dẫn
        ex.setDescription(rs.getNString("description"));
        ex.setInstructions(rs.getNString("instructions"));
        ex.setCommonMistakes(rs.getNString("commonMistakes"));
        ex.setTips(rs.getNString("tips"));
        
        // Trạng thái
        ex.setActive(rs.getBoolean("isActive"));

        // Xử lý Video (liên kết từ LEFT JOIN)
        int videoId = rs.getInt("videoId");
        if (!rs.wasNull() && videoId > 0) {
            Video v = new Video(
                videoId, 
                rs.getString("title"), 
                rs.getString("url"), 
                rs.getInt("duration"),
                rs.getString("thumbnailUrl")
            );
            ex.setVideo(v);
        }
        
        return ex;
    }
}
