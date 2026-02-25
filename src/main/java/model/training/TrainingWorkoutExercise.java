package model.training;

public class TrainingWorkoutExercise {
    private int masterWorkoutExerciseId; // Đổi tên cho rõ ràng là ID
    private int trainingDayId;
    private int exerciseId;
    private int sets;
    private int reps;
    private int restTime;
    private int orderInWorkout;
    private int dayIndex;
    private boolean isFinished;

    public TrainingWorkoutExercise() {
    }

    // Constructor sửa lại tên biến cho chuẩn
    public TrainingWorkoutExercise(int masterWorkoutExerciseId, int trainingDayId, int exerciseId, int sets, int reps, int restTime, int orderInWorkout) {
        this.masterWorkoutExerciseId = masterWorkoutExerciseId;
        this.trainingDayId = trainingDayId;
        this.exerciseId = exerciseId;
        this.sets = sets;
        this.reps = reps;
        this.restTime = restTime;
        this.orderInWorkout = orderInWorkout;
    }

    public TrainingWorkoutExercise(int masterWorkoutExerciseId, int trainingDayId, int exerciseId, int sets, int reps, int restTime, int orderInWorkout, int dayIndex, boolean isFinished) {
        this.masterWorkoutExerciseId = masterWorkoutExerciseId;
        this.trainingDayId = trainingDayId;
        this.exerciseId = exerciseId;
        this.sets = sets;
        this.reps = reps;
        this.restTime = restTime;
        this.orderInWorkout = orderInWorkout;
        this.dayIndex = dayIndex;
        this.isFinished = isFinished;
    }

    public int getMasterWorkoutExerciseId() {
        return masterWorkoutExerciseId;
    }

    public void setMasterWorkoutExerciseId(int id) {
        this.masterWorkoutExerciseId = id;
    }

    public int getTrainingDayId() {
        return trainingDayId;
    }

    public void setTrainingDayId(int trainingDayId) {
        this.trainingDayId = trainingDayId;
    }

    public int getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(int exerciseId) {
        this.exerciseId = exerciseId;
    }

    public int getSets() {
        return sets;
    }

    public void setSets(int sets) {
        this.sets = sets;
    }

    public int getReps() {
        return reps;
    }

    public void setReps(int reps) {
        this.reps = reps;
    }

    public int getRestTime() {
        return restTime;
    }

    public void setRestTime(int restTime) {
        this.restTime = restTime;
    }

    public int getOrderInWorkout() {
        return orderInWorkout;
    }

    public void setOrderInWorkout(int orderInWorkout) {
        this.orderInWorkout = orderInWorkout;
    }

    public int getDayIndex() {
        return dayIndex;
    }

    public void setDayIndex(int dayIndex) {
        this.dayIndex = dayIndex;
    }

    public boolean isFinished() {
        return isFinished;
    }

    public void setFinished(boolean finished) {
        isFinished = finished;
    }
}
