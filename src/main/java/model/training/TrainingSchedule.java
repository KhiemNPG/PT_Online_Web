package model.training;

import java.util.Date;
import java.util.List;

public class TrainingSchedule {
    private int masterScheduleId;
    private String name;        // 'Nam_18_29_GiamMo'
    private String goal;        // 'Giảm mỡ'
    private String fitnessLevel;
    private String gender;      // 'Nam'
    private String ageRange;    // '18-29'
    private int totalWeeks;     // 12
    private String status;

    private int masterScheduleIdForAllSchedul;

    // ĐÂY LÀ KẾT NỐI: Danh sách tất cả các ngày trong lộ trình (84 ngày)

    public TrainingSchedule(int masterScheduleId, String name, String goal, String fitnessLevel, String gender, String ageRange, int totalWeeks, String status) {
        this.masterScheduleId = masterScheduleId;
        this.name = name;
        this.goal = goal;
        this.fitnessLevel = fitnessLevel;
        this.gender = gender;
        this.ageRange = ageRange;
        this.totalWeeks = totalWeeks;
        this.status = status;
    }

    public TrainingSchedule(int masterScheduleId, String name, String goal, String fitnessLevel, String gender, String ageRange, int totalWeeks, String status, int masterScheduleIdForAllSchedul) {
        this.masterScheduleId = masterScheduleId;
        this.name = name;
        this.goal = goal;
        this.fitnessLevel = fitnessLevel;
        this.gender = gender;
        this.ageRange = ageRange;
        this.totalWeeks = totalWeeks;
        this.status = status;
        this.masterScheduleIdForAllSchedul = masterScheduleIdForAllSchedul;
    }

    public int getMasterScheduleIdForAllSchedul() {
        return masterScheduleIdForAllSchedul;
    }

    public void setMasterScheduleIdForAllSchedul(int masterScheduleIdForAllSchedul) {
        this.masterScheduleIdForAllSchedul = masterScheduleIdForAllSchedul;
    }

    public int getMasterScheduleId() {
        return masterScheduleId;
    }

    public void setMasterScheduleId(int masterScheduleId) {
        this.masterScheduleId = masterScheduleId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGoal() {
        return goal;
    }

    public void setGoal(String goal) {
        this.goal = goal;
    }

    public String getFitnessLevel() {
        return fitnessLevel;
    }

    public void setFitnessLevel(String fitnessLevel) {
        this.fitnessLevel = fitnessLevel;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAgeRange() {
        return ageRange;
    }

    public void setAgeRange(String ageRange) {
        this.ageRange = ageRange;
    }

    public int getTotalWeeks() {
        return totalWeeks;
    }

    public void setTotalWeeks(int totalWeeks) {
        this.totalWeeks = totalWeeks;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


}
