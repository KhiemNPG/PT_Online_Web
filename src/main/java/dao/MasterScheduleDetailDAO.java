package dao;

import model.tracking.MasterScheduleDetail;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MasterScheduleDetailDAO extends DBContext {

    public MasterScheduleDetail getMasterScheduleDetailByMasterScheduleId(int masterScheduleId) {
        MasterScheduleDetail masterScheduleDetail = null;
        String sql = "SELECT * FROM MasterScheduleDetail WHERE masterScheduleId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) { // Dùng try-with-resources để tự đóng ps
            ps.setInt(1, masterScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { // Dùng if vì chỉ có 1 dòng dữ liệu
                    int masterScheduleDetailId = rs.getInt("masterScheduleDetailId");
                    int totalPlannedWorkouts = rs.getInt("totalPlannedWorkouts");

                    // Sửa thành getDouble vì SQL là FLOAT
                    double totalPlannedCalories = rs.getDouble("totalPlannedCalories");
                    int totalPlannedMinutes = rs.getInt("totalPlannedMinutes");
                    double estimatedWeightLoss = rs.getDouble("estimatedWeightLoss");

                    masterScheduleDetail = new MasterScheduleDetail(
                            masterScheduleDetailId,
                            masterScheduleId,
                            totalPlannedWorkouts,
                            totalPlannedCalories,
                            totalPlannedMinutes,
                            estimatedWeightLoss
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return masterScheduleDetail;
    }
}
