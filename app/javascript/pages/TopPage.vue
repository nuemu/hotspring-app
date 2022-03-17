<template>
  <Map  ref="map"/>
  <div id="popup" class="ol-popup">
    <a href="#" id="popup-closer" class="ol-popup-closer"></a>
    <div id="popup-content" ref="popup"></div>
    <p></p>
    <div class="mb-3">
    </div>
  </div>
</template>

<script>
import Map from '../components/Map.vue'
import { mapActions, mapGetters } from 'vuex'

import VisibilityControl from '../ol/ol_control.js'
import { popup } from '../ol/popup.js'

export default{
  components:{
    Map
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring_icons']),
    ...mapGetters('users',['user_name']),
  },
  created(){
    if(this.user_name !== ''){
      this.fetchHotsprings(1)
    }
    this.fetchHotsprings(0)
  },
  watch:{
    hotspring_icons(){
      this.hotspring_icons.forEach(icons => this.$refs.map.map.addLayer(icons))
      popup(this.$refs.map.map)
    },
    user_name(){
      if(this.user_name) {
        this.fetchHotsprings(1)
        this.$refs.map.map.addControl(new VisibilityControl)
      }
      this.fetchHotsprings(0)
    }
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings'])
  }
}
</script>

<style scoped>
#map{
  min-height: 100vh;
  height: 100%;
}
</style>