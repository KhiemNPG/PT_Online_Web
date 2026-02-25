package model.training;

public class TrainingTemplate {
    private int masterDayId;      // Liên kết với ngày nào (Day 1, Day 2...)
    private int exerciseId;       // Liên kết với bài tập nào (Squat, Lunge...)

    // Các thông số tập luyện thực tế
    private int sets;             // Số hiệp (Ví dụ: 3 hiệp)
    private int reps;             // Số lần mỗi hiệp (Ví dụ: 12 lần hoặc 40 giây)
    private int restTime;         // Thời gian nghỉ giữa các hiệp (giây)
    private int orderInWorkout;   // Thứ tự tập trong buổi (Bài nào tập trước, bài nào tập sau)

    // Để lấy được thông tin chi tiết bài tập,
    // bro thường sẽ lồng thêm đối tượng Exercise vào đây
    private Exercise exercise;

    public TrainingTemplate(int masterDayId, int exerciseId, int sets, int reps, int restTime, int orderInWorkout, Exercise exercise) {
        this.masterDayId = masterDayId;
        this.exerciseId = exerciseId;
        this.sets = sets;
        this.reps = reps;
        this.restTime = restTime;
        this.orderInWorkout = orderInWorkout;
        this.exercise = exercise;
    }

    public int getMasterDayId() {
        return masterDayId;
    }

    public void setMasterDayId(int masterDayId) {
        this.masterDayId = masterDayId;
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

    public Exercise getExercise() {
        return exercise;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }
}
