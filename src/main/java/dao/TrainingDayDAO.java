package dao;

import model.training.TrainingDay;
import model.training.TrainingWorkoutExercise;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TrainingDayDAO extends DBContext {
    public List<TrainingDay> getOneTrainingDayFromTemplate(int masterScheduleId) {
        TrainingDay trainingDay = null;
        ArrayList<TrainingDay> trainingDayList = new ArrayList<>();
        String sql = "SELECT * from MasterDay "
                + "where masterScheduleId = ? ORDER BY weekIndex, dayIndex";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, masterScheduleId);
            ResultSet rs = ps.executeQuery();
            Timestamp time = Timestamp.valueOf("2024-05-20 10:30:00");
            while (rs.next()) {
                int masterDayId = rs.getInt("masterDayId");
                //int userScheduleId = rs.getInt("userScheduleId");
                int dayIndex = rs.getInt("dayIndex");
                int weekIndex = rs.getInt("weekIndex");
                String workoutLabel = rs.getString("workoutLabel");
                String dayType = rs.getString("dayType");
                trainingDay = new TrainingDay(masterDayId, masterScheduleId, dayIndex, weekIndex, workoutLabel, dayType, false, time);
                trainingDayList.add(trainingDay);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trainingDayList;
    }

    public List<TrainingDay> createTrainingDay(List<TrainingDay> trainingDayList, String dayOfWeek, int userScheduleId) {
        // 1. Xác định ngày bắt đầu (Giữ nguyên logic của bro)
        java.time.DayOfWeek targetDay;
        switch (dayOfWeek.toUpperCase()) {
            case "T2": targetDay = java.time.DayOfWeek.MONDAY; break;
            case "T3": targetDay = java.time.DayOfWeek.TUESDAY; break;
            case "T4": targetDay = java.time.DayOfWeek.WEDNESDAY; break;
            case "T5": targetDay = java.time.DayOfWeek.THURSDAY; break;
            case "T6": targetDay = java.time.DayOfWeek.FRIDAY; break;
            case "T7": targetDay = java.time.DayOfWeek.SATURDAY; break;
            case "CN": targetDay = java.time.DayOfWeek.SUNDAY; break;
            default: targetDay = java.time.DayOfWeek.MONDAY;
        }

        java.time.LocalDate runningDate = java.time.LocalDate.now().with(java.time.temporal.TemporalAdjusters.nextOrSame(targetDay));

        String sql = "INSERT INTO UserDay (userScheduleId, dayIndex, weekIndex, workoutLabel, dayType, isCompleted, completedDate, scheduledDate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            if (trainingDayList == null || trainingDayList.isEmpty()) {
                return null;
            }

            // TẮT AutoCommit để quản lý Transaction thủ công
            conn.setAutoCommit(false);

            // Thêm Statement.RETURN_GENERATED_KEYS để lấy ID tự tăng
            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                for (TrainingDay td : trainingDayList) {
                    stmt.setInt(1, userScheduleId);
                    stmt.setInt(2, td.getDayIndex());
                    stmt.setInt(3, td.getWeekIndex());
                    stmt.setString(4, td.getWorkoutLabel());
                    stmt.setString(5, td.getDayType());
                    stmt.setBoolean(6, false);
                    stmt.setNull(7, Types.TIMESTAMP);
                    stmt.setDate(8, Date.valueOf(runningDate));

                    // CHẠY TỪNG DÒNG (An toàn hơn Batch khi cần lấy Key)
                    int affectedRows = stmt.executeUpdate();

                    if (affectedRows > 0) {
                        // LẤY ID VỪA SINH RA
                        try (ResultSet rs = stmt.getGeneratedKeys()) {
                            if (rs.next()) {
                                // Gán ID vào biến MasterDayId (để lát nữa dùng Map/Khớp bài tập)
                                td.setMasterDayId(rs.getInt(1));
                            }
                        }
                    }
                    // Tăng ngày lên 1 cho dòng tiếp theo
                    runningDate = runningDate.plusDays(1);
                }

                // CHỐT ĐƠN: Lưu tất cả vào Database
                conn.commit();
                System.out.println(">>> SUCCESS: Đã lưu " + trainingDayList.size() + " ngày vào bảng UserDay.");
                return trainingDayList;

            } catch (SQLException e) {
                if (conn != null) {
                    conn.rollback(); // Lỗi 1 dòng là xóa sạch cả cụm để bảo vệ dữ liệu
                    System.err.println(">>> ROLLBACK: Có lỗi xảy ra, đã hủy thao tác chèn ngày.");
                }
                e.printStackTrace();
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            try { conn.setAutoCommit(true); } catch (SQLException e) {}
        }
    }

    public List<TrainingDay> getOneTrainingDayFromUser(int userScheduleId) {
        TrainingDay trainingDay = null;
        ArrayList<TrainingDay> trainingDayList = new ArrayList<>();
        String sql = "SELECT * from UserDay "
                + "where userScheduleId = ? ORDER BY weekIndex, dayIndex";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userScheduleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int masterDayId = rs.getInt("userDayId");
                //int userScheduleId = rs.getInt("userScheduleId");
                int dayIndex = rs.getInt("dayIndex");
                int weekIndex = rs.getInt("weekIndex");
                String workoutLabel = rs.getString("workoutLabel");
                String dayType = rs.getString("dayType");
                Boolean isCompleted = rs.getBoolean("isCompleted");
                Timestamp time = rs.getTimestamp("scheduledDate");
                trainingDay = new TrainingDay(masterDayId, userScheduleId, dayIndex, weekIndex, workoutLabel, dayType, isCompleted, time);
                trainingDayList.add(trainingDay);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trainingDayList;
    }

    public List<TrainingDay> getAllDayByUserScheduleId(int userScheduleId) {
        List<TrainingDay> list = new ArrayList<>();
        // Sắp xếp theo dayIndex để đảm bảo thứ tự từ ngày 1 đến ngày 84
        String sql = "SELECT * FROM UserDay WHERE userScheduleId = ? ORDER BY dayIndex ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userScheduleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TrainingDay td = new TrainingDay();
                    // MasterDayId ở đây chính là khóa chính (UserDayId) của bảng UserDay
                    td.setMasterDayId(rs.getInt("masterDayId"));
                    td.setDayIndex(rs.getInt("dayIndex"));
                    td.setWeekIndex(rs.getInt("weekIndex"));
                    td.setWorkoutLabel(rs.getString("workoutLabel"));
                    // ... set thêm các trường khác nếu cần ...
                    list.add(td);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        // 1. Khởi tạo DAO (để có kết nối conn)
        TrainingDayDAO dao = new TrainingDayDAO();

        // 2. Lấy dữ liệu mẫu từ Master (Bước này bro đã test thành công lấy được 84 dòng)
        int masterId = 1; // ID mẫu trong DB của bro
        List<TrainingDay> templateList = dao.getOneTrainingDayFromTemplate(masterId);

        if (templateList != null && !templateList.isEmpty()) {

            // 3. Giả lập một userScheduleId thực tế
            // (Bro hãy mở DB bảng UserSchedule lấy 1 cái ID đã tồn tại để test)
            int testUserScheduleId = 4;

            // 4. Chọn thứ bắt đầu (ví dụ Thứ 2)
            String startDay = "T2";

            System.out.println("Đang bắt đầu lưu " + templateList.size() + " ngày tập vào UserDay...");

            // 5. Gọi hàm cần test
            dao.createTrainingDay(templateList, startDay, testUserScheduleId);

            System.out.println("Đã chạy xong hàm createTrainingDay!");
            System.out.println("Bro hãy vào SQL kiểm tra: SELECT * FROM UserDay WHERE userScheduleId = " + testUserScheduleId);
        } else {
            System.out.println("Không lấy được dữ liệu mẫu, check lại masterId!");
        }
    }

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
}
