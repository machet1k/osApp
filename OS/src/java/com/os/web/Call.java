package com.os.web;

import com.os.core.AbstractServlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Call")
public class Call extends AbstractServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String line = String.valueOf(request.getSession().getAttribute("line"));
        String city = request.getParameter("city");
        String type = request.getParameter("callsType");
        
        String url = "jdbc:derby://localhost:1527/osdb";
        String username = "root";
        String password = "hermes";

        String query = "insert into calls(line, city, calls_type) values('" + line + "', '" + city + "', '" + type + "')";

        System.out.println(query);
        
        if (!isUserAuthenticated()) redirect("/os/sign-in");
        else {    
            try (Connection connection = DriverManager.getConnection(url, username, password);
                Statement statement = connection.createStatement();) {
                    statement.executeUpdate(query);
                } catch (SQLException e) { e.printStackTrace(); }
            redirect("/os/");
        }
    }
}