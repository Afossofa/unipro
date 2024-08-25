<#import "blocks/template.ftlh" as t>
<@t.template user>

    <h1 style="text-align: center">Мои материалы</h1>
    <hr>
    <a class="btn btn-dark mt-3 mb-3" style="text-align: center; width: 100%"
       data-toggle="collapse" href="#collapseExample" role="button"
       aria-expanded="true" aria-controls="collapseExample">
        Добавить новый материал
    </a>
    <div class="collapse mb-3" id="collapseExample" style="">
        <form action="/product/create" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="productName">Название</label>
                <input type="text" required class="form-control"
                       id="productName" name="title">
            </div>
            <div class="form-group">
                <label for="description">Описание</label>
                <textarea required class="form-control" id="description" name="description"></textarea>
            </div>
            <div class="form-group">
                            <label for="link">Ссылка</label>
                            <input type="text" required class="form-control"
                                   id="link" name="link">
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button type="submit" style="width: 100%" class="btn btn-dark">Добавить</button>
        </form>
        <hr>
        <div class="form-group">
                             <label for="qrcode">Ссылка</label>
                             <textarea required class="form-control" id="qr-text" name="qr-text"></textarea>
        </div>
        <button type="submit" style="width: 100%" class="btn btn-dark" onclick="generateQRCode()">Сгенерировать</button><br><br>
        <p id="qr-result">This is default QR code:</p>
        <canvas id="qr-code"></canvas>
    </div>
    <div class="card-columns">
        <#list products as product>
            <a href="/product/${product.id}" class="product-link">
                <div class="card text-white bg-dark my-3 product">
                    <div class="card-top">
                        <form action="/product/delete/${product.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-danger m-3">
                                Удалить
                            </button>
                        </form>
                    </div>

                    <div class="card-body">
                        <h5 class="card-title">${product.title}</h5>
                    </div>
                    <div class="card-footer">
                        ${product.description}
                    </div>
                </div>
            </a>
        <#else>
            <h1 style="text-align: center">Не найдено</h1>
        </#list>
    </div>
</@t.template>