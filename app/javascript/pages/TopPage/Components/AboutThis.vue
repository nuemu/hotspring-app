<template>
  <div class="text-center w-100 h-100 d-flex align-items-center">
    <div>
      <h1><span class="display-1 font-weight-normal text-nowrap webfont">ゆtellite</span>について</h1>
      <div class="container">
        ゆtelliteは、野湯愛好家向けの情報ポータルサイトです。
      </div>
      <div class="w-75 mx-auto my-5 d-flex align-self-center">
        <div class="container">
          <router-link
            :to="hotspring"
            class="btn btn-outline-warning text-dark p-4 container overflow-hidden"
            style="height: 500px"
          >
            <img
              src="~furo.svg"
              class="img-fluid"
              style="height: 300px"
            >
            <h3>野湯って？</h3>
            <p />
            <div class="container-sm">
              野湯とは、自然の中の温泉を指します。多くは、人の管理下に置かれず。
            </div>
          </router-link>
        </div>
        <div class="container">
          <router-link
            to="/hotsprings"
            class="btn btn-outline-warning text-dark p-4 container overflow-hidden"
            style="height: 500px"
          >
            <img
              src="~magnify.svg"
              class="img-fluid circle-rounded"
              style="height: 300px"
            >
            <h3>野湯情報を検索</h3>
            <p />
            <div class="container-sm">
              地図上で、あるいは県名や温泉名から検索をかけて、野湯情報を取得しましょう
            </div>
          </router-link>
        </div>
        <div class="container">
          <router-link
            to="/howto"
            class="btn btn-outline-warning text-dark p-4 container overflow-hidden"
            style="height: 500px"
          >
            <img
              src="~adventure.svg"
              class="img-fluid"
              style="height: 300px"
            >
            <h3>野湯候補地の選定</h3>
            <p />
            <div class="container-sm">
              野湯の候補地を選定するのに、地表温度画像が利用できます。
            </div>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default{
  computed:{
    ...mapGetters('hotsprings', ['hotsprings']),
    hotspring(){
      var hotsprings = this.hotsprings.filter(hotspring => hotspring.status !== 'unexplored' && hotspring.status !== 'not_exist')
      var max = Math.floor(hotsprings.length);
      var hotspring = hotsprings[Math.floor(Math.random() * max)] 
      return hotspring ? '/hotspring/'+hotspring.longtitude+','+hotspring.latitude : '/'
    }
  }
}
</script>