<template>
  <div class="map">
    <Map ref="map"/>
  </div>
  <div class="sidepanel">
    <div>
      使い方
    </div>
    <div>
      モード
      <ul>
        <li>登録</li>
        <li>線を引く</li>
      </ul>
    </div>
    <div>
      地図
      <ol>
        <li @click="normal">標準地図</li>
        <li @click="thermal">Thermal</li>
        <li @click="photo">航空写真</li>
      </ol>
    </div>
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
//import thermal from '../ol/thermal_layer'
import { mapActions, mapGetters } from 'vuex'

import Map from '../components/Map.vue'

import { popup } from '../ol/register_popup.js'
import { InteractionStyle } from '../ol/interaction_style.js'
import InteractionControl from '../ol/interaction_control.js'

import Photo from '../ol/gsi_photo_layer.js'
import Thermal from '../ol/thermal_layer.js'

export default{
  components:{
    Map
  },
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
      this.hotspring_icons.forEach(icons => this.$refs.map.map.addLayer(icons))
    },
  },
  created(){
    this.fetchHotsprings(1)
  },
  mounted(){
    popup(this.$refs.map.map)
    InteractionStyle(this.$refs.map.map)

    this.$refs.map.map.addControl(new InteractionControl)

    this.$refs.map.map.addLayer(Thermal)
    this.$refs.map.map.addLayer(Photo)
    this.normal()
  },
  methods:{
    ...mapActions('hotsprings', ['postHotspring','fetchHotsprings']),
    register(){
      const latlon = this.$refs.popup.children[1].innerText.split(',')
      const params = {'description':this.memo ,'latitude': latlon[1],'longtitude': latlon[0]}
    },
    normal(){
      this.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='THERMAL'){
          layer.setVisible(false)
        }
        if(layer.get('name')=='photo'){
          layer.setVisible(false)
        }
      })
    },
    thermal(){
      this.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='THERMAL'){
          layer.setVisible(true)
        }
        if(layer.get('name')=='photo'){
          layer.setVisible(false)
        }
      })
      
    },
    photo(){
      let add_layer = true
      this.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='THERMAL'){
          layer.setVisible(false)
        }
        if(layer.get('name')=='photo'){
          layer.setVisible(true)
        }
      })
    }
  }
}
</script>

<style>
@import '../ol/popup.css';
@import '../ol/visibility_control.css';

.map {
  width: 90%;
  height: 100%;
  float: right;
}
.sidepanel {
  background: #eeee;
  z-index: 1;
  width: 10%;
  height: 100vh;
  float: right;
}
</style>