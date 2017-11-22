<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.lang.String"%>
<%@page import="java.lang.String"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.os.web.Authentication"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet;"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalDate;"%>
<%@page import="java.time.format.DateTimeFormatter;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Результаты выгрузки</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/groundwork.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="icon" type="image/x-icon" href="http://savepic.ru/14659608.png"/>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>

        <%  // параметры для подключения к базе данных hrdb           
            String url = "jdbc:derby://localhost:1527/osdb";
            String username = "root";
            String password = "hermes";
            
            String from = String.valueOf(session.getAttribute("from"));
            String to = String.valueOf(session.getAttribute("to"));
            String city = String.valueOf(session.getAttribute("city"));
            
            SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat vwFormat = new SimpleDateFormat("dd.MM.yyyy");
                        
            // получение соединения с БД, расположенной по url, используя username/password     
            Connection connection = DriverManager.getConnection(url, username, password);
            Statement statement = connection.createStatement();
            String query = String.valueOf(request.getSession().getAttribute("queryForAdminPanel"));
            ResultSet rs = statement.executeQuery(query); 
            System.out.println(">>> " + query);
        %>

        <div class="containerDownload">
            <div class="row">
                <div class="panel panel-default">
                    <div id="download">
                        <form action="Download" method="Post">
                            <div>&ensp;</div>
                            <div>Выгрузить с </div>
                            <% out.print("<div><input type='date' name='from' required value='" + from + "'></div>"); %>

                            <div>по</div>
                            <% out.print("<div><input type='date' name='to' required value='" + to + "'></div>"); %>

                            <div>
                                <select class="gap-bottom" name="city">
                                    <%
                                        
                                        String[] arrCity = new String[8]; 
                                        String null_city = "";
                                       
                                        for (int z = 0; z < arrCity.length; z++) arrCity[z] = ""; 
                                        
                                        if ("Санкт-Петербург".equals(city))     { arrCity[0] = "selected";}
                                        else if ("Москва".equals(city))         { arrCity[1] = "selected";}
                                        else if ("Ростов-на-Дону".equals(city)) { arrCity[2] = "selected";}
                                        else if ("Калининград".equals(city))    { arrCity[3] = "selected";}
                                        else if ("Воронеж".equals(city))        { arrCity[4] = "selected";}
                                        else if ("Новосибирск".equals(city))    { arrCity[5] = "selected";}
                                        else if ("Пермь".equals(city))          { arrCity[6] = "selected";}
                                        else if ("Омск".equals(city))           { arrCity[7] = "selected";}
                                        else { null_city = "city";}
                                        out.print(
                                          "<option " + null_city + " value='null'>Все</option>"
                                        + "<option " + arrCity[0] + " value='Санкт-Петербург'>Санкт-Петербург</option>"
                                        + "<option " + arrCity[1] + " value='Москва'>Москва</option>"
                                        + "<option " + arrCity[2] + " value='Ростов-на-Дону'>Ростов-на-Дону</option>"
                                        + "<option " + arrCity[3] + " value='Калининград'>Калининград</option>"
                                        + "<option " + arrCity[4] + " value='Воронеж'>Воронеж</option>"
                                        + "<option " + arrCity[5] + " value='Новосибирск'>Новосибирск</option>"
                                        + "<option " + arrCity[6] + " value='Пермь'>Пермь</option>"
                                        + "<option " + arrCity[7] + " value='Омск'>Омск</option>"); %>
                                </select>
                            </div>
                                
                                
                                <div>
                                <select class="gap-bottom" name="type">
                                    <%
                                        
                                        String[] arrType = new String[15]; 
                                        String null_type = "";
                                        String type = String.valueOf(session.getAttribute("type"));
                                        
                                        for (int z = 0; z < arrType.length; z++) arrType[z] = ""; 
                                        
                                        if ("Заказ".equals(type))               { arrType[0] = "selected";}
                                        else if ("Консультация".equals(type))         { arrType[1] = "selected";}
                                        else if ("Дорого".equals(type)) { arrType[2] = "selected";}
                                        else if ("Корректировка".equals(type))    { arrType[3] = "selected";}
                                        else if ("Доп.информация".equals(type))        { arrType[4] = "selected";}
                                        else if ("Опоздание".equals(type))    { arrType[5] = "selected";}
                                        else if ("Не можем предоставить".equals(type))          { arrType[6] = "selected";}
                                        else if ("Снятие заказа".equals(type))           { arrType[7] = "selected";}
                                        else if ("Отдел кадров".equals(type))           { arrType[8] = "selected";}
                                        else if ("Перевод другому оператору".equals(type))           { arrType[9] = "selected";}
                                        else if ("Перевод в КО".equals(type))           { arrType[10] = "selected";}
                                        else if ("Перевод в ОКК / Жалоба".equals(type))           { arrType[11] = "selected";}
                                        else if ("Ошибся номером / Не по груз-кам".equals(type))           { arrType[12] = "selected";}
                                        else if ("Проверка связи".equals(type))           { arrType[13] = "selected";}
                                        else if ("Сорвался".equals(type))           { arrType[14] = "selected";}
                                        else { null_type = "type";}
                                        out.print(
                                          "<option " + null_type + " value='null'>Все</option>"
                                        + "<option " + arrType[0] + " value='Заказ'>Заказ</option>"
                                        + "<option " + arrType[1] + " value='Консультация'>Консультация</option>"
                                        + "<option " + arrType[2] + " value='Дорого'>Дорого</option>"
                                        + "<option " + arrType[3] + " value='Корректировка'>Корректировка</option>"
                                        + "<option " + arrType[4] + " value='Доп.информация'>Доп.информация</option>"
                                        + "<option " + arrType[5] + " value='Опоздание'>Опоздание</option>"
                                        + "<option " + arrType[6] + " value='Не можем предоставить'>Не можем предоставить</option>"
                                        + "<option " + arrType[7] + " value='Снятие заказа'>Снятие заказа</option>"
                                        + "<option " + arrType[8] + " value='Отдел кадров'>Отдел кадров</option>"
                                        + "<option " + arrType[9] + " value='Перевод другому оператору'>Перевод другому оператору</option>"
                                        + "<option " + arrType[10] + " value='Перевод в КО'>Перевод в КО</option>"
                                        + "<option " + arrType[11] + " value='Перевод в ОКК / Жалоба'>Перевод в ОКК / Жалоба</option>"
                                        + "<option " + arrType[12] + " value='Ошибся номером / Не по груз-кам'>Ошибся номером / Не по груз-кам</option>"
                                        + "<option " + arrType[13] + " value='Проверка связи'>Проверка связи</option>"
                                        + "<option " + arrType[14] + " value='Сорвался'>Сорвался</option>"); %>
                                </select>
                            </div>
                                
                                
                            <% 
                                request.getSession().setAttribute("city", null);
                                request.getSession().setAttribute("type", null);
                            %>
                            <div class="downloadbtn">
                                <button type="submit" class="btn btn-success">Выгрузить</button>
                                <button class="btn" onclick="this.form.reset();">Очистить</button>
                                <a href="/os/sign-out">Выход [<% out.print(session.getAttribute("line")); %>]</a>
                            </div>
                        </form>
                    </div> 

                    <div class="panel-heading">Результаты выгрузки</div>
                    <div class="panel-body">
                        <table>
                            <tr>   
                                <td>ID</td>
                                <td>Время звонка</td>
                                <td>Номер линии</td>
                                <td>Город</td>
                                <td>Тип звонка</td>
                            </tr>
                            
                            <%    
                                while (rs.next()) {
                                    out.print("<tr>"
                                        + "<td>" + rs.getString(1) + "</td>"
                                        + "<td>" + rs.getString(2) + "</td>"
                                        + "<td>" + rs.getString(3) + "</td>"
                                        + "<td>" + rs.getString(4) + "</td>"
                                        + "<td>" + rs.getString(5) + "</td></tr>"
                                    ); 
                                }
                                out.print("</table>");
                            %>
                    </div>
                    <div class="panel-heading">Статистика</div>
                    <div class="panel-body">

<%
    
    // Статистика
    Connection connection1 = DriverManager.getConnection(url, username, password);
    Statement statement1 = connection1.createStatement();
 
    String query1 = "select date(regtime) as date, calls_type, count(*) as count from calls where "
            + "date(regtime) >= '" + from + "' and date(regtime) <= '" + to + "' ";
    if (!"null".equals(city)) query1 += "and city = '" + city + "' ";
    query1 += "group by date(regtime), calls_type "
            + "order by date(regtime), calls_type";
    System.out.println(query1);
    ResultSet rs1 = statement1.executeQuery(query1); 

    //String[] arrCitys = {"Санкт-Петербург", "Москва", "Ростов-на-Дону", "Калининград", "Воронеж", "Новосибирск", "Пермь", "Омск"};
    String[] arrTypes = {"Заказ", "Заказ с почты", "Заказ с консультации", "Консультация", "Консультация с согласованием", "Дорого", "Корректировка", "Доп.информация", "Опоздание", "Не можем предоставить", "Снятие заказа", "Отдел кадров", "Перевод другому оператору", "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошибся номером / Не по груз-кам", "Проверка связи", "Сорвался"};
    
    // инициализация 
    int lengthOfArrMap = (int)((dbFormat.parse(to).getTime() - dbFormat.parse(from).getTime()) / (60 * 60 * 24 * 1000)) + 1;
    
    HashMap[] arrMap = new HashMap[lengthOfArrMap];
    
    for (int i = 0; i < lengthOfArrMap; i++) arrMap[i] = new HashMap<String, Integer>();

    // заполнение
    int i = 0;
    String currentDate = "";
    String previousDate = "";
    if (rs1.next()) {
        currentDate = rs1.getString(1);
        arrMap[i].put(rs1.getString(2), rs1.getString(3));
    }
    while (rs1.next()) {
        previousDate = currentDate;
        currentDate = rs1.getString(1);
        if (!currentDate.equals(previousDate)) {
            i++;
        }
        arrMap[i].put(rs1.getString(2), rs1.getString(3));
    }



    out.print("<table><tr><td>Тип</td>");
    
    Date firstDay = dbFormat.parse(from);
    
    // 1st line
    while (lengthOfArrMap-- > 0) {      
        out.print("<td>" + vwFormat.format(firstDay) + "</td>");
        firstDay.setDate(firstDay.getDate() + 1);
    }
    out.print("</tr>");
    // data
    for (int ind = 0; ind < arrTypes.length; ind++) {
        out.print("<tr><td>" + arrTypes[ind] + "</td>");
            for (int j = 0; j < arrMap.length; j++) {
                if (arrMap[j].get(arrTypes[ind]) != null) out.print("<td>" + arrMap[j].get(arrTypes[ind]) + "</td>");
                else out.print("<td>0</td>");
            }
        out.print("</tr>");
    }
    out.print("</table>");

                                connection.close();
                                connection = null;
                                statement.close();
                                statement = null;
                                rs.close();
                                rs = null;

                                connection1.close();
                                connection1 = null;
                                statement1.close();
                                statement1 = null;
                                rs1.close();
                                rs1 = null;
                            %>
                            
                        </table>
                    </div>
                </div> 
            </div>
        </div> 
    </body>
</html>
