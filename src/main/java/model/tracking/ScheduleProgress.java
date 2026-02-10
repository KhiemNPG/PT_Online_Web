package model.tracking;

import java.security.Timestamp;

public class ScheduleProgress {
    private int progressId;
    private int scheduleId;
    private int currentDay;
    private int completedWorkouts;
    private int totalWorkouts;
    private String status;
    private Timestamp lastUpdated;
}
