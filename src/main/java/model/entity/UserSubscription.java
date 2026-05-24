package model.entity;

import java.sql.Timestamp;

public class UserSubscription {
    private int id;
    private int accountId;
    private String planType; // "FREE" or "PRO"
    private Timestamp startDate;
    private Timestamp endDate;

    public UserSubscription() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }

    public String getPlanType() { return planType; }
    public void setPlanType(String planType) { this.planType = planType; }

    public Timestamp getStartDate() { return startDate; }
    public void setStartDate(Timestamp startDate) { this.startDate = startDate; }

    public Timestamp getEndDate() { return endDate; }
    public void setEndDate(Timestamp endDate) { this.endDate = endDate; }
}
