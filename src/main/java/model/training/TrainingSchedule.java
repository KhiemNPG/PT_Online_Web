package model.training;

import java.util.Date;
import java.util.List;

public class TrainingSchedule {
    private int scheduleId;
    private int userId;
    private String scheduleName;
    private Date startDate;
    private Date endDate;
    private String note;

    // Danh sách các ngày trong lộ trình (Day 1 -> Day 30)
    private List<TrainingDay> trainingDays;
}
