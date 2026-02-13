package model.entity;

public class User {
    private int userId;
    private int accountId;
    private String name;
    private Integer age;
    private String gender;
    private Double height;
    private Double weight;
    private String fitnessLevel;

    public User() {
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public Double getHeight() { return height; }
    public void setHeight(Double height) { this.height = height; }

    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = weight; }

    public String getFitnessLevel() { return fitnessLevel; }
    public void setFitnessLevel(String fitnessLevel) { this.fitnessLevel = fitnessLevel; }

    public User(int userId, int accountId, String name, Integer age, String gender, Double height, Double weight, String fitnessLevel) {
        this.userId = userId;
        this.accountId = accountId;
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.height = height;
        this.weight = weight;
        this.fitnessLevel = fitnessLevel;
    }
}
