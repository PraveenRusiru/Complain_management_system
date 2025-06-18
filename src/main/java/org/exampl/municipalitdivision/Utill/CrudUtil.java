package org.exampl.municipalitdivision.Utill;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CrudUtil {
    public static  <T>T execute(String sql, Connection connection,Object ...obj) throws SQLException {
        Connection con = connection;
        PreparedStatement preparedStatement= con.prepareStatement(sql);
        int i=1;
        for (Object object :obj){
            preparedStatement.setObject(i, object);
            i++;
        }
        if(sql.startsWith("SELECT")||sql.startsWith("select")){
            ResultSet resultSet = preparedStatement.executeQuery();
            return (T)resultSet;
        }else{
            int result = preparedStatement.executeUpdate();
            if(result>0){
                return (T)(Boolean)true;
            }
            else{
                return (T)(Boolean)false;
            }
        }
    }
}
