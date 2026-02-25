package model.training;

import java.sql.Timestamp;
import java.util.List;

public class TrainingDay {
    private int masterDayId;
    private int userScheduleId;
    private int dayIndex;    // Ví dụ: 1, 2, 3... 84
    private int weekIndex;   // Ví dụ: 1, 2... 12
    private String workoutLabel; // "Ngày tập chân", "Toàn thân"...
    private String dayType;  // "Workout" hoặc "Rest"
    private boolean isCompleted;
    private Timestamp scheduledDate;

    // ĐÂY LÀ KẾT NỐI: Danh sách bài tập của ngày này
    // Nếu dayType = 'Rest', list này sẽ chỉ có 1 bài "Nghỉ ngơi" (ID 999)

    public TrainingDay(int masterDayId, int userScheduleId, int dayIndex, int weekIndex, String workoutLabel, String dayType, boolean isCompleted, Timestamp scheduledDate) {
        this.masterDayId = masterDayId;
        this.userScheduleId = userScheduleId;
        this.dayIndex = dayIndex;
        this.weekIndex = weekIndex;
        this.workoutLabel = workoutLabel;
        this.dayType = dayType;
        this.isCompleted = isCompleted;
        this.scheduledDate = scheduledDate;
    }

    public TrainingDay() {
    }

    public int getMasterDayId() {
        return masterDayId;
    }

    public void setMasterDayId(int masterDayId) {
        this.masterDayId = masterDayId;
    }

    public int getDayIndex() {
        return dayIndex;
    }

    public void setDayIndex(int dayIndex) {
        this.dayIndex = dayIndex;
    }

    public int getWeekIndex() {
        return weekIndex;
    }

    public void setWeekIndex(int weekIndex) {
        this.weekIndex = weekIndex;
    }

    public String getWorkoutLabel() {
        return workoutLabel;
    }

    public void setWorkoutLabel(String workoutLabel) {
        this.workoutLabel = workoutLabel;
    }

    public String getDayType() {
        return dayType;
    }

    public void setDayType(String dayType) {
        this.dayType = dayType;
    }

    public int getUserScheduleId() {
        return userScheduleId;
    }

    public void setUserScheduleId(int userScheduleId) {
        this.userScheduleId = userScheduleId;
    }

    public boolean isCompleted() {
        return isCompleted;
    }

    public void setCompleted(boolean completed) {
        isCompleted = completed;
    }

    public Timestamp getScheduledDate() {
        return scheduledDate;
    }

    public void setScheduledDate(Timestamp scheduledDate) {
        this.scheduledDate = scheduledDate;
    }
}
