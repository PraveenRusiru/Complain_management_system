package org.exampl.municipalitdivision;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.dbcp2.BasicDataSource;
import org.exampl.municipalitdivision.DAO.DashboardUserDao;
import org.exampl.municipalitdivision.DTO.ComplainDTO;
import org.exampl.municipalitdivision.Utill.DataSource;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/dashboardUser")
public class DashboardUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        System.out.println("Clicked "+req.getSession().getAttribute("user"));
        String action = req.getParameter("action");
        String userid=req.getSession().getAttribute("userId").toString();
        System.out.println("Dashboard id :"+userid);
        ServletContext context = getServletContext();
        BasicDataSource basicDataSource=(BasicDataSource)context.getAttribute("basicDataSource");
        try {
            DashboardUserDao dashboardUserDao=new DashboardUserDao(basicDataSource);
            switch (action){
                case "save"-> {
                    String subject = req.getParameter("subject");
                    String category= req.getParameter("category");
                    String description= req.getParameter("description");
                    System.out.println("Subject: "+subject+" Category: "+category+" Description: "+description);
                    ComplainDTO complainDTO=new ComplainDTO();
                    complainDTO.setUserId(userid);
                    complainDTO.setComplainId(dashboardUserDao.getNextID());
                    complainDTO.setDescription(description);
                    complainDTO.setCategory(category);
                    complainDTO.setObject(subject);
                    complainDTO.setDate(Date.valueOf(LocalDate.now()));
                    complainDTO.setStatus("pending");
                    boolean isSaved = dashboardUserDao.complainSaving(complainDTO);
                    List<ComplainDTO> allComplaint = dashboardUserDao.getAllComplaint(userid);
                    if(isSaved){
                        HttpSession session=req.getSession();
                        session.setAttribute("complaints",allComplaint);
                        session.setAttribute("success","saved");
//                        req.setAttribute("success","saved");
//                        req.getRequestDispatcher("/MunicipalITDivision_war_exploded/dashboardUser.jsp").forward(req, resp);
                        resp.sendRedirect("/MunicipalITDivision_war_exploded/dashboardUser.jsp");
                    }


                }
                case "update"-> {
                    String subject = req.getParameter("subject");
                    String category= req.getParameter("category");
                    String complainId= req.getParameter("compainId");
                    String description= req.getParameter("description");
                    System.out.println("Subject: "+subject+" Category: "+category+" Description: "+description+" ComplainId: "+complainId);
                    ComplainDTO complainDTO=new ComplainDTO();
                    complainDTO.setUserId(userid);
                    complainDTO.setComplainId(complainId);
                    complainDTO.setDescription(description);
                    complainDTO.setCategory(category);
                    complainDTO.setObject(subject);
                    complainDTO.setDate(Date.valueOf(LocalDate.now()));
                    complainDTO.setStatus("pending");
                    boolean isUpdated = dashboardUserDao.complainUpdating(complainDTO);
                    List<ComplainDTO> allComplaint = dashboardUserDao.getAllComplaint(userid);
                    if(isUpdated){
                        HttpSession session=req.getSession();
                        session.setAttribute("complaints",allComplaint);
                        session.setAttribute("success","saved");
//                        System.out.println("updated Updated" );
//                        req.setAttribute("success","saved");
//                        req.getRequestDispatcher("/MunicipalITDivision_war_exploded/dashboardUser.jsp").forward(req, resp);
                        resp.sendRedirect("/MunicipalITDivision_war_exploded/dashboardUser.jsp");
                    }else{
                        System.out.println("not updated");

                    }


                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId=req.getSession().getAttribute("userId").toString();
        System.out.println("userId: "+userId);
        String deleteID = req.getParameter("deleteID");
        System.out.println("deleteID: "+deleteID);
        ServletContext context = getServletContext();
        BasicDataSource basicDataSource=(BasicDataSource)context.getAttribute("basicDataSource");
        try {

            DashboardUserDao dashboardUserDao=new DashboardUserDao(basicDataSource);
            if(deleteID != null){
                DashboardUserDao dashboardUserDao1=new DashboardUserDao(basicDataSource);
                boolean isDeleted = dashboardUserDao1.complainDeleting(deleteID);
                List<ComplainDTO> allComplaints = dashboardUserDao.getAllComplaint(userId);
                if(isDeleted){
                    HttpSession session=req.getSession();
                    session.setAttribute("complaints",allComplaints);
                    session.setAttribute("success","deleted");
                    System.out.println("deleted deleted" );
                    resp.sendRedirect("/MunicipalITDivision_war_exploded/dashboardUser.jsp");
                    return;
                }else{
                    System.out.println("not deleted");

                }
            }
            List<ComplainDTO> allComplaint = dashboardUserDao.getAllComplaint(userId);
            req.setAttribute("complaints", allComplaint);
            req.getRequestDispatcher("/MunicipalITDivision_war_exploded/dashboardUser.jsp").forward(req, resp);


        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

    }
}
