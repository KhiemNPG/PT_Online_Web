package model.entity;

import java.sql.Timestamp;

public class TrainingRequirement {
    private int requirementId;
    private int userId;

    private String goal;
    private String availableTime;
    private String preferredDays;

    private boolean isCompleted;
    private Timestamp createdAt;

    public TrainingRequirement() {}

    public int getRequirementId() { return requirementId; }
    public void setRequirementId(int requirementId) { this.requirementId = requirementId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getGoal() { return goal; }
    public void setGoal(String goal) { this.goal = goal; }

    public String getAvailableTime() { return availableTime; }
    public void setAvailableTime(String availableTime) { this.availableTime = availableTime; }

    public String getPreferredDays() { return preferredDays; }
    public void setPreferredDays(String preferredDays) { this.preferredDays = preferredDays; }

    public boolean isCompleted() { return isCompleted; }
    public void setCompleted(boolean completed) { isCompleted = completed; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
