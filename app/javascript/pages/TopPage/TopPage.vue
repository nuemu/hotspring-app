<template>
<div class="text-center d-flex w-100 h-100 bg-warning">
  <div class="col-md-5 p-lg-5 mx-auto my-5 align-self-center">
    <div class="lead font-weight-normal">
        野湯のことなら
    </div>
    <h1 class="display-1 font-weight-normal webfont">
      ゆtellite
    </h1>
    <div class="input-group justify-content-center">
      <div class="form-outline">
        <input type="search" id="form1" class="form-control shadow-none" placeholder="野湯を検索" v-model="keyword"/>
      </div>
      <span class="input-group-btn">
      <button class="btn btn-default btn-outline-secondary" @click="Search">
        <img src="~search.svg">
      </button>
      </span>
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
    Search(){
      this.$router.push({ path: 'hotsprings', query: {keyword: this.keyword} })
    }
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Yuji+Mai&display=swap');
.webfont{
  font-family: 'Yuji Mai', serif;
}
</style>