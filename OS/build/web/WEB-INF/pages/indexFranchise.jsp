<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Моя статистика</title>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link type="text/css" href="/os/css/radio.css" rel="stylesheet">  
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
                    <a href="/os/sign-out">Выход [<% out.print(session.getAttribute("line")); %>]</a>
                </div>
                <div class="panel-body scalable">
                    <div class="section">
                        <div class="selection"><input id="city1"  required="required" type="radio" class="radio" name="city" value="Воронеж"/>       <label for="city1">Воронеж</label></div>
                        <div class="selection"><input id="city2"  required="required" type="radio" class="radio" name="city" value="Екатеринбург"/>  <label for="city2">Екатеринбург</label></div>
                        <div class="selection"><input id="city3"  required="required" type="radio" class="radio" name="city" value="Иркутск"/>       <label for="city3">Иркутск</label></div>
                        <div class="selection"><input id="city4"  required="required" type="radio" class="radio" name="city" value="КавМинВоды"/>    <label for="city4">КавМинВоды</label></div>
                        <div class="selection"><input id="city5"  required="required" type="radio" class="radio" name="city" value="Калининград"/>   <label for="city5">Калининград</label></div>
                        <div class="selection"><input id="city6"  required="required" type="radio" class="radio" name="city" value="Краснодар"/>     <label for="city6">Краснодар</label></div>
                        <div class="selection"><input id="city7"  required="required" type="radio" class="radio" name="city" value="Красноярск"/>    <label for="city7">Красноярск</label></div>
                        <div class="selection"><input id="city8"  required="required" type="radio" class="radio" name="city" value="Новосибирск"/>   <label for="city8">Новосибирск</label></div>
                        <div class="selection"><input id="city9"  required="required" type="radio" class="radio" name="city" value="Омск"/>          <label for="city9">Омск</label></div>
                        <div class="selection"><input id="city10" required="required" type="radio" class="radio" name="city" value="Пермь"/>         <label for="city10">Пермь</label></div>
                        <div class="selection"><input id="city11" required="required" type="radio" class="radio" name="city" value="Петрозаводск"/>  <label for="city11">Петрозаводск</label></div>
                        <div class="selection"><input id="city12" required="required" type="radio" class="radio" name="city" value="Ростов-на-Дону"/><label for="city12">Ростов-на-Дону</label></div>
                        <div class="selection"><input id="city13" required="required" type="radio" class="radio" name="city" value="Самара"/>        <label for="city13">Самара</label></div>
                        <div class="selection"><input id="city14" required="required" type="radio" class="radio" name="city" value="Тула"/>          <label for="city14">Тула</label></div>
                        <div class="selection"><input id="city15" required="required" type="radio" class="radio" name="city" value="Челябинск"/>     <label for="city15">Челябинск</label></div>
                    </div>
                </div>
                <div class="panel-heading">
                    <input type="submit" value="Отправить" class="btn btn-warning"/>
                </div>
                <div class="panel-body scalable">
                    <div class="section">
                        <div class="selection"><input id="type1" required="required" type="radio" class="radio" name="callsType" value="Заказ"/>				<label for="type1" >Заказ</label></div>
                        <div class="selection"><input id="type16" required="required" type="radio" class="radio" name="callsType" value="Заказ с почты"/>			<label for="type16">Заказ с почты</label></div>
                        <div class="selection"><input id="type17" required="required" type="radio" class="radio" name="callsType" value="Заказ с консультации"/>		<label for="type17">Заказ с консультации</label></div>
                        <div class="selection"><input id="type2" required="required" type="radio" class="radio" name="callsType" value="Консультация"/>			<label for="type2" >Консультация</label></div>
                        <div class="selection"><input id="type18" required="required" type="radio" class="radio" name="callsType" value="Консультация с согласованием"/>	<label for="type18">Консультация с согласованием</label></div>
                        <div class="selection"><input id="type3" required="required" type="radio" class="radio" name="callsType" value="Дорого"/>				<label for="type3" >Дорого</label></div>
                        <div class="selection"><input id="type4" required="required" type="radio" class="radio" name="callsType" value="Корректировка"/>			<label for="type4" >Корректировка</label></div>
                        <div class="selection"><input id="type5" required="required" type="radio" class="radio" name="callsType" value="Доп.информация"/>			<label for="type5" >Доп.информация</label></div>
                        <div class="selection"><input id="type6" required="required" type="radio" class="radio" name="callsType" value="Опоздание"/>				<label for="type6" >Опоздание</label></div>
                        <div class="selection"><input id="type7" required="required" type="radio" class="radio" name="callsType" value="Не можем предоставить" onclick="openGoogleSheets()"/><label for="type7" >Не можем предоставить</label></div>
                        <div class="selection"><input id="type8" required="required" type="radio" class="radio" name="callsType" value="Снятие заказа"/>			<label for="type8" >Снятие заказа</label></div>
                        <div class="selection"><input id="type9" required="required" type="radio" class="radio" name="callsType" value="Отдел кадров"/>			<label for="type9" >Отдел кадров</label></div>
                        <div class="selection"><input id="type10" required="required" type="radio" class="radio" name="callsType" value="Перевод другому оператору"/>          <label for="type10">Перевод другому оператору</label></div>
                        <div class="selection"><input id="type11" required="required" type="radio" class="radio" name="callsType" value="Перевод в КО"/>			<label for="type11">Перевод в КО</label></div>
                        <div class="selection"><input id="type12" required="required" type="radio" class="radio" name="callsType" value="Перевод в ОКК / Жалоба"/>             <label for="type12">Перевод в ОКК / Жалоба</label></div>
                        <div class="selection"><input id="type13" required="required" type="radio" class="radio" name="callsType" value="Ошибся номером / Не по груз-кам"/>    <label for="type13">Ошибся номером / Не по груз-кам</label></div>
                        <div class="selection"><input id="type14" required="required" type="radio" class="radio" name="callsType" value="Проверка связи"/>			<label for="type14">Проверка связи</label></div>
                        <div class="selection"><input id="type15" required="required" type="radio" class="radio" name="callsType" value="Сорвался"/>				<label for="type15">Сорвался</label></div>
                    </div>
                </div>
            </div> 
        </form>
    </body>
</html>