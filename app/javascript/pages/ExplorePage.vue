<template>
  <div 
    id="map"
    ref="map-root"
    style="width: 100%; height: 100vh">
  </div>
  <div id="popup" class="ol-popup">
    <a href="#" id="popup-closer" class="ol-popup-closer"></a>
    <div id="popup-content" ref="popup"></div>
    <p></p>
    <div class="mb-3">
      メモ：<textarea class="form-control" placeholder="登録理由等" v-model="memo"></textarea>
      <button class="btn btn-secondary" @click="register">登録</button>
    </div>
  </div>
</template>

<script>
import Map from 'ol/Map'
import View from 'ol/View'
import { fromLonLat } from 'ol/proj'

import gsi from '../ol/gsi_layer'
//import thermal from '../ol/thermal_layer'
import { popup } from '../ol/popup.js'
import { mapActions, mapGetters } from 'vuex'

export default{
  data(){
    return{
      longtitude: '',
      latitude: '',
      memo: '',
    }
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring_icons']),
  },
  watch:{
    hotspring_icons(){
      this.map.addLayer(this.hotspring_icons)
    },
  },
  created(){
    this.fetchHotsprings(1)
  },
  mounted(){    
    this.map = new Map({
      target: 'map',
      layers: [gsi],
      view: new View({
        zoom: 10,
        center: fromLonLat([140.46, 35.3]),
        constrainResolution: false
      }),
    })

    popup(this.map)
  },
  methods:{
    ...mapActions('hotsprings', ['postHotspring','fetchHotsprings']),
    register(){
      const latlon = this.$refs.popup.children[1].innerText.split(',')
      const params = {'description':this.memo ,'latitude': latlon[1],'longtitude': latlon[0]}
      this.postHotspring(params)
    }
  }
}
</script>

<style scoped>
@import '../ol/popup.css';
#map{
  min-height: 100vh;
  height: 100%;
}
</style>