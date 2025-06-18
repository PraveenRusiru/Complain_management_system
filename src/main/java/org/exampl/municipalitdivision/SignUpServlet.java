package org.exampl.municipalitdivision;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.exampl.municipalitdivision.DAO.SignUpDao;
import org.exampl.municipalitdivision.DTO.SignUpDTO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("post method loaded");
        ServletContext context = getServletContext();
        BasicDataSource basicDataSource=(BasicDataSource)context.getAttribute("basicDataSource");
        SignUpDao signUpDao= null;
        try {
            signUpDao = new SignUpDao(basicDataSource);
            String username=req.getParameter("username");
            String password=req.getParameter("password");
            String email=req.getParameter("email");
            String id=signUpDao.getNextId();
            List<SignUpDTO> allUsers = signUpDao.getAllUsers();
            boolean isemailLasting = allUsers.stream().anyMatch(emails -> emails.getEmail().matches(email));
            System.out.println("Isemail "+isemailLasting);
            boolean isusernameLasting = allUsers.stream().anyMatch(userNames -> userNames.getUserName().matches(username));
            System.out.println("isusernameLasting "+isusernameLasting);
            SignUpDTO signUpDTO=new SignUpDTO(id,username,email,password);
            boolean usersignup=false;
            if(!(isemailLasting||isusernameLasting)){
                 usersignup= signUpDao.usersignup(signUpDTO);
            }
            System.out.println("signup "+usersignup );
            if(isemailLasting){
                 req.setAttribute("error","Ealready_taken");
//                 req.getRequestDispatcher("/MunicipalITDivision_war_exploded/signup.jsp").forward(req, resp);
            }
            if(isusernameLasting){
                req.setAttribute("error","UNalready_taken");
//                req.getRequestDispatcher("/MunicipalITDivision_war_exploded/signup.jsp").forward(req, resp);
            }
            if(usersignup ){
                req.setAttribute("error","Success");
                resp.sendRedirect("/MunicipalITDivision_war_exploded/signin.jsp");
            }else{
//                req.setAttribute("error","went_wrong");
                System.out.println("went_wrong");
                req.getRequestDispatcher("/signup.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }


//        SignUpDTO signUpDTO=new SignUpDTO()
    }
}
