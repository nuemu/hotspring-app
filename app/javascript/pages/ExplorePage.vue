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
      <Form @submit="register">
        <div class="input-group">
          <Field v-model="description" v-slot="{ field }" name="description" rules="present">
            <textarea ref="description" rows="1" v-bind="field" class="form-control form-control-plaintext" @keydown.enter.shift="CommentSubmit" placeholder="登録理由等記入"></textarea>
          </Field>
        </div>
        <ErrorMessage name="description" style="color:red;" as="p" />
        <button class="btn btn-secondary">登録</button>
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

import Photo from '../ol/gsi_photo_layer.js'
import Thermal from '../ol/thermal_layer.js'
import Water from '../ol/gsi_water_layer.js'

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

    this.$refs.map.map.addLayer(Thermal)
    this.$refs.map.map.addLayer(Photo)
    this.$refs.map.map.addLayer(Water)
    this.$refs.side.normal()
  },
  methods:{
    ...mapActions('hotsprings', ['postHotspring','fetchHotsprings']),
    register(){
      const latlon = this.$refs.popup.children[1].innerText.split(',')
      const params = {'description':this.memo ,'latitude': latlon[1],'longtitude': latlon[0]}
      this.postHotspring(params)
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
}
</style>