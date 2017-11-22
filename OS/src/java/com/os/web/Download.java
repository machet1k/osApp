package com.os.web;

import com.os.core.AbstractServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Download")
public class Download extends AbstractServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String query, from, to, city, type;

        from = request.getParameter("from");
        to = request.getParameter("to");
        city = request.getParameter("city");
        type = request.getParameter("type");

        if (from != null && !"null".equals(from)) request.getSession().setAttribute("from", from);
        if (to != null && !"null".equals(to)) request.getSession().setAttribute("to", to);
        
        query = "select * from calls where date(regtime) >= '" 
                + from + "' and date(regtime) <= '" + to + "'";
        
        if (city != null && !"null".equals(city)) {
            request.getSession().setAttribute("city", city);
            query += " and city = '" + city + "'"; 
        }
        if (type != null && !"null".equals(type)) {
            request.getSession().setAttribute("type", type);
            query += " and calls_type = '" + type + "'";  
        }
  
        request.getSession().setAttribute("queryForAdminPanel", query);

        if (!isUserAuthenticated()) redirect("/os/sign-in");
        else forward("/adminpanel.jsp");
        
    }
}