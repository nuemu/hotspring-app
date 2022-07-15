<template>
  <div class="container d-flex justify-content-center">
    <div class="container mt-3">
      <h3>使い方</h3>
      <div class="accordion" id="accordion">
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingOne">
            <button class="accordion-button collapsed shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
              野湯情報を探す
            </button>
          </h2>
          <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordion">
            <div class="accordion-body">
              野湯情報を探す方法として、一覧からキーワードなどを用いる方法と、近隣の山から調べる方法を準備しました。ヘッダーの「野湯一覧」または「山一覧」からご覧になってください。
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingFour">
            <button class="accordion-button collapsed shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
              ユーザー登録
            </button>
          </h2>
          <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordion">
            <div class="accordion-body">
              <div>全機能を利用するためには、画面右上のユーザー登録から、登録をお願いします。<span class="text-secondary">(ユーザー名とパスワードの設定のみで、簡単に登録できます。)</span></div>
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingTwo">
            <button class="accordion-button collapsed shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
              野湯情報を共有する(要：ユーザー登録)
            </button>
          </h2>
          <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordion">
            <div class="accordion-body">
              <strong>*ユーザー登録が必要です*</strong>
              <div>ログインすると各野湯情報ページで、コメント投稿や、記事の共有が可能になります。また、右上に編集ボタンが表示されるようになります。</div>
              <img src="~detail_page_sample.png" class="img-fluid">
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingThree">
            <button class="accordion-button collapsed shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
              野湯を探す・登録する(要：ユーザー登録)
            </button>
          </h2>
          <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordion">
            <div class="accordion-body">
              <strong>*ユーザー登録が必要です*</strong>
              <div>新規に野湯を探すための手段として、ゆtelliteでは衛星画像を提供しています。</div>
              <div>この機能を利用するためには、ログイン後ヘッダーに表示される「野湯を探す」から「野湯を探すページ」に進んでください。</div>
              <div>「野湯を探す」ページの使い方は、野湯を探すページ左上の<img src="~question.svg" class="img-fluid">アイコンを押して確認してください。</div>
              <img src="~explore_page_sample.png" class="img-fluid">
            </div>
          </div>
        </div>
      </div>
      <div class="mb-5">&nbsp;</div>
    </div>
  </div>
</template>