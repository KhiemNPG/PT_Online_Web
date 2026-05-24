package model.entity;

import java.sql.Timestamp;

public class SavedMeal {
    private int id;
    private int accountId;
    private String mealName;
    private float calories;
    private String recipe;
    private String imgSrc;
    private Integer suggestIdx;
    private Timestamp createdAt;

    public SavedMeal() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }

    public String getMealName() { return mealName; }
    public void setMealName(String mealName) { this.mealName = mealName; }

    public float getCalories() { return calories; }
    public void setCalories(float calories) { this.calories = calories; }

    public String getRecipe() { return recipe; }
    public void setRecipe(String recipe) { this.recipe = recipe; }

    public String getImgSrc() { return imgSrc; }
    public void setImgSrc(String imgSrc) { this.imgSrc = imgSrc; }

    public Integer getSuggestIdx() { return suggestIdx; }
    public void setSuggestIdx(Integer suggestIdx) { this.suggestIdx = suggestIdx; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
