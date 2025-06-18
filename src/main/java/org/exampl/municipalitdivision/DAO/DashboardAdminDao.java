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

public class DashboardAdminDao {
    private BasicDataSource dataSource;
    private Connection connection;
    public DashboardAdminDao(BasicDataSource dataSource) throws SQLException {
        this.dataSource = dataSource;
        connection= dataSource.getConnection();
    }
    public boolean complainUpdating(ComplainDTO complainDTO) throws SQLException {
        String status=complainDTO.getStatus();
        String complainId = complainDTO.getComplainId();
        String reviewedBy = complainDTO.getReviewedBy();
        String comment = complainDTO.getComment();
        System.out.println("dashboardDao "+complainId+" "+status+" "+reviewedBy+" "+comment);
        return CrudUtil.execute("update complains set comment=?,status=?,reviewed_by=? where complain_id=?",connection,comment,status,reviewedBy,complainId);
    }
    public boolean complainDeleting(String complainId) throws SQLException {
        return CrudUtil.execute("delete from complains where complain_id=?",connection,complainId);
    }
    public List<ComplainDTO> getAllComplaint() throws SQLException {
        List<ComplainDTO> complains = new ArrayList<>();
        ResultSet rst=CrudUtil.execute("select *  from complains ",connection);
        while(rst.next()){
            ComplainDTO signUpDTO=new ComplainDTO(rst.getString(1),rst.getString(2),rst.getString(3),rst.getString(4),rst.getString(5),rst.getDate(6), rst.getDate(7),rst.getString(8),rst.getString(9),rst.getString(10),rst.getString(11));
            complains.add(signUpDTO);
        }
        return complains;
    }
}


