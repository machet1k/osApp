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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link href="css/groundwork.css" type="text/css" rel="stylesheet">
        <!--link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"-->
        <link rel="icon" type="image/png" href="https://image.ibb.co/foupj6/favicon.png" sizes="16x16">
        <link rel="stylesheet" type="text/css" href="css/style.css">

    </head>
    <body>

        <%  // параметры для подключения к базе данных hrdb           
            String url = "jdbc:derby://localhost:1527/osdb";
            String username = "root";
            String password = "hermes";

            String from = String.valueOf(session.getAttribute("from"));
            String to = String.valueOf(session.getAttribute("to"));
            String line = String.valueOf(session.getAttribute("line"));
            /*String surname = String.valueOf(session.getAttribute("surname"));
            String name = String.valueOf(session.getAttribute("name"));*/
            String login = String.valueOf(session.getAttribute("login"));
            String city = String.valueOf(session.getAttribute("city"));
            String type = String.valueOf(session.getAttribute("type"));

            SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat vwFormat = new SimpleDateFormat("dd.MM.yyyy");

            // получение соединения с БД, расположенной по url, используя username/password     
            Connection connection = DriverManager.getConnection(url, username, password);
            Statement statement = connection.createStatement();
            String query = String.valueOf(request.getSession().getAttribute("queryForAdminPanel"));
            ResultSet rs = statement.executeQuery(query);
        %>

        <div class="containerDownload">
            <div class="row">
                <div class="panel panel-default">
                    <div id="download">
                        <form action="Download" method="Post" >
                            <div>&ensp;</div>

                            <% out.print("<div>Выгрузить с <input type='datetime-local' name='from' required value='" + from.replace(' ', 'T').substring(0, 16) + "'></div>"); %>

                            <% out.print("<div> по <input type='datetime-local' name='to' required value='" + to.replace(' ', 'T').substring(0, 16) + "'></div>"); %>

                            <%
                                if (!"null".equals(line)) out.print("<div>Номер линии<input type='text' name='line' placeholder='Все' value='" + line + "'></div>");
                                else out.print("<div>Номер линии<input type='text' name='line' placeholder='Все'></div>");
                                /*
                                if (!"null".equals(surname)) out.print("<div><input type='text' name='surname' placeholder='Фамилия' value='" + surname + "'></div>");
                                else out.print("<div><input type='text' name='surname' placeholder='Фамилия'></div>");
                                
                                if (!"null".equals(name)) out.print("<div><input type='text' name='name' placeholder='Имя' value='" + name + "'></div>");
                                else out.print("<div><input type='text' name='name' placeholder='Имя'></div>");
                                */
                            %>

                            <div>Город
                                <select class="gap-bottom" name="city">
                                    <%
                                        String[] arrCitySelected = new String[19];
                                        String null_city = "";

                                        for (int z = 0; z < arrCitySelected.length; z++) arrCitySelected[z] = "";
                                        
                                        if ("Санкт-Петербург".equals(city)) arrCitySelected[0] = "selected";
                                        else if ("Москва".equals(city)) arrCitySelected[1] = "selected";
                                        else if ("Воронеж".equals(city)) arrCitySelected[2] = "selected";
                                        else if ("Екатеринбург".equals(city)) arrCitySelected[3] = "selected";
                                        else if ("Иркутск".equals(city)) arrCitySelected[4] = "selected";
                                        else if ("КавМинВоды".equals(city)) arrCitySelected[5] = "selected";
                                        else if ("Казань".equals(city)) arrCitySelected[6] = "selected";
                                        else if ("Калининград".equals(city)) arrCitySelected[7] = "selected";
                                        else if ("Краснодар".equals(city)) arrCitySelected[8] = "selected";
                                        else if ("Красноярск".equals(city)) arrCitySelected[9] = "selected";
                                        else if ("Новосибирск".equals(city)) arrCitySelected[10] = "selected";
                                        else if ("Омск".equals(city)) arrCitySelected[11] = "selected";
                                        else if ("Пермь".equals(city)) arrCitySelected[12] = "selected";
                                        else if ("Петрозаводск".equals(city)) arrCitySelected[13] = "selected";
                                        else if ("Ростов-на-Дону".equals(city)) arrCitySelected[14] = "selected";
                                        else if ("Самара".equals(city)) arrCitySelected[15] = "selected";
                                        else if ("Тула".equals(city)) arrCitySelected[16] = "selected";
                                        else if ("Уфа".equals(city)) arrCitySelected[17] = "selected"; 
                                        else if ("Челябинск".equals(city)) arrCitySelected[18] = "selected";
                                        else null_city = "selected";
                                        
                                        String[] arrCity = {"Санкт-Петербург", "Москва", "Воронеж", "Екатеринбург", "Иркутск", "КавМинВоды", "Казань", "Калининград", "Краснодар", 
                                                            "Красноярск", "Новосибирск", "Омск", "Пермь", "Петрозаводск", "Ростов-на-Дону", "Самара", "Тула", "Уфа", "Челябинск"};
                                        
                                        out.print("<option " + null_city + " value='null'>Все</option>");
                                        for (int i = 0; i < arrCity.length; i++) {
                                            out.print("<option " + arrCitySelected[i] + " value='" + arrCity[i] + "'>" + arrCity[i] + "</option>");
                                        }
                                    %>
                                </select>
                            </div>


                            <div>Тип звонка
                                <select class="gap-bottom" name="type">
                                    <%

                                        String[] arrTypeSelected = new String[22];
                                        String null_type = "";

                                        for (int z = 0; z < arrTypeSelected.length; z++) {
                                            arrTypeSelected[z] = "";
                                        }

                                        if ("Заказ".equals(type)) arrTypeSelected[0] = "selected";
                                        else if ("Заказ с почты".equals(type)) arrTypeSelected[1] = "selected";
                                        else if ("Заказ с консультации".equals(type)) arrTypeSelected[2] = "selected";
                                        else if ("Консультация".equals(type)) arrTypeSelected[3] = "selected";
                                        else if ("Консультация с согласованием".equals(type)) arrTypeSelected[4] = "selected";
                                        else if ("Дорого".equals(type)) arrTypeSelected[5] = "selected";
                                        else if ("Корректировка".equals(type)) arrTypeSelected[6] = "selected";
                                        else if ("Доп.информация".equals(type)) arrTypeSelected[7] = "selected";
                                        else if ("Опоздание".equals(type)) arrTypeSelected[8] = "selected";
                                        else if ("Не можем предоставить".equals(type)) arrTypeSelected[9] = "selected";
                                        else if ("Снятие заказа".equals(type)) arrTypeSelected[10] = "selected";
                                        else if ("Отдел кадров".equals(type)) arrTypeSelected[11] = "selected";
                                        else if ("Перевод другому оператору".equals(type)) arrTypeSelected[12] = "selected";
                                        else if ("Перевод в КО".equals(type)) arrTypeSelected[13] = "selected";
                                        else if ("Перевод в ОКК / Жалоба".equals(type)) arrTypeSelected[14] = "selected";
                                        else if ("Ошиблись / Не по груз-кам".equals(type)) arrTypeSelected[15] = "selected";
                                        else if ("Проверка связи".equals(type)) arrTypeSelected[16] = "selected";
                                        else if ("Сорвался".equals(type)) arrTypeSelected[17] = "selected";
                                        else if ("Заказ (квартирный переезд)".equals(type)) arrTypeSelected[18] = "selected";
                                        else if ("Консульт. (квартирный переезд)".equals(type)) arrTypeSelected[19] = "selected";
                                        else if ("Заказ (офисный переезд)".equals(type)) arrTypeSelected[20] = "selected";
                                        else if ("Консульт. (офисный переезд)".equals(type)) arrTypeSelected[21] = "selected";
                                        else null_type = "selected";
                                        
                                        String[] arrCallsType = {"Заказ", "Заказ с почты", "Заказ с консультации", "Консультация", "Консультация с согласованием", "Дорого", "Корректировка", 
                                                    "Доп.информация", "Опоздание", "Не можем предоставить", "Снятие заказа", "Отдел кадров", "Перевод другому оператору", 
                                                    "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошиблись / Не по груз-кам", "Проверка связи", "Сорвался",
                                                    "Заказ (квартирный переезд)", "Консульт. (квартирный переезд)", "Заказ (офисный переезд)", "Консульт. (офисный переезд)"};
                                        
                                        out.print("<option " + null_type + " value='null'>Все</option>");
                                        
                                        for (int i = 0; i < arrCallsType.length; i++) {
                                            out.print("<option " + arrTypeSelected[i] + " value='" + arrCallsType[i] + "'>" + arrCallsType[i] + "</option>");
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="downloadbtn">
                                <button type="submit" class="btn btn-success">Выгрузить</button>
                                <!--button class="btn" onclick="this.form.reset();">Очистить</button-->
                            </div>
                            <a href="/os/sign-out">Выход [<% out.print(login); %>]</a>
                        </form>
                    </div> 

                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a data-toggle="tab" href="#panel1">Статистика</a>
                        </li>
                        <li>
                            <a data-toggle="tab" href="#panel2">Выгрузка</a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div id="panel1" class="tab-pane fade in active">
                            <%
                                // Статистика
                                Connection connection1 = DriverManager.getConnection(url, username, password);
                                Statement statement1 = connection1.createStatement();

                                String query1 = "select date(regtime) as date, calls_type, count(*) as count from calls where "
                                        + "regtime >= '" + from + "' and regtime <= '" + to + "' ";
                                if (!"null".equals(line)) query1 += "and line = '" + line + "' ";
                                /*if (!"null".equals(surname)) query1 += "and surname = '" + surname + "' ";
                                if (!"null".equals(name)) query1 += "and name = '" + name + "' ";*/
                                if (!"null".equals(city)) query1 += "and city = '" + city + "' ";
                                if (!"null".equals(type)) query1 += "and calls_type = '" + type + "' ";
                                query1 += "group by date(regtime), calls_type "
                                        + "order by date(regtime), calls_type";
                                System.out.println(query1);
                                ResultSet rs1 = statement1.executeQuery(query1);

                                // инициализация 
                                int lengthOfArrMap = (int) ((dbFormat.parse(to).getTime() - dbFormat.parse(from).getTime()) / (60 * 60 * 24 * 1000)) + 1;

                                HashMap[] arrMap = new HashMap[lengthOfArrMap];

                                for (int i = 0; i < lengthOfArrMap; i++) {
                                    arrMap[i] = new HashMap<String, Integer>();
                                }

                                // заполнение
                                int i = 0;
                                Date currentDate = null;
                                Date previousDate = null;
                                if (rs1.next()) {
                                    currentDate = dbFormat.parse(rs1.getString(1));
                                    
                                    int beginEmptyDays = (int)(currentDate.getTime() - dbFormat.parse(from).getTime()) / (60 * 60 * 24 * 1000);
                                    for (int day = 0; day < beginEmptyDays; day++) i++;
                                    
                                    arrMap[i].put(rs1.getString(2), rs1.getString(3));
                                }
                                while (rs1.next()) {
                                    previousDate = currentDate;
                                    currentDate = dbFormat.parse(rs1.getString(1));
                                    if (!currentDate.equals(previousDate)) {
                                        int emptyDays = (int)(currentDate.getTime() - previousDate.getTime()) / (60 * 60 * 24 * 1000);
                                        System.out.println(" КОЛИЧЕСТВО ПУСТЫХ ДНЕЙ " + emptyDays);
                                        for (int day = 0; day < emptyDays; day++) i++;
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
                                for (int ind = 0; ind < arrCallsType.length; ind++) {
                                    out.print("<tr><td>" + arrCallsType[ind] + "</td>");
                                    for (int j = 0; j < arrMap.length; j++) {
                                        if (arrMap[j].get(arrCallsType[ind]) != null) {
                                            out.print("<td>" + arrMap[j].get(arrCallsType[ind]) + "</td>");
                                        } else {
                                            out.print("<td>0</td>");
                                        }
                                    }
                                    out.print("</tr>");
                                }
                                out.print("</table>");

                            %>
                        </div>
                        <div id="panel2" class="tab-pane fade">
                            <table>
                                <tr>   
                                    <td>ID</td>
                                    <td>Время звонка</td>
                                    <td>Номер линии</td>
                                    <td>Фамилия</td>
                                    <td>Имя</td>
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
                                                + "<td>" + rs.getString(5) + "</td>"
                                                + "<td>" + rs.getString(6) + "</td>"
                                                + "<td>" + rs.getString(7) + "</td></tr>"
                                        );
                                    }

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

                                    request.getSession().setAttribute("line", null);
                                    /*request.getSession().setAttribute("name", null);
                                    request.getSession().setAttribute("surname", null);*/
                                    request.getSession().setAttribute("city", null);
                                    request.getSession().setAttribute("type", null);
                                %>
                            </table>
                        </div>
                    </div>        
                </div>
            </div> 
        </div>
    </div>                   
</body>
</html>