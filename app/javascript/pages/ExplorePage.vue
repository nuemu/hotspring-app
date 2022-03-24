<template>
  <div class="map">
    <Map ref="map"/>
  </div>
  <div class="sidepanel">
    <SidePanel ref="side"/>
  </div>
  
  <div id="popup" class="ol-popup">
    <a href="#" id="popup-closer" class="ol-popup-closer"></a>
    <div id="popup-content" ref="popup"></div>
    <p></p>
    <div class="mb-3">
      <Form @submit="DescriptionSubmit">
        <div class="input-group">
          <Field v-model="description" v-slot="{ field }" name="description" rules="present">
            <button class="btn">+</button>
            <textarea ref="description" rows="1" v-bind="field" class="form-control form-control-plaintext" placeholder="登録理由等記入"></textarea>
          </Field>
        </div>
        <ErrorMessage name="description" style="color:red;" as="p" />
      </Form>
    </div>
  </div>
</template>

<script>
//import thermal from '../ol/thermal_layer'
import { mapActions, mapGetters } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';

import Map from '../components/Map.vue'
import SidePanel from '../components/SidePanel.vue'

import layers from '../ol/layers/layer_loader.js'
import layer from '../ol/layers/gsi_photo_layer.js'

import { popup } from '../ol/register_popup.js'
import { InteractionStyle } from '../ol/interaction_style.js'

export default{
  components:{
    Map,
    SidePanel,
    Form,
    Field,
    ErrorMessage,
  },
  data(){
    return{
      longtitude: '',
      latitude: '',
      description: '',
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

    // ol/layers内のlayerファイルを追加
    Object.keys(layers).forEach(key => {
      this.$refs.map.map.addLayer(layers[key])
    })
    this.$refs.side.Render(0)
  },
  methods:{
    ...mapActions('hotsprings', ['postHotspring','fetchHotsprings']),
    DescriptionSubmit(){
      const latlon = this.$refs.popup.children[1].innerText.split(',')
      const params = {'description':this.description ,'latitude': latlon[1],'longtitude': latlon[0]}
      this.postHotspring(params)
        .then(() => document.getElementById('popup-closer').click())
    },
  }
}
</script>

<style>
@import '../ol/popup.css';
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
  height: 100vh;
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