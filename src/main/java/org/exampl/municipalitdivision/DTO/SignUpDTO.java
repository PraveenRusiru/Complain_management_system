package org.exampl.municipalitdivision.DTO;


import org.exampl.municipalitdivision.Utill.BCryptUtill;
import org.mindrot.jbcrypt.BCrypt;

public class SignUpDTO {
    private  String userId;
    private String userName;
    private String email;
    private String password;
    public SignUpDTO() {}
    public SignUpDTO(String userId, String userName, String email, String password) {
        this.userId = userId;
        this.userName = userName;
        this.email = email;
        this.password = BCryptUtill.hashPassword(password);
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {

        this.password = BCryptUtill.hashPassword(password);
    }

}
