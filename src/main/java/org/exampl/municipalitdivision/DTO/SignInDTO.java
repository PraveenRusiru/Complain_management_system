package org.exampl.municipalitdivision.DTO;

public class SignInDTO {
    private String userId;
    private String userName;
    private String password;
    public SignInDTO() {}
    public SignInDTO(String userId, String userName,String password) {
        this.userId = userId;
        this.userName = userName;
        this.password = password;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
}
