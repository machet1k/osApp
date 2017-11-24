package com.os.web;

import com.os.core.AbstractServlet;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("")
public class Index extends AbstractServlet {
  
    @Override
    protected void doGet(String address) throws ServletException, IOException {
        
        String login = String.valueOf(getSession().getAttribute("login"));
        String department = String.valueOf(getSession().getAttribute("department"));
                
        SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date today = new Date();
        String vwToday = dbFormat.format(today);
        getSession().setAttribute("from", vwToday);
        getSession().setAttribute("to", vwToday);
        
        if (!isUserAuthenticated()) redirect("/os/sign-in");
        else {
            getResponse().setHeader("Cache-Control", "no-cache");
            if (login.equals("admin")) forward("/adminpanel.jsp");
            else if (department.equals("Грузовичкоф")) forward("/index.jsp");
            else if (department.equals("Франшиза")) forward("/indexFranchise.jsp");
        }
    }
}
