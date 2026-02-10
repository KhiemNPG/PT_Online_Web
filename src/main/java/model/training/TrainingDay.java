package model.training;

public class TrainingDay {
    private int trainingDayId;
    private int scheduleId;
    private int dayOfWeek; // Ví dụ: Day 1, Day 2... Day 30

    // Liên kết trực tiếp tới Model Workout để lấy danh sách bài tập
    private Workout workout;
}
