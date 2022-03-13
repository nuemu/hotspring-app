<template>
  <div 
    id="map"
    ref="map-root"
    style="width: 100%; height: 100vh">
  </div>
</template>

<script>
import Map from 'ol/Map'
import 'ol/ol.css'

import View from 'ol/View'
import { fromLonLat } from 'ol/proj'

import gsi from '../ol/gsi_layer.js'

import {defaults as defaultControls} from 'ol/control'
import VisibilityControl from '../ol/ol_control.js'

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
        zoom: 10,
        center: fromLonLat([140.46, 35.3]),
        constrainResolution: false
      }),
    })
  },
}
</script>
