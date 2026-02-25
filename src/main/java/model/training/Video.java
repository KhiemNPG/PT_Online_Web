package model.training;

public class Video {
    private int videoId;
    private String title;
    private String url;
    private int duration;
    private String thumbnailUrl;

    public Video(int videoId, String title, String url, int duration, String thumbnailUrl) {
        this.videoId = videoId;
        this.title = title;
        this.url = url;
        this.duration = duration;
        this.thumbnailUrl = thumbnailUrl;
    }

    public Video() {
    }

    public int getVideoId() {
        return videoId;
    }

    public void setVideoId(int videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }
}
