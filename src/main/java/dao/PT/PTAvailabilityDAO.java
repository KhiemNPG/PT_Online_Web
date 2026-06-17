package dao.PT; // Đổi lại package tùy ý ông nhé

import model.entity.PTAvailabilityDTO;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PTAvailabilityDAO extends DBContext {

    public List<PTAvailabilityDTO> getSlotsByDate(int ptId, String dateStr) {
        List<PTAvailabilityDTO> slotList = new ArrayList<>();

        // Câu lệnh SQL JOIN giữa lịch thực tế và cấu hình ca trực gốc
        String sql = "SELECT a.availabilityId, t.shiftName, t.startTime, t.endTime, a.status " +
                "FROM PT_Availability a " +
                "JOIN PT_SlotTemplate t ON a.slotTemplateId = t.slotTemplateId " +
                "WHERE a.ptId = ? AND a.availableDate = ? " +
                "ORDER BY t.startTime ASC";

        // Sử dụng try-with-resources giống hệt mẫu của ông để tự động đóng Connection/Statement
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ptId);
            ps.setString(2, dateStr);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    // Lấy giờ bắt đầu và kết thúc, cắt chuỗi bỏ bớt phần giây thừa (ví dụ: '07:00:00' -> '07:00')
                    String startStr = rs.getString("startTime");
                    String endStr = rs.getString("endTime");

                    if (startStr != null && startStr.length() >= 5) startStr = startStr.substring(0, 5);
                    if (endStr != null && endStr.length() >= 5) endStr = endStr.substring(0, 5);

                    // Khởi tạo đối tượng và ném vào danh sách
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
        } catch (Exception e) {
            e.printStackTrace();
        }

        return slotList;
    }
}