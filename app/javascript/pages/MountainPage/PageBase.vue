<template>
  <div class="container">
    <div class="mb-10">
&nbsp;
    </div>
    <h3>野湯から10km圏内にある山一覧</h3>
    <div
      id="accordionFlush"
      class="accordion accordion-flush"
    >
      <div
        v-for="(mountain, index) in mountains"
        :key="mountain"
        class="accordion-item"
      >
        <Accordion
          :mountain="mountain"
          :index="index"
        />
      </div>
    </div>
    <div class="mb-10">
&nbsp;
    </div>
    <div class="mb-10">
&nbsp;
    </div>
  </div>
</template>

<script>
import axios from '../../plugins/axios.js'
import Accordion from './Components/TheAccordion.vue'

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