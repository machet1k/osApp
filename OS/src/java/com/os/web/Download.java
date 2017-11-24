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

        String query, from, to, city, type, line, surname, name;

        from = request.getParameter("from");
        to = request.getParameter("to");
        city = request.getParameter("city");
        type = request.getParameter("type");
        line = request.getParameter("line");
        surname = request.getParameter("surname");
        name = request.getParameter("name");

        if (from != null && !"null".equals(from)) request.getSession().setAttribute("from", from);
        if (to != null && !"null".equals(to)) request.getSession().setAttribute("to", to);
        
        query = "select calls.id, regtime, line, surname, name, city, calls_type from calls left outer join users on calls.LINE = users.LOGIN where date(regtime) >= '" 
                + from + "' and date(regtime) <= '" + to + "'";
        
        if (city != null && !"null".equals(city)) {
            request.getSession().setAttribute("city", city);
            query += " and city = '" + city + "'"; 
        }
        if (type != null && !"null".equals(type)) {
            request.getSession().setAttribute("type", type);
            query += " and calls_type = '" + type + "'";  
        }
        if (line != null && !"".equals(line)) {
            request.getSession().setAttribute("line", line);
            query += " and line = '" + line + "'";  
        }
        if (surname != null && !"".equals(surname)) {
            request.getSession().setAttribute("surname", surname);
            query += " and surname = '" + surname + "'";  
        }
        if (name != null && !"".equals(name)) {
            request.getSession().setAttribute("name", name);
            query += " and name = '" + name + "'";  
        }
        
  
        request.getSession().setAttribute("queryForAdminPanel", query);
        System.out.println("Download: " + query);
        
        if (!isUserAuthenticated()) redirect("/os/sign-in");
        else forward("/adminpanel.jsp");
        
    }
}