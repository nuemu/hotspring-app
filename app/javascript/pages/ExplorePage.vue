<template>
  <div class="toppage_wrapper d-flex">
    <div class="map">
      <Map ref="map" />
    </div>
    <div class="sidepanel">
      <SidePanel ref="side" />
    </div>
    <div class="visibility-controll">
      <Visibility ref="visibility" />
    </div>

    <DetailPopup />
    <RegisterPopup />
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

import Map from '../components/TheMap.vue'
import SidePanel from '../components/SidePanel.vue'
import Visibility from '../components/VisibilityController.vue'
import RegisterPopup from '../components/RegisterPopup.vue'
import DetailPopup from '../components/DetailPopup.vue'

import layers from '../ol/layers/layer_loader.js'

import { detail_popup } from '../ol/detail_popup.js'
import { register_popup } from '../ol/register_popup.js'
import { InteractionStyle } from '../ol/interaction_style.js'

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle.min.js'

export default{
  components:{
    Map,
    SidePanel,
    Visibility,
    RegisterPopup,
    DetailPopup,
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring_icons']),
  },
  watch:{
    hotspring_icons(){
      this.hotspring_icons.forEach(icons => this.$refs.map.map.addLayer(icons))
      this.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name') == 'not_exist') layer.setVisible(false)
      })
    },
  },
  created(){
    this.fetchHotsprings(1)
  },
  mounted(){
    detail_popup(this.$refs.map.map)
    register_popup(this.$refs.map.map)
    InteractionStyle(this.$refs.map.map)
    
    // ol/layers内のlayerファイルを追加
    Object.keys(layers).forEach(key => {
      this.$refs.map.map.addLayer(layers[key])
    })
    this.$refs.side.none()
    this.$refs.side.Render(0)

    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    this.tooltip = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings']),
  }
}
</script>

<style>
@import '../ol/visibility_control.css';
.toppage_wrapper{
  height: 100vh;
  width: 100%;
}
.map {
  position:relative;
  z-index: 0;
  width: 100%;
  height: 100%;
  float: right;
}
.sidepanel {
  opacity: 1;
  position:absolute;
  z-index: 100;
  width: 60px;
  height: 90%;
  float: right;
  overflow: visible scroll;
}
.visibility-controll{
  opacity: 1;
  position: absolute;
  right:0;
  z-index: 10;
  width: 200px;
  height: 50%;
  float: left;
  overflow: visible scroll;
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