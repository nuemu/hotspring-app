<template>
  <div 
    id="map"
    ref="map-root"
    style="width: 100%; height: 100vh">
  </div>

  <div id="popup" class="ol-popup">
    <a href="#" id="popup-closer" class="ol-popup-closer"></a>
    <div id="popup-content"></div>
  </div>
</template>

<script>
import View from 'ol/View'
import Map from 'ol/Map'
import { fromLonLat, transform } from 'ol/proj'

import 'ol/ol.css'
import { mapActions, mapGetters } from 'vuex'

import vt from '../plugins/gsi_layer'

import Overlay from 'ol/Overlay';
import {defaults as defaultControls} from 'ol/control';

import RotateNorthControl from '../plugins/ol_control.js'

export default {
  computed:{
    ...mapGetters('map',['hotspring_icons']),
    ...mapGetters('users',['user_name']),
  },
  created(){
    if(this.user_name !== '') this.fetchHotsprings(1)
    this.fetchHotsprings(0)
  },
  data(){
    return{
      map:{},
    }
  },
  watch:{
 /*   hotspring_icons(){
      this.hotspring_icons.forEach(layer => {
        this.map.addLayer(layer)
      })
    },*/
    hotspring_icons(){
      this.map.addLayer(this.hotspring_icons)
    },
    user_name(){
      if(this.user_name !== '') this.fetchHotsprings(1)
      this.fetchHotsprings(0)
      console.log(this.map.getLayers().array_[0])
    }
  },
  mounted() {
    const container = document.getElementById('popup');
    const content = document.getElementById('popup-content');
    const closer = document.getElementById('popup-closer');
    const overlay = new Overlay({
      element: container,
      autoPan: true,
      autoPanAnimation: {
        duration: 250
      }
    });

    closer.onclick = function() {
      overlay.setPosition(undefined);
      closer.blur();
      return false;
    };

    this.map = new Map({
      controls: defaultControls().extend([new RotateNorthControl()]),
      target: 'map',
      overlays: [overlay],
      view: new View({
        zoom: 10,
        center: fromLonLat([140.46, 35.3]),
        constrainResolution: false
      }),
    })

    this.map.addLayer(vt)
    //setVisible(false, true)
    this.map.on('click', function(evt) {
      this.forEachFeatureAtPixel(evt.pixel, function(feature, layer) {
        content.innerHTML =
          "<a href='/hotspring/"+feature.getProperties().features[0].values_.name+"'>" + feature.getProperties().features[0].values_.name + "</a>"
        overlay.setPosition(evt.coordinate);
      });
    });
    
  },
  methods:{
    ...mapActions('map', ['fetchHotsprings'])
  }
}
</script>

<style>
.rotate-north {
  top: 65px;
  left: .5em;
  width: 10px;
}
.ol-touch .rotate-north {
  top: 80px;
}
</style>