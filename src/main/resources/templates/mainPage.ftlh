<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Companies</title>
</head>
<script>
    function addNewCompany() {
        let table = document.getElementById('companies');
        if (table === null) {
            table = document.createElement('table');
            table.setAttribute('id', 'companies');

            let tr = table.insertRow(0);
            tr.insertCell(0).outerHTML = '<th>Назмание</th>';
            tr.insertCell(1).outerHTML = '<th>ИНН</th>';

            document.getElementById('bodyDiv').append(table);
            let noCompaniesH2 = document.getElementById('noCompaniesH2');
            noCompaniesH2.parentNode.removeChild(noCompaniesH2);
        }
        let newRow = table.insertRow(table.rows.length);
        newRow.setAttribute('id', 'tr:newCompany');

        let newCell = newRow.insertCell(0);
        newCell.setAttribute('id', 'companyName');
        let newElem = document.createElement('input');
        newElem.setAttribute('type', 'text');
        newElem.setAttribute('value', 'Новый контрагент');
        newElem.readOnly = true;
        newCell.appendChild(newElem);

        newCell = newRow.insertCell(1);
        newCell.setAttribute('id', 'companyINN');
        newElem = document.createElement('input');
        newElem.setAttribute('type', 'text');
        newElem.setAttribute('value', '');
        newElem.readOnly = true;
        newCell.appendChild(newElem);

        newCell = newRow.insertCell(2);
        newCell.setAttribute('id', 'btn_edit');
        newElem = document.createElement('input');
        newElem.setAttribute('type', 'button');
        newElem.setAttribute('value', 'Редактировать');
        newElem.setAttribute('onclick', 'editCompany(\'newCompany\')');
        newCell.appendChild(newElem);

        newCell = newRow.insertCell(3);
        newCell.setAttribute('id', 'btn_delete');
        newElem = document.createElement('input');
        newElem.setAttribute('type', 'button');
        newElem.setAttribute('value', 'Удалить');
        newElem.setAttribute('onclick', 'deleteCompany(\'newCompany\')');
        newCell.appendChild(newElem);

        let form = document.createElement('form');
        form.action = '/add';
        form.method = 'post';
        form.innerHTML = getInnerHtmlForFinishEditForm("newCompany");
        newRow.append(form);
        form.submit();
    }

    function deleteCompany(companyId) {
        let tr = document.getElementById("tr:" + companyId);
        if (companyId === 'newCompany') {
            document.getElementById('companies').deleteRow(tr.rowIndex);
        } else {
            let form = document.createElement('form');
            form.action = '/delete'
            form.method = 'post';
            form.innerHTML = getInnerHtmlForFinishEditForm(companyId);
            tr.append(form);
            form.submit();
        }
    }

    function editCompany(companyId) {
        let tr = document.getElementById("tr:" + companyId);
        let tds = tr.getElementsByTagName('td');

        let companyName = tds['companyName'].getElementsByTagName('input')[0];
        let companyINN = tds['companyINN'].getElementsByTagName('input')[0];

        companyINN.readOnly = false;
        companyName.readOnly = false;

        let btnEdit = tds['btn_edit'].getElementsByTagName('input')[0];
        btnEdit.value = "Завершить";
        tds['btn_edit'].id = "btn_finish";
        btnEdit.setAttribute('onclick', 'finishEditing(\'' + companyId + '\')');

        let tdCheck = tr.insertCell(4);

        let btnCheck = document.createElement('input');
        btnCheck.type = "button";
        btnCheck.value = "Проверить ИНН";
        btnCheck.setAttribute('onclick', 'check(\'' + companyId + '\')');
        tdCheck.append(btnCheck);
    }

    function finishEditing(companyId) {
        let tr = document.getElementById("tr:" + companyId);
        let tds = tr.getElementsByTagName('td');
        let btnFinish = tds['btn_finish'].getElementsByTagName('input')[0];
        let companyName = tds['companyName'].getElementsByTagName('input')[0];
        let companyINN = tds['companyINN'].getElementsByTagName('input')[0];
        let form = document.createElement('form');

        if (companyINN.value === '') {
            alert("ИНН контрагента не заполнен");
        } else {

            form.action = '/edit';
            form.method = 'post';
            form.innerHTML = getInnerHtmlForFinishEditForm(companyId);
            tr.append(form);
            form.submit();

            companyINN.readOnly = true;
            companyName.readOnly = true;

            btnFinish.value = "Редактировать";
            tds['btn_finish'].id = "btn_edit";
            btnFinish.setAttribute('onclick', 'editCompany(\'' + companyId + '\')');
        }
    }

    function getInnerHtmlForFinishEditForm(companyId) {
        let tr = document.getElementById("tr:" + companyId);
        let tds = tr.getElementsByTagName('td');
        let companyName = tds['companyName'].getElementsByTagName('input')[0];
        let companyINN = tds['companyINN'].getElementsByTagName('input')[0];

        let companyIdInput = '<input type=\'hidden\' name=\'companyId\' value=\'' + companyId + '\'>';
        let companyNameInput = '<input type=\'hidden\' name=\'companyName\' value=\'' + companyName.value + '\'>'
        let companyINNInput = '<input type=\'hidden\' name=\'companyINN\' value=\'' + companyINN.value + '\'>';

        return companyIdInput + companyNameInput + companyINNInput;
    }

    function check(companyId) {
        let tr = document.getElementById("tr:" + companyId);
        let tds = tr.getElementsByTagName('td');
        let companyINN = tds['companyINN'].getElementsByTagName('input')[0];

        let form = document.createElement('form');
        form.action = '/check'
        form.method = 'post';
        form.innerHTML = '<input type=\'hidden\' name=\'companyINN\' value=\'' + companyINN.value + '\'>';
        tr.append(form);
        form.submit();
    }
</script>
<body>
<h1>Контрагенты</h1>
<div id="bodyDiv">
    <#if (companies?size <= 0)>
        <h2 id="noCompaniesH2">Контрагентов нет</h2>
    <#else>
        <table id="companies">
            <tr>
                <th>Название</th>
                <th>ИНН</th>
            </tr>
            <#foreach company in companies>
                <tr id="tr:${company.getId()}">
                    <td id="companyName"><input type="text" value="${company.getName()}" readonly></td>
                    <td id="companyINN"><input type="text" value="${company.getInn()}" readonly></td>
                    <td id="btn_edit"><input type="button" value="Редактировать"
                                             onclick="editCompany(${company.getId()})"></td>
                    <td id="btn_delete"><input type="button" value="Удалить"
                                               onclick="deleteCompany(${company.getId()})"></td>
                </tr>
            </#foreach>
        </table>
    </#if>
    <div><input type="button" id="btn_add_new" value="Добавить контрагента" onclick="addNewCompany()"></div>
</div>
</body>
</html>