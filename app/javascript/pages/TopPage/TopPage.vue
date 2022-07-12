<template>
  <Top />
  <About />
  <div class="h-100 d-flex justify-content-center">
    <div class="container">
      <h1 class="text-center mb-5">野湯探索を始めましょう</h1>
      <Spot />
      <Japan />
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { mapActions, mapGetters } from 'vuex'

import Top from './Components/Top.vue'
import Japan from './Components/Japan.vue'
import About from './Components/About.vue'
import Spot from './Components/FromSpot.vue'

export default{
  components:{
    Top,
    Japan,
    About,
    Spot,
  },
  created(){
    this.fetchHotsprings()
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings'])
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Yuji+Mai&display=swap');
.webfont{
  font-family: 'Yuji Mai', serif;
}
</style>