package org.exampl.municipalitdivision;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.dbcp2.BasicDataSource;
import org.exampl.municipalitdivision.DAO.DashboardAdminDao;
import org.exampl.municipalitdivision.DTO.ComplainDTO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/dashboardAdmin")
public class DashboardAdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId=req.getSession().getAttribute("userId").toString();
        System.out.println("userId: "+userId);
        String deleteID = req.getParameter("deleteID");
        System.out.println("deleteID: "+deleteID);
        ServletContext context = getServletContext();
        BasicDataSource basicDataSource=(BasicDataSource)context.getAttribute("basicDataSource");
        try {

            DashboardAdminDao dashboardAdminDao =new DashboardAdminDao(basicDataSource);
            if(deleteID != null){
                DashboardAdminDao dashboardAdminDao1=new DashboardAdminDao(basicDataSource);
                boolean isDeleted = dashboardAdminDao1.complainDeleting(deleteID);
                List<ComplainDTO> allComplaints = dashboardAdminDao1.getAllComplaint();
                if(isDeleted){
                    HttpSession session=req.getSession();
                    session.setAttribute("complaints",allComplaints);
                    session.setAttribute("success","deleted");
                    System.out.println("deleted deleted" );
                    resp.sendRedirect("/MunicipalITDivision_war_exploded/dashboardAdmin.jsp");
                    return;
                }else{
                    System.out.println("not deleted");

                }
            }
            List<ComplainDTO> allComplaint = dashboardAdminDao.getAllComplaint();
            req.setAttribute("complaints", allComplaint);
            req.getRequestDispatcher("/MunicipalITDivision_war_exploded/dashboardAdmin.jsp").forward(req, resp);


        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId=req.getSession().getAttribute("userId").toString();
        String action=req.getParameter("action");
        ServletContext context = getServletContext();
        BasicDataSource basicDataSource=(BasicDataSource)context.getAttribute("basicDataSource");
        try {
            DashboardAdminDao dashboardAdminDao=new DashboardAdminDao(basicDataSource);
            switch (action){
                case "update"->{
                    String staus=req.getParameter("status");
                    String complaintId = req.getParameter("complaintId");
                    String comments = req.getParameter("comments");
                    ComplainDTO complainDTO=new ComplainDTO();
                    complainDTO.setStatus(staus);
                    complainDTO.setComplainId(complaintId);
                    complainDTO.setComment(comments);
                    complainDTO.setReviewedBy(userId);
                    boolean complainUpdating = dashboardAdminDao.complainUpdating(complainDTO);
                    List<ComplainDTO> allComplaint = dashboardAdminDao.getAllComplaint();
                    if(complainUpdating){
                        HttpSession session=req.getSession();
                        session.setAttribute("complaints",allComplaint);
                        session.setAttribute("success","saved");
//                        req.setAttribute("success","saved");
//                        req.getRequestDispatcher("/MunicipalITDivision_war_exploded/dashboardUser.jsp").forward(req, resp);
                        resp.sendRedirect("/MunicipalITDivision_war_exploded/dashboardAdmin.jsp");
                    }

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
