<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Моя статистика</title>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link type="text/css" href="http://192.168.52.95:8080/os/css/radio.css" rel="stylesheet">    
    </head>
    <body>
        <form action="Call" method="post">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a href="/os/sign-out">Выход [<% out.print(session.getAttribute("line")); %>]</a>
                </div>
                <div class="panel-body scalable">
                    <div class="section">
                        <div class="selection"><input id="city1" required type="radio" class="radio" name="city" value="Санкт-Петербург"/>
                            <label for="city1">Санкт-Петербург</label>
                        </div>
                        <div class="selection"><input id="city2" required type="radio" class="radio" name="city" value="Москва"/>
                            <label for="city2">Москва</label>
                        </div>
                    </div>
                </div>
                <div class="panel-heading">
                    <input type="submit" value="Отправить" class="btn btn-warning"/>
                </div>
                <div class="panel-body scalable">
                    <div class="section">
                        <div class="selection"><input id="type1" required type="radio" class="radio" name="callsType" value="Заказ"/>				<label for="type1" >Заказ</label></div>
                        <div class="selection"><input id="type16" required type="radio" class="radio" name="callsType" value="Заказ с почты"/>			<label for="type16">Заказ с почты</label></div>
                        <div class="selection"><input id="type17" required type="radio" class="radio" name="callsType" value="Заказ с консультации"/>		<label for="type17">Заказ с консультации</label></div>
                        <div class="selection"><input id="type2" required type="radio" class="radio" name="callsType" value="Консультация"/>			<label for="type2" >Консультация</label></div>
                        <div class="selection"><input id="type18" required type="radio" class="radio" name="callsType" value="Консультация с согласованием"/>	<label for="type18">Консультация с согласованием</label></div>
                        <div class="selection"><input id="type3" required type="radio" class="radio" name="callsType" value="Дорого"/>				<label for="type3" >Дорого</label></div>
                        <div class="selection"><input id="type4" required type="radio" class="radio" name="callsType" value="Корректировка"/>			<label for="type4" >Корректировка</label></div>
                        <div class="selection"><input id="type5" required type="radio" class="radio" name="callsType" value="Доп.информация"/>			<label for="type5" >Доп.информация</label></div>
                        <div class="selection"><input id="type6" required type="radio" class="radio" name="callsType" value="Опоздание"/>			<label for="type6" >Опоздание</label></div>
                        <div class="selection"><input id="type7" required type="radio" class="radio" name="callsType" value="Не можем предоставить"/>           <label for="type7" >Не можем предоставить</label></div>
                        <div class="selection"><input id="type8" required type="radio" class="radio" name="callsType" value="Снятие заказа"/>			<label for="type8" >Снятие заказа</label></div>
                        <div class="selection"><input id="type9" required type="radio" class="radio" name="callsType" value="Отдел кадров"/>			<label for="type9" >Отдел кадров</label></div>
                        <div class="selection"><input id="type10" required type="radio" class="radio" name="callsType" value="Перевод другому оператору"/>      <label for="type10">Перевод другому оператору</label></div>
                        <div class="selection"><input id="type11" required type="radio" class="radio" name="callsType" value="Перевод в КО"/>			<label for="type11">Перевод в КО</label></div>
                        <div class="selection"><input id="type12" required type="radio" class="radio" name="callsType" value="Перевод в ОКК / Жалоба"/>         <label for="type12">Перевод в ОКК / Жалоба</label></div>
                        <div class="selection"><input id="type13" required type="radio" class="radio" name="callsType" value="Ошибся номером / Не по груз-кам"/><label for="type13">Ошибся номером / Не по груз-кам</label></div>
                        <div class="selection"><input id="type14" required type="radio" class="radio" name="callsType" value="Проверка связи"/>			<label for="type14">Проверка связи</label></div>
                        <div class="selection"><input id="type15" required type="radio" class="radio" name="callsType" value="Сорвался"/>			<label for="type15">Сорвался</label></div>
                    </div>
                </div>
            </div> 
        </form>
    </body>
</html>