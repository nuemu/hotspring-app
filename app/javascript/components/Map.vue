<template>
  <div 
    id="map"
    ref="map-root"
    style="width: 100%; height: 100%"
    class="flex-fill"
  >
  </div>
</template>

<script>
import Map from 'ol/Map'
import 'ol/ol.css'

import View from 'ol/View'
import { fromLonLat } from 'ol/proj'

import gsi from '../ol/gsi_layer.js'
import { transformExtent } from 'ol/proj';

export default {
  name: 'Map',
  data(){
    return{
      map:{},
    }
  },
  mounted() {
    this.map = new Map({
      target: 'map',
      layers: [gsi],
      view: new View({
        maxZoom: 18,
        minZoom: 5,
        zoom: 5,
        center: fromLonLat([140.46, 35.3]),
        constrainResolution: false,
        extent: transformExtent([110, 20, 170, 46], 'EPSG:4326', 'EPSG:3857')
      }),
    })
  },
}
</script>
