<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doubles</title>
</head>
<body>
<h1>Дубликаты</h1>
<#if (doubles?size <= 0)>
<h2 id="noCompaniesH2">Контрагентов нет</h2>
<#else>
<table id="companies">
    <tr>
        <th>Название</th>
        <th>ИНН</th>
        <#if showDels == true>
            <th>На удаление</th>
        </#if>
    </tr>
    <#foreach double in doubles>
        <tr id="tr:${double.getId()}">
            <td id="companyName"><input type="text" value="${double.getName()}" readonly></td>
            <td id="companyINN"><input type="text" value="${double.getInn()}" readonly></td>
            <#if showDels == true>
                <td><input type="text" value="<#if double.getToDelete() == 1>Да<#else>Нет</#if>" readonly></td>
            </#if>
        </tr>
    </#foreach>
    </#if>
</body>
<a href="javascript:history.back()">Назад</a>
</html>