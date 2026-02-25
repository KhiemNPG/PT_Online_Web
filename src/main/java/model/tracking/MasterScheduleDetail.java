package model.tracking;

public class MasterScheduleDetail {
    private int masterScheduleDetailId;
    private int masterScheduleId;
    private int totalPlannedWorkouts;
    private double totalPlannedCalories;
    private int totalPlannedMinutes;
    private double estimatedWeightLoss;

    public MasterScheduleDetail() {
    }

    public MasterScheduleDetail(int masterScheduleDetailId, int masterScheduleId, int totalPlannedWorkouts, double totalPlannedCalories, int totalPlannedMinutes, double estimatedWeightLoss) {
        this.masterScheduleDetailId = masterScheduleDetailId;
        this.masterScheduleId = masterScheduleId;
        this.totalPlannedWorkouts = totalPlannedWorkouts;
        this.totalPlannedCalories = totalPlannedCalories;
        this.totalPlannedMinutes = totalPlannedMinutes;
        this.estimatedWeightLoss = estimatedWeightLoss;
    }

    public int getMasterScheduleDetailId() {
        return masterScheduleDetailId;
    }

    public void setMasterScheduleDetailId(int masterScheduleDetailId) {
        this.masterScheduleDetailId = masterScheduleDetailId;
    }

    public void setTotalPlannedCalories(double totalPlannedCalories) {
        this.totalPlannedCalories = totalPlannedCalories;
    }

    public void setEstimatedWeightLoss(double estimatedWeightLoss) {
        this.estimatedWeightLoss = estimatedWeightLoss;
    }

    public int getMasterScheduleId() {
        return masterScheduleId;
    }

    public void setMasterScheduleId(int masterScheduleId) {
        this.masterScheduleId = masterScheduleId;
    }

    public int getTotalPlannedWorkouts() {
        return totalPlannedWorkouts;
    }

    public void setTotalPlannedWorkouts(int totalPlannedWorkouts) {
        this.totalPlannedWorkouts = totalPlannedWorkouts;
    }

    public double getTotalPlannedCalories() {
        return totalPlannedCalories;
    }

    public void setTotalPlannedCalories(int totalPlannedCalories) {
        this.totalPlannedCalories = totalPlannedCalories;
    }

    public int getTotalPlannedMinutes() {
        return totalPlannedMinutes;
    }

    public void setTotalPlannedMinutes(int totalPlannedMinutes) {
        this.totalPlannedMinutes = totalPlannedMinutes;
    }

    public double getEstimatedWeightLoss() {
        return estimatedWeightLoss;
    }

    public void setEstimatedWeightLoss(int estimatedWeightLoss) {
        this.estimatedWeightLoss = estimatedWeightLoss;
    }
}
