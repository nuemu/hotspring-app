<template>
  <div class="d-flex justify-content-center align-items-center mb-5">
    <div class="container">
      <h3 class="text-center">観光スポットから探す</h3>
      <div class="d-flex justify-content-center">
        <Form @submit="Submit">
          <div class="position-relative">
            <Field name="textSearch" class="form-control rounded" v-model="query" />
            <button class="position-absolute end-0 top-0 btn">
              <img src="~search.svg">
            </button>
          </div>
        </Form>
      </div>
      <div class="overflow-scroll" style="max-height: 300px;">
        <div v-for="location in locations" :key="location" class="list-group-item list-group-item-action" @click="Click(location.coordinates)">
          <div>{{location.name}}</div>
          <div>{{location.address}}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Form, Field } from 'vee-validate'
import axios from '../../../plugins/axios.js'

export default{
  components:{
    Form,
    Field
  },
  data(){
    return {
      query: '',
      locations: [],
      hotsprings: [],
    }
  },
  methods:{
    async Submit(){
      if(this.query.length > 0){
        const response = await axios.get('text?query='+this.query)
        this.locations  = response.data
      }
      else this.locations = []
    },
    Click(coordinates){
      this.$router.push('/hotsprings/?lat='+coordinates.lat+'&lng='+coordinates.lng)
    }
  }
}
</script>