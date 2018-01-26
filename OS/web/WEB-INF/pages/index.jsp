<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Моя статистика</title>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link type="text/css" href="css/radio.css" rel="stylesheet"> 
        <link rel="icon" type="image/png" href="https://image.ibb.co/foupj6/favicon.png" sizes="16x16">
    </head>
    <body>
        <form action="Call" method="post">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a href="/os/sign-out">Выход [<% out.print(session.getAttribute("login")); %>]</a>
                </div>
                <div class="panel-body scalable">
                    <div class="section">
                        <div class="selection"><input id="city1" required type="radio" class="radio" name="city" value="Санкт-Петербург"/>
                            <label for="city1" style="border-radius: 6px">Санкт-Петербург</label>
                        </div>
                        <div class="selection"><input id="city2" required type="radio" class="radio" name="city" value="Москва"/>
                            <label for="city2" style="border-radius: 6px">Москва</label>
                        </div>
                    </div>
                </div>
                <div class="panel-heading">
                    <input type="submit" value="Отправить" class="btn btn-warning"/>
                </div>
                <div class="panel-body scalable">
                    <div class="section">
                        <% 
                            String url = "jdbc:derby://localhost:1527/osdb";
                            String username = "root";
                            String password = "hermes";

                            String[] arrCallsType = {"Заказ", "Заказ с почты", "Заказ с консультации", "Консультация", "Консультация с согласованием", "Дорого", "Корректировка", 
                                                    "Доп.информация", "Опоздание", "Не можем предоставить", "Снятие заказа", "Отдел кадров", "Перевод другому оператору", 
                                                    "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошиблись / Не по груз-кам", "Проверка связи", "Сорвался",
                                                    "Заказ (квартирный переезд)", "Консульт. (квартирный переезд)", "Заказ (офисный переезд)", "Консульт. (офисный переезд)"}; 

                            for (int i = 0; i < arrCallsType.length; i++) {
                                out.print("<div class='selection'>"
                                        + "<input id='type" + i + "' required type='radio' class='radio' name='callsType' value='" + arrCallsType[i] + "'/>"
                                        + "<label for='type" + i + "'>" + arrCallsType[i] + "</label><div class='count4op'>");
                                
                                Connection connection = DriverManager.getConnection(url, username, password);
                                Statement statement = connection.createStatement();
                                String query = "select count(*) from calls where date(regtime) = CURRENT_DATE"
                                             + " and line = '" + session.getAttribute("login") + "'"
                                             + " and CALLS_TYPE = '" + arrCallsType[i] + "'";
                                ResultSet rs = statement.executeQuery(query);                            
                                rs.next();
                                out.print(rs.getString(1) + "</div></div>");
                            }
                        %>
                    </div>
                </div>
            </div> 
        </form>
    </body>
</html>