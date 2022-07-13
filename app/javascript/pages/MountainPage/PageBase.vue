<template>
  <div class="container">
    <div class="mb-10">&nbsp;</div>
    <h3>野湯から10km圏内にある山一覧</h3>
    <div class="accordion accordion-flush" id="accordionFlush">
      <div class="accordion-item" v-for="(mountain, index) in mountains" :key="mountain">
        <Accordion :mountain="mountain" :index="index"/>
      </div>
    </div>
    <div class="mb-10">&nbsp;</div>
    <div class="mb-10">&nbsp;</div>
  </div>
</template>

<script>
import axios from '../../plugins/axios.js'
import Accordion from './Components/Accordion.vue'

export default {
  components:{
    Accordion
  },
  data(){
    return {
      mountains: [],
      hotsprings: [],
      data: []
    }
  },
  created(){
    axios.get('mountains')
      .then((response) => {
        this.mountains = response.data.data.map(mountain => mountain.attributes);
      })
  }
}
</script>