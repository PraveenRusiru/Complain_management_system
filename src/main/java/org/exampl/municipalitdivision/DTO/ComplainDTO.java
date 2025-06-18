package org.exampl.municipalitdivision.DTO;

import java.sql.Date;

public class ComplainDTO {
    private String complainId;
    private String userId;
    private String object;
    private String category;
    private String description;
    private String imgPth;
    private String status;
    private Date date;
    private Date lastUpdate;
    private String comment;
    private String reviewedBy;
    public ComplainDTO(String complainId, String userId,String object, String category, String description, Date date,Date lastUpdate,String comment,String imgPth,String status,String reviewedBy) {
        this.complainId = complainId;
        this.userId = userId;
        this.comment = comment;
        this.object = object;
        this.category = category;
        this.description = description;
        this.date = date;
        this.imgPth = imgPth;
        this.lastUpdate = lastUpdate;
        this.status = status;
        this.reviewedBy = reviewedBy;
    }
    public ComplainDTO(){}
    public String getComplainId() {
        return complainId;
    }
    public void setComplainId(String complainId) {
        this.complainId = complainId;
    }
    public String getObject() {
        return object;
    }
    public void setObject(String object) {
        this.object = object;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getImgPth() {
        return imgPth;
    }
    public void setImgPth(String imgPth) {
        this.imgPth = imgPth;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public Date getDate() {
        return date;
    }
    public void setDate(Date date) {
        this.date = date;
    }
    public String getComment() {
        return comment;
    }
    public void setComment(String comment) {
        this.comment = comment;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public Date getLastUpdate() {
        return lastUpdate;
    }
    public void setLastUpdate(Date lastUpdate) {
        this.lastUpdate = lastUpdate;
    }
    public String getReviewedBy() {
        return reviewedBy;
    }
    public void setReviewedBy(String reviewedBy) {
        this.reviewedBy = reviewedBy;
    }


}
