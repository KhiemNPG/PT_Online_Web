package model.tracking;

import java.util.Date;

public class UserSchedule {

    private int userScheduleId;
    private int userId;
    private int masterScheduleId;

    private String name;
    private String goal;
    private String fitnessLevel;
    private String gender;
    private String ageRange;

    private int totalWeeks;
    private Date startDate;
    private String status;

    public UserSchedule() {}

    public UserSchedule(int userScheduleId, int userId, int masterScheduleId,
                        String name, String goal, String fitnessLevel,
                        String gender, String ageRange,
                        int totalWeeks, Date startDate, String status) {

        this.userScheduleId = userScheduleId;
        this.userId = userId;
        this.masterScheduleId = masterScheduleId;
        this.name = name;
        this.goal = goal;
        this.fitnessLevel = fitnessLevel;
        this.gender = gender;
        this.ageRange = ageRange;
        this.totalWeeks = totalWeeks;
        this.startDate = startDate;
        this.status = status;
    }

    public int getUserScheduleId() {
        return userScheduleId;
    }

    public int getUserId() {
        return userId;
    }

    public int getMasterScheduleId() {
        return masterScheduleId;
    }

    public String getName() {
        return name;
    }

    public String getGoal() {
        return goal;
    }

    public String getFitnessLevel() {
        return fitnessLevel;
    }

    public String getGender() {
        return gender;
    }

    public String getAgeRange() {
        return ageRange;
    }

    public int getTotalWeeks() {
        return totalWeeks;
    }

    public Date getStartDate() {
        return startDate;
    }

    public String getStatus() {
        return status;
    }
}