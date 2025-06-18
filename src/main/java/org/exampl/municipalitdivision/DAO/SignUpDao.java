package org.exampl.municipalitdivision.DAO;

import jakarta.servlet.ServletContext;
import org.apache.commons.dbcp2.BasicDataSource;
import org.exampl.municipalitdivision.DTO.SignUpDTO;
import org.exampl.municipalitdivision.Utill.CrudUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SignUpDao {
    private BasicDataSource dataSource;
    Connection conn;
    public SignUpDao(BasicDataSource dataSource) throws SQLException {
        this.dataSource = dataSource;
        conn =dataSource.getConnection();
    }
    public List<SignUpDTO> getAllUsers() throws SQLException {
        List<SignUpDTO> users = new ArrayList<>();
        ResultSet rst=CrudUtil.execute("select * from users",conn);
        while(rst.next()){
            SignUpDTO signUpDTO=new SignUpDTO(rst.getString(1),rst.getString(2),rst.getString(3),rst.getString(4));
            users.add(signUpDTO);
        }
        return users;
    }
    public boolean usersignup(SignUpDTO signUpDTO) throws SQLException {

        boolean isSaved = CrudUtil.execute("insert into users values(?,?,?,?)", conn, signUpDTO.getUserId(), signUpDTO.getUserName(), signUpDTO.getEmail(), signUpDTO.getPassword());
        return  isSaved;
    }
    public String getNextId() throws SQLException {

        ResultSet resultSet=CrudUtil.execute("select users.userId from users order by userId desc limit 1",conn);
        if(resultSet.next()){
            String lastId=resultSet.getString(1);
            String numerical=lastId.substring(1);
            int numercialPart1=Integer.parseInt(numerical.substring(0,2));
            int numercialPart2=Integer.parseInt(numerical.substring(3,6));
            if(numercialPart2==999){
                numercialPart1++;
                numercialPart2=000;
            }else{
                numercialPart2++;
            }
            String newNumericalPart1=String.format("%02d",numercialPart1);
            String newNumericalPart2=String.format("%03d",numercialPart2);
            System.out.println(numerical+" "+numercialPart1+" "+numercialPart2);
            String newId="U"+newNumericalPart1+"-"+newNumericalPart2;
            System.out.println("new "+newId);
            return newId;
        }else{
            return "U00-001";
        }

    }
}
