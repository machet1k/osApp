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
            String login = String.valueOf(session.getAttribute("login"));
            String city = String.valueOf(session.getAttribute("city"));
            String calls_type = String.valueOf(session.getAttribute("calls_type"));

            String add_func = String.valueOf(session.getAttribute("add_func"));
            String cost = String.valueOf(session.getAttribute("cost"));
            String load_capacity = String.valueOf(session.getAttribute("load_capacity"));

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

                                        for (int z = 0; z < arrCitySelected.length; z++) arrCitySelected[z] = "";

                                        String[] arrCity = {"Санкт-Петербург", "Москва", "Воронеж", "Екатеринбург", "Иркутск", "КавМинВоды", "Казань", "Калининград", "Краснодар", 
                                                            "Красноярск", "Новосибирск", "Омск", "Пермь", "Петрозаводск", "Ростов-на-Дону", "Самара", "Тула", "Уфа", "Челябинск"};
                                        
                                        out.print("<option value='null'>Все</option>");
                                        for (int i = 0; i < arrCity.length; i++) {
                                            if (arrCity[i].equals(city)) arrCitySelected[i] = "selected";
                                            out.print("<option " + arrCitySelected[i] + " value='" + arrCity[i] + "'>" + arrCity[i] + "</option>");
                                        }
                                    %>
                                </select>
                            </div>
                            <div>Функционал
                                <select class="gap-bottom" name="add_func">
                                    <%
                                        String[] arrAddFuncSelected = new String[22];

                                        for (int z = 0; z < arrAddFuncSelected.length; z++) {
                                            arrAddFuncSelected[z] = "";
                                        }

                                        String[] arrAddFunc = {"Линия", "Большегрузы", "VIP линия", "Эвакуаторы", "Транспортная компания", "Сборный груз", "Чат отдела продаж", "Консультации", "Жалобы"};

                                        out.print("<option value='null'>Все</option>");
                                        for (int i = 0; i < arrAddFunc.length; i++) {
                                            if (arrAddFunc[i].equals(add_func)) arrAddFuncSelected[i] = "selected";
                                            out.print("<option " + arrAddFuncSelected[i] + " value='" + arrAddFunc[i] + "'>" + arrAddFunc[i] + "</option>");
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
                                if (!"null".equals(city)) query1 += "and city = '" + city + "' ";
                                if (!"null".equals(calls_type)) query1 += "and calls_type = '" + calls_type + "' ";
                                if (!"null".equals(add_func)) query1 += "and add_func = '" + add_func + "' ";
                                if (!"null".equals(cost)) query1 += "and cost = '" + cost + "' ";
                                if (!"null".equals(load_capacity)) query1 += "and load_capacity = '" + load_capacity + "' ";
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
                                
                                Map<String, String[]> mapCallsType = new HashMap<String, String[]>();

                                mapCallsType.put("Линия", new String[]{"Заказ", "Заказ с почты", "Заказ с консультации", "Консультация", "Консультация с согласованием", "Дорого", "Корректировка", "Доп.информация", "Опоздание", "Не можем предоставить", "Снятие заказа", "Отдел кадров", "Перевод другому оператору", "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошиблись / Не по груз-кам", "Проверка связи", "Сорвался", "Заказ (квартирный переезд)", "Консульт. (квартирный переезд)", "Заказ (офисный переезд)", "Консульт. (офисный переезд)"});
                                mapCallsType.put("Большегрузы", new String[]{"Заказ", "Отказ", "Консультация", "Ждёт звонка", "Нет машин на запрошенное время", "По ПДД не можем предоставить", "Дорого", "Узнавал цену, мониторинг", "Не отвечает", "Уже не актуально", "Просил перезвонить", "Ждёт ответа из ТО"});
                                mapCallsType.put("VIP линия", new String[]{"Заказ", "Консультация", "Дорого", "Запрос на автобусы", "Запрос на сборный груз", "Запрос на аренду ПУХТО", "Корректировка", "Доп.информация", "Опоздание", "Жалоба", "Не можем предоставить", "Передано другому оператору", "Сорвался", "Перевод в отдел кадров","Перевод в КО", "Перевод в ОКК", "Перевод в такси", "Ошиблись / Не по груз-кам", "Проверка связи"});    
                                mapCallsType.put("Эвакуаторы", new String[]{"Заказ", "Консультация", "Дорого", "Не можем предоставить", "Передано другому оператору", "Другое"});
                                mapCallsType.put("Транспортная компания", new String[]{"Заказ", "Консультация", "Дорого", "Запрос на автобусы", "Запрос на сборный груз", "Запрос на аренду ПУХТО", "Корректировка", "Доп.информация", "Опоздание", "Жалоба", "Не можем предоставить", "Передано другому оператору", "Сорвался", "Перевод в отдел кадров","Перевод в КО", "Перевод в ОКК", "Перевод в такси", "Ошиблись / Не по груз-кам", "Проверка связи"});
                                mapCallsType.put("Сборный груз", new String[]{"Заказ", "Консультация", "Дорого", "Не сборный груз", "Нет ответа", "Нет ответа", "Не сможем предоставить", "Изменение заказа", "Не актуально"});
                                mapCallsType.put("Чат отдела продаж", new String[]{"Заказ", "Консультация", "Дорого", "Запрос на сборный груз", "Корректировка", "Доп.информация", "Не можем предоставить", "Передано другому оператору", "Другое"});
                                mapCallsType.put("Консультации", new String[]{"Заказ", "Просил перезвонить", "Уже не интересует", "Не берёт трубку", "Дорого", "Скидка не нужна", "Переехали с нами", "Переехали сами", "Конкуренты", "Сами перезвонят", "Другое"});
                                mapCallsType.put("Жалобы", new String[]{"Жалоба на оператора", "Жалоба на экипаж", "Опоздание", "Внести изменения в заказ", "Пересчёт", "Неверный тип авто", "Нарушение ПДД", "Не согласен с доп.часами", "Проверка номера телефона", "Не согласен со стоимостью", "Проверка стоимости заказа", "Данные", "Неверная дата", "Заказ с сайта", "Онлайн оплата", "Перегородил дорогу", "Сломался/замена авто", "Порча груза", "Другое"});
                                mapCallsType.put("null", new String[]{"Заказ", "Заказ с почты", "Заказ с консультации", "Консультация", "Консультация с согласованием", "Дорого", "Корректировка", "Доп.информация", "Опоздание", "Не можем предоставить", "Снятие заказа", "Отдел кадров", "Перевод другому оператору", "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошиблись / Не по груз-кам", "Проверка связи", "Сорвался", "Заказ (квартирный переезд)", "Консульт. (квартирный переезд)", "Заказ (офисный переезд)", "Консульт. (офисный переезд)", "Отказ", "Ждёт звонка", "Нет машин на запрошенное время", "По ПДД не можем предоставить", "Узнавал цену, мониторинг", "Не отвечает", "Уже не актуально", "Просил перезвонить", "Ждёт ответа из ТО", "Запрос на автобусы", "Запрос на сборный груз", "Запрос на аренду ПУХТО", "Жалоба", "Передано другому оператору", "Перевод в отдел кадров", "Перевод в ОКК", "Перевод в такси", "Другое", "Не сборный груз", "Нет ответа", "Не сможем предоставить", "Изменение заказа", "Не актуально", "Уже не интересует", "Не берёт трубку", "Скидка не нужна", "Переехали с нами", "Переехали сами", "Конкуренты", "Сами перезвонят", "Жалоба на оператора", "Жалоба на экипаж", "Внести изменения в заказ", "Пересчёт", "Неверный тип авто", "Нарушение ПДД", "Не согласен с доп.часами", "Проверка номера телефона", "Не согласен со стоимостью", "Проверка стоимости заказа", "Данные", "Неверная дата", "Заказ с сайта", "Онлайн оплата", "Перегородил дорогу", "Сломался/замена авто", "Порча груза"});
                                // data
                                /*String[] arrCallsType = {"Заказ", "Заказ с почты", "Заказ с консультации", "Консультация", "Консультация с согласованием", "Дорого", "Корректировка", 
                                                    "Доп.информация", "Опоздание", "Не можем предоставить", "Снятие заказа", "Отдел кадров", "Перевод другому оператору", 
                                                    "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошиблись / Не по груз-кам", "Проверка связи", "Сорвался",
                                                    "Заказ (квартирный переезд)", "Консульт. (квартирный переезд)", "Заказ (офисный переезд)", "Консульт. (офисный переезд)"};*/
                                
                                for (int ind = 0; ind < mapCallsType.get(add_func).length; ind++) { // 
                                    out.print("<tr><td>" + mapCallsType.get(add_func)[ind] + "</td>");
                                    for (int j = 0; j < arrMap.length; j++) {
                                        if (arrMap[j].get(mapCallsType.get(add_func)[ind]) != null) {
                                            out.print("<td>" + arrMap[j].get(mapCallsType.get(add_func)[ind]) + "</td>");
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
                                    <td>Функционал</td>
                                    <td>Стоимость заказа</td>
                                    <td>Грузоподъёмность</td>
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
                                                + "<td>" + rs.getString(7) + "</td>"
                                                + "<td>" + rs.getString(8) + "</td>");
                                        if (rs.getString(9) == null) out.print("<td>–</td>"); else out.print("<td>" + rs.getString(9) + "</td>");
                                        if (rs.getString(10) == null) out.print("<td>–</td>"); else out.print("<td>" + rs.getString(10) + "</td>");
                                        out.print("</tr>");
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
                                    request.getSession().setAttribute("city", null);
                                    request.getSession().setAttribute("calls_type", null);
                                    request.getSession().setAttribute("add_func", null);
                                    request.getSession().setAttribute("cost", null);
                                    request.getSession().setAttribute("load_capacity", null);
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