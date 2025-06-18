package org.exampl.municipalitdivision.DAO;

import org.apache.commons.dbcp2.BasicDataSource;
import org.exampl.municipalitdivision.DTO.ComplainDTO;
import org.exampl.municipalitdivision.Utill.CrudUtil;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DashboardUserDao {
    private BasicDataSource dataSource;
    private Connection connection;
    public DashboardUserDao(BasicDataSource dataSource) throws SQLException {
        this.dataSource = dataSource;
        connection=dataSource.getConnection();
    }
    public boolean complainSaving(ComplainDTO complainDTO) throws SQLException {
        String subject=complainDTO.getObject();
        String complainId = complainDTO.getComplainId();
        String description = complainDTO.getDescription();
        String category = complainDTO.getCategory();
        Date date = complainDTO.getDate();
        String status = complainDTO.getStatus();
        String userId=complainDTO.getUserId();
        String imgPth = complainDTO.getImgPth()!=null?complainDTO.getImgPth():null;
        return CrudUtil.execute("insert into complains(complain_id, userId, subject, category, description, Date, imagePath, status)values (?,?,?,?,?,?,?,?)",connection,complainId,userId,subject,category,description,date,imgPth,status);
    }
    public boolean complainUpdating(ComplainDTO complainDTO) throws SQLException {
        String subject=complainDTO.getObject();
        String complainId = complainDTO.getComplainId();
        String description = complainDTO.getDescription();
        String category = complainDTO.getCategory();
        Date lastupdated_date= Date.valueOf(LocalDate.now());
        String imgPth = complainDTO.getImgPth()!=null?complainDTO.getImgPth():null;
        System.out.println("dashboardDao "+subject+" "+complainId+" "+description+" "+category);
        return CrudUtil.execute("update complains set subject=?,description=?,category=?,imagePath=?,last_update_date=? where complain_id=?",connection,subject,description,category,imgPth,lastupdated_date,complainId);
    }
    public boolean complainDeleting(String complainId) throws SQLException {
        return CrudUtil.execute("delete from complains where complain_id=?",connection,complainId);
    }
    public String getNextID() throws SQLException {
        ResultSet resultSet=CrudUtil.execute("select complains.complain_id from complains order by complains.complain_id desc limit 1",connection);
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
            String newId="C"+newNumericalPart1+"-"+newNumericalPart2;
            System.out.println("new "+newId);
            return newId;
        }else{
            return "C00-001";
        }

    }
    public List<ComplainDTO> getAllComplaint(String userId) throws SQLException {
        List<ComplainDTO> complains = new ArrayList<>();
        ResultSet rst=CrudUtil.execute("select *  from complains where userId=?",connection,userId);
        while(rst.next()){
            ComplainDTO signUpDTO=new ComplainDTO(rst.getString(1),rst.getString(2),rst.getString(3),rst.getString(4),rst.getString(5),rst.getDate(6), rst.getDate(7),rst.getString(8),rst.getString(9),rst.getString(10),rst.getString(11));
            complains.add(signUpDTO);

        }
        return complains;
    }
}
