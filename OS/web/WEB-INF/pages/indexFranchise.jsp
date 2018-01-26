<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Моя статистика</title>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link type="text/css" href="css/radio.css" rel="stylesheet"> 
        <link rel="icon" type="image/png" href="https://image.ibb.co/foupj6/favicon.png" sizes="16x16">
        <script>
            function openGoogleSheets() {   
                var url = 'https://docs.google.com/spreadsheets/d/1rZexWecRn18b1fbe5n2zxpinYUN2LooQOaSEg4RimiU/edit#gid=';
                var inputCity = document.getElementsByName('city');
                for (var i = 0; i < inputCity.length; i++) {
                    if (inputCity[i].checked) {
                        switch(inputCity[i].value) {
                            case 'Воронеж':         window.open(url + '2077988195','_blank'); break;
                            case 'Екатеринбург':    window.open(url + '953498647','_blank'); break;
                            case 'Иркутск':         window.open(url + '1198470323','_blank'); break;
                            case 'КавМинВоды':      window.open(url + '103960902','_blank'); break;
                            case 'Казань':          window.open(url + '12349804','_blank'); break;
                            case 'Калининград':     window.open(url + '0','_blank'); break;
                            case 'Краснодар':       window.open(url + '1130996085','_blank'); break;
                            case 'Красноярск':      window.open(url + '1700069813','_blank'); break;
                            case 'Новосибирск':     window.open(url + '789351977','_blank'); break;
                            case 'Омск':            window.open(url + '1618236176','_blank'); break;
                            case 'Пермь':           window.open(url + '917323755','_blank'); break;
                            case 'Петрозаводск':    window.open(url + '299878661','_blank'); break;
                            case 'Ростов-на-Дону':  window.open(url + '1518385768','_blank'); break;
                            case 'Самара':          window.open(url + '850527098','_blank'); break;
                            case 'Челябинск':       window.open(url + '846071204','_blank'); break;
                            case 'Тула':            window.open(url + '1217754603','_blank'); break;
                            case 'Уфа':             window.open(url + '2049020649','_blank'); break;
                            default: ; break;
                        }
                    }
                }
            }
        </script>
    </head>
    <body>
        <form action="Call" method="post" id="form_id">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a href="/os/sign-out">Выход [<% out.print(session.getAttribute("login")); %>]</a>
                </div>
                <div class="panel-body scalable">
                    <div class="section">
                        <%
                            String[] arrCity = {"Воронеж", "Екатеринбург", "Иркутск", "КавМинВоды", "Казань", "Калининград", "Краснодар", "Красноярск", "Новосибирск", 
                                                "Омск", "Пермь", "Петрозаводск", "Ростов-на-Дону", "Самара", "Тула", "Уфа", "Челябинск"};
                            for (int i = 0; i < arrCity.length; i++) {    
                                out.print("<div class='selection'><input id='city" + i + "' required='required' type='radio' class='radio' name='city' "
                                        + "value='" + arrCity[i] + "'/><label for='city" + i + "' style='border-radius: 6px'>" + arrCity[i] + "</label></div>");
                            }
                        %>
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
                                                    "Перевод в КО", "Перевод в ОКК / Жалоба", "Ошиблись / Не по груз-кам", "Проверка связи", "Сорвался"}; 

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