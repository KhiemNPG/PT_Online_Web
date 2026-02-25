package model.training;

import java.util.List;

public class Exercise {
    private int exerciseId;
    private String exerciseName;
    private String exerciseType;
    private String difficultyLevel;
    private String primaryMuscle;
    private String secondaryMuscles;
    private String equipmentRequired;
    private String contraindications;
    private String injuryRiskLevel;
    private int defaultSets;
    private int defaultReps;
    private int defaultRestTime;
    private double caloriesBurnedPerMinute;
    private String description;
    private String instructions;
    private String commonMistakes;
    private String tips;
    private boolean isActive;
    private Video video;

    public Exercise() {
    }

    public Exercise(int exerciseId, String exerciseName, String exerciseType, String difficultyLevel, String primaryMuscle, String secondaryMuscles, String equipmentRequired, String contraindications, String injuryRiskLevel, int defaultSets, int defaultReps, int defaultRestTime, double caloriesBurnedPerMinute, String description, String instructions, String commonMistakes, String tips, boolean isActive, Video video, boolean isCompeleted) {
        this.exerciseId = exerciseId;
        this.exerciseName = exerciseName;
        this.exerciseType = exerciseType;
        this.difficultyLevel = difficultyLevel;
        this.primaryMuscle = primaryMuscle;
        this.secondaryMuscles = secondaryMuscles;
        this.equipmentRequired = equipmentRequired;
        this.contraindications = contraindications;
        this.injuryRiskLevel = injuryRiskLevel;
        this.defaultSets = defaultSets;
        this.defaultReps = defaultReps;
        this.defaultRestTime = defaultRestTime;
        this.caloriesBurnedPerMinute = caloriesBurnedPerMinute;
        this.description = description;
        this.instructions = instructions;
        this.commonMistakes = commonMistakes;
        this.tips = tips;
        this.isActive = isActive;
        this.video = video;
    }

    public int getExerciseId() {
        return exerciseId;
    }

    public String getExerciseName() {
        return exerciseName;
    }

    public String getExerciseType() {
        return exerciseType;
    }

    public String getDifficultyLevel() {
        return difficultyLevel;
    }

    public String getPrimaryMuscle() {
        return primaryMuscle;
    }

    public String getSecondaryMuscles() {
        return secondaryMuscles;
    }

    public String getEquipmentRequired() {
        return equipmentRequired;
    }

    public String getContraindications() {
        return contraindications;
    }

    public String getInjuryRiskLevel() {
        return injuryRiskLevel;
    }

    public int getDefaultSets() {
        return defaultSets;
    }

    public int getDefaultReps() {
        return defaultReps;
    }

    public int getDefaultRestTime() {
        return defaultRestTime;
    }

    public double getCaloriesBurnedPerMinute() {
        return caloriesBurnedPerMinute;
    }

    public String getDescription() {
        return description;
    }

    public String getInstructions() {
        return instructions;
    }

    public String getCommonMistakes() {
        return commonMistakes;
    }

    public String getTips() {
        return tips;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setExerciseId(int exerciseId) {
        this.exerciseId = exerciseId;
    }

    public void setExerciseName(String exerciseName) {
        this.exerciseName = exerciseName;
    }

    public void setExerciseType(String exerciseType) {
        this.exerciseType = exerciseType;
    }

    public void setDifficultyLevel(String difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public void setPrimaryMuscle(String primaryMuscle) {
        this.primaryMuscle = primaryMuscle;
    }

    public void setSecondaryMuscles(String secondaryMuscles) {
        this.secondaryMuscles = secondaryMuscles;
    }

    public void setEquipmentRequired(String equipmentRequired) {
        this.equipmentRequired = equipmentRequired;
    }

    public void setContraindications(String contraindications) {
        this.contraindications = contraindications;
    }

    public void setInjuryRiskLevel(String injuryRiskLevel) {
        this.injuryRiskLevel = injuryRiskLevel;
    }

    public void setDefaultSets(int defaultSets) {
        this.defaultSets = defaultSets;
    }

    public void setDefaultReps(int defaultReps) {
        this.defaultReps = defaultReps;
    }

    public void setDefaultRestTime(int defaultRestTime) {
        this.defaultRestTime = defaultRestTime;
    }

    public void setCaloriesBurnedPerMinute(double caloriesBurnedPerMinute) {
        this.caloriesBurnedPerMinute = caloriesBurnedPerMinute;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    public void setCommonMistakes(String commonMistakes) {
        this.commonMistakes = commonMistakes;
    }

    public void setTips(String tips) {
        this.tips = tips;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }


}
