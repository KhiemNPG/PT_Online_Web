package dao;

import model.training.Exercise;
import model.training.TrainingDay;
import model.training.TrainingWorkoutExercise;
import model.training.Video;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TrainingWorkoutExerciseDAO extends DBContext {

    public List<TrainingWorkoutExercise> getTrainingWorkoutExercise(int masterScheduleId) {
        List<TrainingWorkoutExercise> list = new ArrayList<>();
        String sql = "SELECT mwe.* FROM MasterWorkoutExercise mwe " +
                "JOIN MasterDay md ON mwe.masterDayId = md.masterDayId " +
                "WHERE md.masterScheduleId = ? " +
                "ORDER BY md.dayIndex ASC, mwe.orderInWorkout ASC"; // Sắp xếp cho chuẩn thứ tự tập
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, masterScheduleId);
            ResultSet rs = ps.executeQuery();
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void createTrainingWorkoutExercise(List<TrainingWorkoutExercise> masterExList, List<TrainingDay> checkTrainingDayList) {
        if (masterExList == null || masterExList.isEmpty() || checkTrainingDayList == null) return;

        String sql = "INSERT INTO UserWorkoutExercise (userDayId, exerciseId, orderInWorkout, targetSets, targetReps, targetRestTime, actualWeight, actualReps, isFinished) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn.setAutoCommit(false);
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                // 1. TẠO BẢN ĐỒ ÁNH XẠ (Mấu chốt ở đây)
                // Key: Số thứ tự ngày (dayIndex) - Value: ID thật trong DB
                Map<Integer, Integer> dayMap = new HashMap<>();
                for (TrainingDay td : checkTrainingDayList) {
                    dayMap.put(td.getDayIndex(), td.getMasterDayId()); // MasterDayId ở đây là ID thật vừa tạo
                }

                // 2. LẤY THÔNG TIN DAY_INDEX CHO BÀI TẬP MẪU
                // Vì MasterWorkoutExercise không có dayIndex, ta cần lấy nó từ MasterDay
                // Tôi sẽ dùng một câu truy vấn phụ hoặc Map để tìm dayIndex cho từng bài tập

                int insertedCount = 0;
                for (TrainingWorkoutExercise ex : masterExList) {

                    // Giả sử ex.getTrainingDayId() chính là dayIndex (Ví dụ: 1, 2, 3...)
                    // Nếu ex.getTrainingDayId() là ID của bảng MasterDay, bro cần dùng dayMap
                    // khớp với thứ tự bài tập.

                    // THỬ CÁCH NÀY: Khớp trực tiếp bằng dayPointer nhưng thêm LOG mạnh
                    int dayIndexToFind = ex.getDayIndex(); // Nếu DayID là 1, 2, 3...
                    Integer realUserDayId = dayMap.get(dayIndexToFind);

                    if (realUserDayId != null) {

                        stmt.setInt(1, realUserDayId);
                        //stmt.setInt(1, 1);
                        stmt.setInt(2, ex.getExerciseId());
                        stmt.setInt(3, ex.getOrderInWorkout());
                        stmt.setInt(4, ex.getSets());
                        stmt.setInt(5, ex.getReps());
                        stmt.setInt(6, ex.getRestTime());
                        stmt.setFloat(7, 0);
                        stmt.setInt(8, 0);
                        stmt.setBoolean(9, false);

                        stmt.addBatch();
                        insertedCount++;
                    }
                }

                if (insertedCount > 0) {
                    stmt.executeBatch();
                    conn.commit();
                    System.out.println(">>> THÀNH CÔNG: Đã insert " + insertedCount + " bài tập!");
                } else {
                    System.out.println(">>> CẢNH BÁO: Không tìm thấy realUserDayId nào khớp!");
                }
            }
        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        }
    }

    public List<TrainingWorkoutExercise> getTrainingWorkoutExerciseByUserDayId(int userDayId) {
        // FIX 1: Khởi tạo ArrayList thay vì để null
        List<TrainingWorkoutExercise> trainingWorkoutExerciseList = new ArrayList<>();
        String sql = "SELECT * FROM UserWorkoutExercise WHERE userDayId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userDayId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int userWorkoutExerciseId = rs.getInt("userWorkoutExerciseId");
                    int exerciseId = rs.getInt("exerciseId");
                    int orderInWorkout = rs.getInt("orderInWorkout");
                    int targetSets = rs.getInt("targetSets");
                    int targetReps = rs.getInt("targetReps");
                    int targetRestTime = rs.getInt("targetRestTime");

                    // Các cột này có thể dùng sau này khi Update kết quả tập
                    float actualWeight = rs.getFloat("actualWeight");
                    int actualReps = rs.getInt("actualReps");
                    boolean isFinished = rs.getBoolean("isFinished");

                    // Tạo object (Đảm bảo Constructor khớp với số lượng tham số bro định nghĩa)
                    TrainingWorkoutExercise trainingWorkoutExercise = new TrainingWorkoutExercise(
                            userWorkoutExerciseId,
                            userDayId,
                            exerciseId,
                            targetSets,
                            targetReps,
                            targetRestTime,
                            orderInWorkout
                    );

                    trainingWorkoutExerciseList.add(trainingWorkoutExercise);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trainingWorkoutExerciseList;
    }

    public List<Exercise> getExerciseByExerciseId(List<TrainingWorkoutExercise> trainingWorkoutExerciseList) {
        List<Exercise> exerciseList = new ArrayList<>();
        if (trainingWorkoutExerciseList == null || trainingWorkoutExerciseList.isEmpty()) return exerciseList;

        // Câu SQL JOIN 2 bảng Exercise và Video
        String sql = "SELECT e.*, v.title, v.url, v.thumbnailUrl, v.duration " +
                "FROM Exercise e " +
                "LEFT JOIN Video v ON e.videoId = v.videoId " +
                "WHERE e.exerciseId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (TrainingWorkoutExercise twe : trainingWorkoutExerciseList) {
                ps.setInt(1, twe.getExerciseId());

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        Exercise ex = new Exercise();
                        // Set thông tin bài tập
                        ex.setExerciseId(rs.getInt("exerciseId"));
                        ex.setExerciseName(rs.getNString("exerciseName"));
                        ex.setExerciseType(rs.getNString("exerciseType"));
                        ex.setDifficultyLevel(rs.getNString("difficultyLevel"));
                        ex.setPrimaryMuscle(rs.getNString("primaryMuscle"));
                        ex.setSecondaryMuscles(rs.getNString("secondaryMuscles"));
                        ex.setEquipmentRequired(rs.getNString("equipmentRequired"));
                        ex.setContraindications(rs.getNString("contraindications"));
                        ex.setInjuryRiskLevel(rs.getNString("injuryRiskLevel"));
                        ex.setDefaultSets(rs.getInt("defaultSets"));
                        ex.setDefaultReps(rs.getInt("defaultReps"));
                        ex.setDefaultRestTime(rs.getInt("defaultRestTime"));
                        ex.setCaloriesBurnedPerMinute(rs.getDouble("caloriesBurnedPerMinute"));
                        ex.setDescription(rs.getNString("description"));
                        ex.setInstructions(rs.getNString("instructions"));
                        ex.setCommonMistakes(rs.getNString("commonMistakes"));
                        ex.setTips(rs.getNString("tips"));
                        ex.setActive(rs.getBoolean("isActive"));

                        // KHỞI TẠO OBJECT VIDEO VÀ GÁN VÀO EXERCISE
                        int videoId = rs.getInt("videoId"); // Lấy từ cột e.videoId
                        if (videoId > 0) {
                            Video v = new Video();
                            v.setVideoId(videoId);
                            v.setTitle(rs.getNString("title"));
                            v.setUrl(rs.getString("url"));
                            v.setThumbnailUrl(rs.getString("thumbnailUrl"));
                            v.setDuration(rs.getInt("duration"));

                            ex.setVideo(v); // Gán video vào exercise
                        }

                        exerciseList.add(ex);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exerciseList;
    }

}

