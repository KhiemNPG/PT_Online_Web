package model.entity;

import java.security.Timestamp;

public class Account {
    private int accountId;
    private String username;
    private String passwordHash;
    private String role;
    private boolean isActive;
    private Timestamp createdAt;
}
