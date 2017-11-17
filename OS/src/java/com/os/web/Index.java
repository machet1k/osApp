package com.os.web;

import com.os.core.AbstractServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

@WebServlet("")
public class Index extends AbstractServlet {

    private boolean isUserAuthenticated() {
        Object isAuth = getSession().getAttribute("isAuth");
        return isAuth instanceof Boolean && (Boolean) isAuth;
    }
    
    @Override
    protected void doGet(String address) throws ServletException, IOException {
        if (!isUserAuthenticated()) redirect("/os/sign-in");
        else {
            getResponse().setHeader("Cache-Control", "no-cache");
            if (getSession().getAttribute("line").equals("admin")) forward("/adminpanel.jsp");
            else forward("/index.jsp");
        }
    }
}
