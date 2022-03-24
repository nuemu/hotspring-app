<template>
  <div class="map">
    <Map ref="map"/>
  </div>
  <div class="sidepanel">
    <SidePanel ref="side"/>
  </div>

  <DetailPopup />
  <RegisterPopup />
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

import Map from '../components/Map.vue'
import SidePanel from '../components/SidePanel.vue'
import RegisterPopup from '../components/RegisterPopup.vue'
import DetailPopup from '../components/DetailPopup.vue'

import layers from '../ol/layers/layer_loader.js'

import { detail_popup } from '../ol/detail_popup.js'
import { register_popup } from '../ol/register_popup.js'
import { InteractionStyle } from '../ol/interaction_style.js'

import VisibilityControl from '../ol/ol_control.js'

export default{
  components:{
    Map,
    SidePanel,
    RegisterPopup,
    DetailPopup,
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
    detail_popup(this.$refs.map.map)
    register_popup(this.$refs.map.map)
    InteractionStyle(this.$refs.map.map)

    this.$refs.map.map.addControl(new VisibilityControl)
    this.fetchHotsprings(1)

    // ol/layers内のlayerファイルを追加
    Object.keys(layers).forEach(key => {
      this.$refs.map.map.addLayer(layers[key])
    })
    this.$refs.side.none()
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