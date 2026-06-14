package model.entity;

public class PersonalTrainer {
    // Khai báo 16 thuộc tính chuẩn theo ResultSet của Khiêm
    private int ptId;
    private int accountId;
    private String name;
    private String avatarUrl;
    private String titleLabel;
    private String slogan;
    private Integer experienceYears;   // Dùng Integer để hứng được giá trị NULL
    private Integer successfulStudents; // Dùng Integer để hứng được giá trị NULL
    private String tags;
    private String bioSummary;
    private String phone;
    private String email;
    private String facebookUrl;
    private String instagramUrl;
    private boolean isActive;
    // Đổi sang boolean cho khớp với rs.getBoolean()

    // CONSTRUCTOR ĐẦY ĐỦ 16 THAM SỐ KHỚP 100%
    public PersonalTrainer(int ptId, int accountId, String name, String avatarUrl, String titleLabel,
                           String slogan, Integer experienceYears, Integer successfulStudents,
                            String tags, String bioSummary, String phone,
                           String email, String facebookUrl, String instagramUrl, boolean isActive) {
        this.ptId = ptId;
        this.accountId = accountId;
        this.name = name;
        this.avatarUrl = avatarUrl;
        this.titleLabel = titleLabel;
        this.slogan = slogan;
        this.experienceYears = experienceYears;
        this.successfulStudents = successfulStudents;
        this.tags = tags;
        this.bioSummary = bioSummary;
        this.phone = phone;
        this.email = email;
        this.facebookUrl = facebookUrl;
        this.instagramUrl = instagramUrl;
        this.isActive = isActive;
    }

    public int getPtId() {
        return ptId;
    }

    public void setPtId(int ptId) {
        this.ptId = ptId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getTitleLabel() {
        return titleLabel;
    }

    public void setTitleLabel(String titleLabel) {
        this.titleLabel = titleLabel;
    }

    public String getSlogan() {
        return slogan;
    }

    public void setSlogan(String slogan) {
        this.slogan = slogan;
    }

    public Integer getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(Integer experienceYears) {
        this.experienceYears = experienceYears;
    }

    public Integer getSuccessfulStudents() {
        return successfulStudents;
    }

    public void setSuccessfulStudents(Integer successfulStudents) {
        this.successfulStudents = successfulStudents;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getBioSummary() {
        return bioSummary;
    }

    public void setBioSummary(String bioSummary) {
        this.bioSummary = bioSummary;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFacebookUrl() {
        return facebookUrl;
    }

    public void setFacebookUrl(String facebookUrl) {
        this.facebookUrl = facebookUrl;
    }

    public String getInstagramUrl() {
        return instagramUrl;
    }

    public void setInstagramUrl(String instagramUrl) {
        this.instagramUrl = instagramUrl;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}