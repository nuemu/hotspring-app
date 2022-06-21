<template>
<div class="text-center d-flex w-100 h-100">
  <div class="col-md-5 p-lg-5 mx-auto my-5 align-self-center">
    <h1 class="display-1 font-weight-normal webfont">
      湯tellite
    </h1>
    <p class="lead font-weight-normal">
      衛星画像を用いて野湯を探してみましょう。
    </p>
    <div class="input-group justify-content-center">
      <div class="form-outline">
        <input type="search" id="form1" class="form-control" placeholder="野湯を検索" v-model="keyword"/>
      </div>
      <button type="button" class="btn btn-warning">
        <img src="~search.svg">
      </button>
    </div>
  </div>
</div>
<Japan />
<About />
</template>

<script>
import axios from 'axios'
import { mapActions, mapGetters } from 'vuex'

import Japan from './Components/Japan.vue'
import About from './Components/About.vue'

export default{
  data(){
    return {
      keyword: '',
    }
  },
  components:{
    Japan,
    About
  },
  computed:{
    ...mapGetters('hotsprings',['hotsprings']),
    filterHotsprings(){
      var hotsprings = []
      if(this.keyword !== ''){
        this.hotsprings.forEach(hotspring => {
          if(hotspring.name.indexOf(this.keyword) !== -1 //||
            //hotspring.prefecture.indexOf(this.keyword) !== -1
          ){
            hotsprings.push(hotspring)
          }
        })
        return hotsprings
      }

      return this.hotsprings
    }
  },
  created(){
    this.fetchHotsprings(1)
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings']),
  }
}
</script>