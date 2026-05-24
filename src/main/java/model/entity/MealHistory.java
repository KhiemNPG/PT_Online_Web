package model.entity;

import java.sql.Timestamp;

public class MealHistory {
    private int id;
    private int accountId;
    private String mealName;
    private float calories;
    private String mealTime;
    private Integer suggestIdx;
    private Timestamp createdAt;

    public MealHistory() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }

    public String getMealName() { return mealName; }
    public void setMealName(String mealName) { this.mealName = mealName; }

    public float getCalories() { return calories; }
    public void setCalories(float calories) { this.calories = calories; }

    public String getMealTime() { return mealTime; }
    public void setMealTime(String mealTime) { this.mealTime = mealTime; }

    public Integer getSuggestIdx() { return suggestIdx; }
    public void setSuggestIdx(Integer suggestIdx) { this.suggestIdx = suggestIdx; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
