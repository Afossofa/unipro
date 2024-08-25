<#import "blocks/template.ftlh" as t>
<@t.template user>

    <hr>
    <p><h1 style="text-align: center">${product.title}</h1></p>
    <p style="text-align: center">${product.description}</p>
    <p style="text-align: center">Email: <b>${authorProduct.email}</b></p>
    <p style="text-align: center">Ссылка: <a href=${product.link}><b>${product.link}</b></p>

    <hr>
    <p style="text-align: center">
        <a href="/user/${authorProduct.id}">
             ${authorProduct.name}
        </a>
    </p>

</@t.template>