<template>
  <div class="accordion-item">
    <h2 class="accordion-header" :id="'flush-heading-'+index">
      <button @click="Click" class="accordion-button collapsed outline-none shadow-none" type="button" data-bs-toggle="collapse" :data-bs-target="'#flush-collapse-'+index" aria-expanded="false" :aria-controls="'flush-collapse-'+index">
        <img src="~mountain.svg" class="img-fluid rounded-circle" style="height: 80px">
        <div>
         <span class="fs-3">{{mountain.name}}</span>
          <span class="text-secondary fs-6">{{mountain.ruby}}</span>
         <div class="fs-6">{{mountain.prefecture}}/{{mountain.location}} &nbsp; 標高:{{mountain.height}}</div>
        </div>
      </button>
    </h2>
    <div :id="'flush-collapse-'+index" class="accordion-collapse collapse" :aria-labelledby="'flush-heading-'+index" data-bs-parent="#accordionFlush">
      <div class="accordion-body">
        <div class="d-flex justify-content-center m-1" style="height: 200px">
          <div v-for="hotspring in hotsprings" :key="hotspring" class="ms-3 me-3">
            <router-link
              :to="'/hotspring/'+hotspring.longtitude+','+hotspring.latitude"
              class="text-decoration-none link-dark"
              target="_blank"
              rel="noopener noreferrer"
            >
              <img :src="hotspring.image_url ? hotspring.image_url : question" class="img-fluid rounded-circle w-100 text-center" style="height: 150px">
              <div class="w-100 text-center"><StatusIcons :status="hotspring.status"/>{{hotspring.name}}</div>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from '../../../plugins/axios.js'
import StatusIcons from '../../../components/StatusIcons.vue'

export default {
  props: ['index', 'mountain'],
  components:{
    StatusIcons
  },
  data(){
    return{
      hotsprings: [],
      question: require('question.svg'),
    }
  },
  methods:{
    async Click(){
      if(this.hotsprings.length === 0){
        const response = await axios.get('mountains/' + this.mountain.id)
        this.hotsprings = response.data.data.map(data => data.attributes.hotspring.data.attributes)
      }
    }
  }
}
</script>