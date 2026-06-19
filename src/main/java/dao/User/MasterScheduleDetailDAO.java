package dao.User;

import model.tracking.MasterScheduleDetail;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MasterScheduleDetailDAO {

    public MasterScheduleDetail getMasterScheduleDetailByMasterScheduleId(int masterScheduleId) {
        MasterScheduleDetail masterScheduleDetail = null;
        String sql = "SELECT * FROM MasterScheduleDetail WHERE masterScheduleId = ?";

        Connection con = DBContext.getConnection();
        if (con == null) return null;

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, masterScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int masterScheduleDetailId = rs.getInt("masterDetailId");
                    int totalPlannedWorkouts = rs.getInt("totalPlannedWorkouts");
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
        } finally {
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return masterScheduleDetail;
    }

    public MasterScheduleDetail getMasterScheduleDetailForTracking(int masterScheduleId) {
        MasterScheduleDetail masterScheduleDetail = null;
        String sql = "SELECT masterDetailId, masterScheduleId, totalPlannedWorkouts, " +
                     "totalPlannedCalories, totalPlannedMinutes, estimatedWeightLoss " +
                     "FROM MasterScheduleDetail WHERE masterScheduleId = ?";

        Connection con = DBContext.getConnection();
        if (con == null) return null;

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, masterScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int masterScheduleDetailId = rs.getInt("masterDetailId");
                    int totalPlannedWorkouts = rs.getInt("totalPlannedWorkouts");
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
        } finally {
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return masterScheduleDetail;
    }
}
