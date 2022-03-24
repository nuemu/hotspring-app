<template>
  <div class="map">
    <Map ref="map"/>
  </div>
  <div class="sidepanel">
    <SidePanel ref="side"/>
  </div>

  <RegisterPopup />
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

import Map from '../components/Map.vue'
import SidePanel from '../components/SidePanel.vue'
import RegisterPopup from '../components/RegisterPopup.vue'

import layers from '../ol/layers/layer_loader.js'

import { popup } from '../ol/register_popup.js'
import { InteractionStyle } from '../ol/interaction_style.js'

export default{
  components:{
    Map,
    SidePanel,
    RegisterPopup,
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

    // ol/layers内のlayerファイルを追加
    Object.keys(layers).forEach(key => {
      this.$refs.map.map.addLayer(layers[key])
    })
    this.$refs.side.Render(0)
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings']),
  }
}
</script>

<style>
@import '../ol/visibility_control.css';
.map {
  position:relative;
  z-index: 0;
  width: 90%;
  height: 100%;
  float: right;
}
.sidepanel {
  background-color: #ffff;
  position:relative;
  z-index: 100;
  width: 10%;
  height: 100%;
  float: right;
}
textarea{
  resize: none;
  box-shadow:none !important;
  border-color: white !important;
}
.btn{
  box-shadow:none !important;
}
</style>