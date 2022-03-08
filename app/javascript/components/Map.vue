<template>
  <div 
    id="map"
    ref="map-root"
    style="width: 100%; height: 100vh">
  </div>
</template>

<script>
import View from 'ol/View'
import Map from 'ol/Map'
import { fromLonLat, transform } from 'ol/proj'

import 'ol/ol.css'
import { mapActions, mapGetters } from 'vuex'

import vt from '../plugins/openlayer_tiles'

export default {
  computed:{
    ...mapGetters('map',['hotspring_icons'])
  },
  created(){
    this.fetchHotsprings()
  },
  watch:{
    hotspring_icons(){
      this.hotspring_icons.forEach(layer => {
        console.log(layer)
        this.map.addLayer(layer)
      })
    }
  },
  mounted() {
    
    this.map = new Map({
      target: 'map',
      view: new View({
        zoom: 10,
        center: fromLonLat([140.46, 35.3]),
        constrainResolution: false
      }),
    })

    this.map.addLayer(vt)

    this.map.on('click', function(e) {
      const lonlat = transform(e.coordinate, 'EPSG:3857', 'EPSG:4326');
      alert("lat: " + lonlat[1] + ", lat: " + lonlat[0]);
    });
    
  },
  methods:{
    ...mapActions('map', ['fetchHotsprings'])
  }
}
</script>