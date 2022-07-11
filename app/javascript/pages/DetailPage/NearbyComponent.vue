<template>
  <div class="w-100">
    <div class="lead">
      Nearby Spots
    </div>
    <div v-if="fetched" class="container-sm d-flex overflow-scroll">
      <div v-for="location in locations" :key="location" class="d-flex justify-content-center col-3 m-1" style="height: 200px">
        <a
          :href="'https://www.google.com/maps/search/?api=1&query='+location.coordinates.lat+'%2C'+location.coordinates.lng"
          class="text-decoration-none link-dark"
          target="_blank"
          rel="noopener noreferrer"
        >
          <img :src="location.photo !== 'none' ? location.photo : question" class="img-fluid rounded-circle w-100 text-center" style="height: 150px">
          <div class="w-100 text-center">{{location.name}}</div>
        </a>
      </div>
      <div v-if="locations.length === 0" class="text-center w-100 text-secondary">周辺に観光地は見つかりませんでした。</div>
    </div>
    <div
      v-else
      class="container-sm d-flex justify-content-center w-100"
    >
      <button class="btn btn-warning" @click="fetchNearby">周辺の観光地をみる</button>
    </div>
  </div>
</template>

<script>
import axios from '../../plugins/axios.js'

export default{
  props:['hot'],
  data(){
    return {
      locations: [],
      fetched: false,
      question: require('questino.svg')
    }
  },
  methods: {
    async fetchNearby(){
      const response = await axios.get('nearby?lat='+this.hot.latitude+'&lng='+this.hot.longtitude)
      this.locations = response.data
      this.fetched = true
    }
  }
}
</script>