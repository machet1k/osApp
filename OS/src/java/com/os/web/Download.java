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

        String query, from, to, city, calls_type, line, add_func, cost, load_capacity;

        from = request.getParameter("from").replace('T', ' ').concat(":00");
        to = request.getParameter("to").replace('T', ' ').concat(":59");
        city = request.getParameter("city");
        calls_type = request.getParameter("calls_type");
        line = request.getParameter("line");
        
        add_func = request.getParameter("add_func"); 
        cost = request.getParameter("cost"); 
        load_capacity = request.getParameter("load_capacity"); 
        

        if (from != null && !"null".equals(from)) request.getSession().setAttribute("from", from);
        if (to != null && !"null".equals(to)) request.getSession().setAttribute("to", to);
        
        query = "select calls.id, regtime, line, surname, name, city, calls_type, add_func, cost, load_capacity from calls left outer join users on calls.LINE = users.LOGIN where regtime >= '" 
                + from + "' and regtime <= '" + to + "'";
        
        if (city != null && !"null".equals(city)) {
            request.getSession().setAttribute("city", city);
            query += " and city = '" + city + "'"; 
        }
        if (line != null && !"".equals(line)) {
            request.getSession().setAttribute("line", line);
            query += " and line = '" + line + "'";  
        }
        if (add_func != null && !"".equals(add_func) && !"null".equals(add_func)) {
            request.getSession().setAttribute("add_func", add_func);
            query += " and add_func = '" + add_func + "'";  
        }
        if (cost != null && !"".equals(cost)) {
            request.getSession().setAttribute("cost", cost);
            query += " and cost = '" + cost + "'";  
        }
        if (load_capacity != null && !"".equals(load_capacity)) {
            request.getSession().setAttribute("load_capacity", load_capacity);
            query += " and load_capacity = '" + load_capacity + "'";  
        }
        
        request.getSession().setAttribute("queryForAdminPanel", query);
        System.out.println("DOWNLOAD: " + query);
        
        if (!isUserAuthenticated()) redirect("/os/sign-in");
        else forward("/adminpanel.jsp");
        
    }
}