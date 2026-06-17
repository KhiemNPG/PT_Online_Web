package model.entity; // Đổi lại package cho đúng cấu trúc dự án của ông

public class PTAvailabilityDTO {
    private int availabilityId;
    private String shiftName;
    private String startTime;
    private String endTime;
    private String status;

    // Constructor mặc định
    public PTAvailabilityDTO() {
    }

    // Constructor đầy đủ tham số để dùng trong DAO
    public PTAvailabilityDTO(int availabilityId, String shiftName, String startTime, String endTime, String status) {
        this.availabilityId = availabilityId;
        this.shiftName = shiftName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    // Getter và Setter
    public int getAvailabilityId() {
        return availabilityId;
    }

    public void setAvailabilityId(int availabilityId) {
        this.availabilityId = availabilityId;
    }

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}