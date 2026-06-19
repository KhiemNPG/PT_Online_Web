package dao.User;

import model.training.Exercise;
import model.training.Video;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ExerciseDAO {

    public Exercise getExerciseByExerciseId(int exerciseId) {
        // Dùng JOIN để lấy luôn thông tin Video đi kèm
        String sql = "SELECT e.*, v.title, v.url, v.thumbnailUrl, v.duration " +
                "FROM Exercise e " +
                "LEFT JOIN Video v ON e.videoId = v.videoId " +
                "WHERE e.exerciseId = ?";

        Connection con = DBContext.getConnection();
        if (con == null) return null;

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, exerciseId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Exercise ex = new Exercise();

                    // Map các trường cơ bản
                    ex.setExerciseId(rs.getInt("exerciseId"));
                    ex.setExerciseName(rs.getString("exerciseName"));
                    ex.setExerciseType(rs.getString("exerciseType"));
                    ex.setDifficultyLevel(rs.getString("difficultyLevel"));
                    ex.setPrimaryMuscle(rs.getString("primaryMuscle"));
                    ex.setSecondaryMuscles(rs.getString("secondaryMuscles"));
                    ex.setEquipmentRequired(rs.getString("equipmentRequired"));
                    ex.setContraindications(rs.getString("contraindications"));
                    ex.setInjuryRiskLevel(rs.getString("injuryRiskLevel"));
                    ex.setDefaultSets(rs.getInt("defaultSets"));
                    ex.setDefaultReps(rs.getInt("defaultReps"));
                    ex.setDefaultRestTime(rs.getInt("defaultRestTime"));
                    ex.setCaloriesBurnedPerMinute(rs.getDouble("caloriesBurnedPerMinute"));
                    ex.setDescription(rs.getString("description"));
                    ex.setInstructions(rs.getString("instructions"));
                    ex.setCommonMistakes(rs.getString("commonMistakes"));
                    ex.setTips(rs.getString("tips"));
                    ex.setActive(rs.getBoolean("isActive"));

                    // Map đối tượng Video đi kèm
                    if (rs.getObject("videoId") != null) {
                        Video v = new Video();
                        v.setVideoId(rs.getInt("videoId"));
                        v.setTitle(rs.getString("title"));
                        v.setUrl(rs.getString("url"));
                        v.setThumbnailUrl(rs.getString("thumbnailUrl"));
                        v.setDuration(rs.getInt("duration"));
                        ex.setVideo(v);
                    }

                    return ex;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
}
