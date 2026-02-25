package model.tracking;

import java.sql.Timestamp;

public class Progress {
    private int progressId;
    private int userId;
    private int userScheduleId;
    private int completedWorkouts;
    private int skippedWorkouts;
    private double totalCaloriesBurned;
    private String status;
    private Timestamp lastUpdate;

    public Progress() {
    }

    public Progress(int progressId, int userId, int userScheduleId, int completedWorkouts, int skippedWorkouts, double totalCaloriesBurned, String status, Timestamp lastUpdate) {
        this.progressId = progressId;
        this.userId = userId;
        this.userScheduleId = userScheduleId;
        this.completedWorkouts = completedWorkouts;
        this.skippedWorkouts = skippedWorkouts;
        this.totalCaloriesBurned = totalCaloriesBurned;
        this.status = status;
        this.lastUpdate = lastUpdate;
    }

    public int getProgressId() {
        return progressId;
    }

    public void setProgressId(int progressId) {
        this.progressId = progressId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getUserScheduleId() {
        return userScheduleId;
    }

    public void setUserScheduleId(int userScheduleId) {
        this.userScheduleId = userScheduleId;
    }

    public int getCompletedWorkouts() {
        return completedWorkouts;
    }

    public void setCompletedWorkouts(int completedWorkouts) {
        this.completedWorkouts = completedWorkouts;
    }

    public int getSkippedWorkouts() {
        return skippedWorkouts;
    }

    public void setSkippedWorkouts(int skippedWorkouts) {
        this.skippedWorkouts = skippedWorkouts;
    }

    public double getTotalCaloriesBurned() {
        return totalCaloriesBurned;
    }

    public void setTotalCaloriesBurned(double totalCaloriesBurned) {
        this.totalCaloriesBurned = totalCaloriesBurned;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getLastUpdate() {
        return lastUpdate;
    }

    public void setLastUpdate(Timestamp lastUpdate) {
        this.lastUpdate = lastUpdate;
    }
}
