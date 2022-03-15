<template>
  <Map ref="map"/>
  
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

<style>
@import '../ol/popup.css';
@import '../ol/visibility_control.css';
#map{
  min-height: 100vh;
  height: 100%;
}
</style>