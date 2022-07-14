<template>
  <div class="text-center w-100 h-100 d-flex align-items-center">
    <div>
      <h1 class=""><span class="display-1 font-weight-normal text-nowrap webfont">ゆtellite</span>について</h1>
      <div class="container">ゆtelliteは、野湯愛好家向けの情報ポータルサイトです。</div>
      <div class="w-75 mx-auto my-5 d-flex align-self-center">
        <div class="container">
          <img src="~furo.svg" class="img-fluid" style="height: 300px">
          <h3>野湯って？</h3>
          <p />
          <div class="container-sm">
            野湯とは、人の管理下に置かれてない温泉のことを指します。
          </div>
        </div>
        <div class="container">
          <img src="~magnify.svg" class="img-fluid circle-rounded" style="height: 300px">
          <h3>野湯情報を検索</h3>
          <p />
          <div class="container-sm">地図上で、あるいは県名や温泉名から検索をかけて、野湯情報を取得しましょう</div>
          <div class="container mt-3">
            <router-link to="/hotsprings" class="btn btn-warning">野湯一覧ページへ</router-link>
          </div>
        </div>
        <div class="container">
          <img src="~adventure.svg" class="img-fluid" style="height: 300px">
          <h3>野湯候補地の選定</h3>
          <p />
          <div class="container-sm">
            野湯の候補地を選定するのに、地表温度画像が利用できます。
          </div>
          <div class="container mt-3">
            <router-link to="/howto" class="btn btn-warning">使い方ページへ</router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default{}
</script>