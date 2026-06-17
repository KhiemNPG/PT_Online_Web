package model.payment;

import model.entity.User;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class PaymentTransaction {
    private int transactionId;
    private User user;
    private long orderCode;
    private BigDecimal amount;
    private String transactionType; // 'BUY_PRO' hoặc 'RENT_PT'
    private String status;         // 'PENDING_TRADING', 'PENDING_APPROVAL', 'SUCCESS', 'FAILED'
    private Timestamp createdAt;
    private Timestamp approvedAt;
    private String senderName;
    private String transferContent;

    public PaymentTransaction(int transactionId, User user, long orderCode, BigDecimal amount, String transactionType, String status, Timestamp createdAt, Timestamp approvedAt, String senderName, String transferContent) {
        this.transactionId = transactionId;
        this.user = user;
        this.orderCode = orderCode;
        this.amount = amount;
        this.transactionType = transactionType;
        this.status = status;
        this.createdAt = createdAt;
        this.approvedAt = approvedAt;
        this.senderName = senderName;
        this.transferContent = transferContent;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public long getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(long orderCode) {
        this.orderCode = orderCode;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getApprovedAt() {
        return approvedAt;
    }

    public void setApprovedAt(Timestamp approvedAt) {
        this.approvedAt = approvedAt;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getTransferContent() {
        return transferContent;
    }

    public void setTransferContent(String transferContent) {
        this.transferContent = transferContent;
    }
}
