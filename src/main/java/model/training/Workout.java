package model.training;
import java.util.List;

public class Workout {
    private int workoutId;
    private String workoutName;
    private int duration;
    private String intensityLevel;

    // Thuộc tính quan trọng để chứa các bài tập trong buổi
    private List<Exercise> exercises;
}
