<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Неверные учётные данные!</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="/hr/css/groundwork.css" type="text/css" rel="stylesheet">
        <link href="/hr/css/style.css" type="text/css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="http://savepic.ru/14659608.png"/>
    </head>
    <body>
        <a href="http://biznesfon.ru">
            <img class="logimg" src="https://s8.hostingkartinok.com/uploads/images/2017/10/96bfde63dbe76ee39596a1cbed77c3bb.png" alt="logotype">
        </a>
        
        <div class="logo headertext">Operator's Statistic App</div>
        <div class="error box centered two sevenths double-gapped animated fadeInDownBig">
            <h2>Попытка повторной регистрации!</h2>  
            <p class="сentered">
                Если Вы забыли пароль от своей учётной записи, <br>
                проверьте свой email: 
                <%
                    out.print(session.getAttribute("email"));
                %>
                
            </p>
            <button class="button red" onclick="history.back();">Вернуться к регистрации</button>
            <button class="button red" onclick="history.go(-2);">Вернуться к авторизации</button>
        </div>
    </body>
</html>

