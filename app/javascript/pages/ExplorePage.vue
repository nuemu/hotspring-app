<template>
  <div 
    id="map"
    ref="map-root"
    style="width: 100%; height: 100vh">
  </div>
</template>

<script>
import Map from 'ol/Map'
import View from 'ol/View'
import { fromLonLat } from 'ol/proj'

import gsi from '../ol/gsi_layer'
import thermal from '../ol/thermal_layer'

export default{
  mounted(){
    this.map = new Map({
      target: 'map',
      layers: [gsi, thermal],
      view: new View({
        zoom: 10,
        center: fromLonLat([140.46, 35.3]),
        constrainResolution: false
      }),
    })
  }
}
</script>

<style scoped>
#map{
  min-height: 100vh;
  height: 100%;
}
</style>