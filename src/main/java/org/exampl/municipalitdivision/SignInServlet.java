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
import org.exampl.municipalitdivision.DAO.DashboardUserDao;
import org.exampl.municipalitdivision.DAO.SignInDao;
import org.exampl.municipalitdivision.DTO.ComplainDTO;
import org.exampl.municipalitdivision.DTO.SignInDTO;
import org.exampl.municipalitdivision.Utill.BCryptUtill;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/signin")
public class SignInServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email=req.getParameter("email");
        String password=req.getParameter("password");
        System.out.println("Password: "+password);
        System.out.println("Email: "+email);
        ServletContext context = getServletContext();
        BasicDataSource basicDataSource=(BasicDataSource)context.getAttribute("basicDataSource");
        try {
            SignInDao signInDao=new SignInDao(basicDataSource);
            DashboardUserDao dashboardUserDao=new DashboardUserDao(basicDataSource);
            SignInDTO signInDTO =signInDao.isSignin(email);
            String userId= signInDTO.getUserId();
            List<ComplainDTO> allComplaintsUser = dashboardUserDao.getAllComplaint(userId);
            DashboardAdminDao dashboardAdminDao=new DashboardAdminDao(basicDataSource);
            List<ComplainDTO> allComplaintAdmin = dashboardAdminDao.getAllComplaint();
            System.out.println("signin "+ allComplaintsUser);
            String userName=signInDTO.getUserName();
            if(signInDTO !=null){
                System.out.println("hashed pw "+ signInDTO.getPassword());
                boolean checkpw = BCryptUtill.checkPassword(password, signInDTO.getPassword());
                System.out.println("checkpw "+checkpw);
                if(checkpw){
                    HttpSession session=req.getSession();
                    session.setAttribute("userId", userId);
                    session.setAttribute("userName", userName);
                    session.setAttribute("email", email);

                    System.out.println("User id "+userId);
                    if(userId.startsWith("U")){
                        session.setAttribute("complaints", allComplaintsUser);
                        resp.sendRedirect("/MunicipalITDivision_war_exploded/dashboardUser.jsp");
                    }else if(userId.startsWith("A")){
                        session.setAttribute("complaints", allComplaintAdmin);
                        resp.sendRedirect("/MunicipalITDivision_war_exploded/dashboardAdmin.jsp");
//                        req.getRequestDispatcher("/dashboardAdmin").forward(req, resp);
                    }
                }else{
                    req.setAttribute("error", "Mismatch");
                    req.getRequestDispatcher("/signin.jsp").forward(req, resp);
                }

            }else{
                req.setAttribute("error", "Invalid_e");
                req.getRequestDispatcher("/signin.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }
}
