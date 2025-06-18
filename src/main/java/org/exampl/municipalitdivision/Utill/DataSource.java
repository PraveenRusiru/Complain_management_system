package org.exampl.municipalitdivision.Utill;


import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.SQLException;

@WebListener
public class DataSource implements ServletContextListener {
  public   BasicDataSource basicDataSource;
    public DataSource(){
        basicDataSource = new BasicDataSource();
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        basicDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        basicDataSource.setUrl("jdbc:mysql://localhost:3306/complain_management_system_db");
        basicDataSource.setUsername("root");
        basicDataSource.setPassword("12345678");
        basicDataSource.setInitialSize(5);
        basicDataSource.setMaxTotal(50);
        ServletContext servletContext = sce.getServletContext();
        servletContext.setAttribute("basicDataSource", basicDataSource);

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            basicDataSource.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }
}
