package org.exampl.municipalitdivision.DAO;

import org.apache.commons.dbcp2.BasicDataSource;
import org.exampl.municipalitdivision.DTO.SignInDTO;
import org.exampl.municipalitdivision.DTO.SignUpDTO;
import org.exampl.municipalitdivision.Utill.CrudUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignInDao {
    private BasicDataSource dataSource;
    private Connection connection;
    public SignInDao(BasicDataSource dataSource) throws SQLException {
        this.dataSource = dataSource;
        connection= dataSource.getConnection();
    }
    public SignInDTO isSignin(String email) throws SQLException {
        ResultSet result = CrudUtil.execute("select * from users where email=?",connection,email);
        SignInDTO signUpDTO=new SignInDTO();
        if(result.next()){
            signUpDTO.setUserId(result.getString("userId"));
            signUpDTO.setUserName(result.getString("userName"));
            signUpDTO.setPassword(result.getString("password"));
        }
        return signUpDTO;
    }

}
