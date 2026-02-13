package model.entity;

import java.sql.Timestamp;

public class HealthProfile {

    private int healthProfileId;
    private int userId;
    private int requirementId;

    private String ageRange;
    private String gender;
    private String jointIssues;

    private Timestamp updatedAt;

    public HealthProfile() {}

    public HealthProfile(int healthProfileId, int userId, int requirementId,
                         String ageRange, String gender,
                         String jointIssues, Timestamp updatedAt) {

        this.healthProfileId = healthProfileId;
        this.userId = userId;
        this.requirementId = requirementId;
        this.ageRange = ageRange;
        this.gender = gender;
        this.jointIssues = jointIssues;
        this.updatedAt = updatedAt;
    }

    public int getHealthProfileId() { return healthProfileId; }
    public void setHealthProfileId(int healthProfileId) { this.healthProfileId = healthProfileId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getRequirementId() { return requirementId; }
    public void setRequirementId(int requirementId) { this.requirementId = requirementId; }

    public String getAgeRange() { return ageRange; }
    public void setAgeRange(String ageRange) { this.ageRange = ageRange; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getJointIssues() { return jointIssues; }
    public void setJointIssues(String jointIssues) { this.jointIssues = jointIssues; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}
