package dao.PT;

import model.entity.PTAvailabilityDTO;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PTAvailabilityDAO {

    public List<PTAvailabilityDTO> getSlotsByDate(int ptId, String dateStr) {
        List<PTAvailabilityDTO> slotList = new ArrayList<>();

        // Câu lệnh SQL JOIN giữa lịch thực tế và cấu hình ca trực gốc
        String sql = "SELECT a.availabilityId, t.shiftName, t.startTime, t.endTime, a.status " +
                     "FROM PT_Availability a " +
                     "JOIN PT_SlotTemplate t ON a.slotTemplateId = t.slotTemplateId " +
                     "WHERE a.ptId = ? AND a.availableDate = ? " +
                     "ORDER BY t.startTime ASC";

        // Sử dụng try-with-resources để tự động đóng Connection, PreparedStatement và ResultSet
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, ptId);
            ps.setString(2, dateStr);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Xử lý định dạng thời gian
                    String startStr = rs.getString("startTime");
                    String endStr = rs.getString("endTime");

                    if (startStr != null && startStr.length() >= 5) startStr = startStr.substring(0, 5);
                    if (endStr != null && endStr.length() >= 5) endStr = endStr.substring(0, 5);

                    // Khởi tạo đối tượng DTO
                    PTAvailabilityDTO slot = new PTAvailabilityDTO(
                            rs.getInt("availabilityId"),
                            rs.getString("shiftName"),
                            startStr,
                            endStr,
                            rs.getString("status")
                    );
                    slotList.add(slot);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return slotList;
    }
}
