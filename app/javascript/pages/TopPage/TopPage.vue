<template>
  <Top />
  <Japan />
  <About />
</template>

<script>
import axios from 'axios'
import { mapActions, mapGetters } from 'vuex'

import Top from './Components/Top.vue'
import Japan from './Components/Japan.vue'
import About from './Components/About.vue'

export default{
  components:{
    Top,
    Japan,
    About
  },
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Yuji+Mai&display=swap');
.webfont{
  font-family: 'Yuji Mai', serif;
}
</style>