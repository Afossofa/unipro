<#import "blocks/template.ftlh" as t>
<@t.template user>
    `<h1 style="text-align: center">Панель администратора</h1><hr>
    <table class="table table-hover table-dark">
        <tr>
            <th scope="col">Email</th>

            <th scope="col">Роли</th>

            <th scope="col">Редактирование</th>
            <th scope="col">Подробная информация</th>
            <th scope="col">Удалить</th>
        </tr>
        <#list users as user>
            <tr>
                <th>${user.email}</th>

                <th><#list user.roles as role>${role}</#list></th>

                <th><a href="/admin/user/edit/${user.id}">Редактировние</a></th>
                <th><a href="/user/${user.id}">Подробная информация</a></th>
                <th><form action="/admin/user/delete/${user.id}" method="post">
                          <input type="hidden" name="_csrf" value="${_csrf.token}">
                          <input type="submit" class="btn btn-light" value="Удалить">
                    </form>
                </th>
            </tr>
        <#else>
            <h3>Пользователей нет</h3>
        </#list>
    </table>
</@t.template>