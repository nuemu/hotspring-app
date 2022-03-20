<template>
<Description ref="description"/>
<p></p>
<div class="container">
  <ul class="list-group list-group-flush">
    <li @click="description" class="list-group-item list-group-item-action text-center">使い方</li>
  </ul>
</div>
<p></p>
<div>
  <div class="container">
    <h5 class="lead">Click</h5>
    <ol class="list-group list-group-flush list-group-numbered">
      <li @click="register" :class="'list-group-item list-group-item-action '+options[0]">野湯登録</li>
      <li @click="draw" :class="'list-group-item list-group-item-action '+options[1]">囲む</li>
      <li @click="none" :class="'list-group-item list-group-item-action '+options[2]">-</li>
    </ol>
  </div>
</div>
<p></p>
<div>
  <div class="container">
    <h5 class="lead">Map</h5>
    <ol class="list-group list-group-flush list-group-numbered">
      <li @click="normal" :class="'list-group-item list-group-item-action '+maps[0]">標準地図</li>
      <li @click="water" :class="'list-group-item list-group-item-action '+maps[1]">水系地図</li>
      <li @click="thermal" :class="'list-group-item list-group-item-action '+maps[2]">サーマル</li>
      <li @click="photo" :class="'list-group-item list-group-item-action '+maps[3]">航空写真</li>
    </ol>
  </div>
</div>
</template>

<script>
import { Interaction } from '../ol/interaction.js'
import { register } from '../ol/register_event.js'

import Description from './DescriptionModal.vue'

export default{
  components:{
    Description
  },
  data(){
    return{
      option_select: 2,
      map_select: 0
    }
  },
  computed:{
    options(){
      let options = ['','','']
      options[this.option_select]='list-group-item-secondary'
      return options
    },
    maps(){
      let maps = ['','','','']
      maps[this.map_select]='list-group-item-secondary'
      return maps
    }
  },
  methods:{
    description(){
      this.$refs.description.modal_appearance = true
    },
    none(){
      this.option_select = 2
      const map = this.$parent.$refs.map.map
      Interaction(map, false)
      map.un('singleclick', register)
    },
    register(){
      this.option_select = 0
      const map = this.$parent.$refs.map.map
      map.on('singleclick', register)

      Interaction(map, false)
    },
    draw(){
      this.option_select = 1
      const map = this.$parent.$refs.map.map
      map.un('singleclick', register)

      Interaction(map, true)
    },
    normal(){
      this.map_select = 0
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='normal'){
          layer.setVisible(true)
        }
        if(layer.get('name')=='water'){
          layer.setVisible(false)
        }
        if(layer.get('name')=='THERMAL'){
          layer.setVisible(false)
        }
        if(layer.get('name')=='photo'){
          layer.setVisible(false)
        }
      })
    },
    water(){
      this.map_select = 1
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='normal'){
          layer.setVisible(false)
        }
        if(layer.get('name')=='water'){
          layer.setVisible(true)
        }
        if(layer.get('name')=='THERMAL'){
          layer.setVisible(false)
        }
        if(layer.get('name')=='photo'){
          layer.setVisible(false)
        }
      })
    },
    thermal(){
      this.map_select = 2
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='water'){
          layer.setVisible(false)
        }
        if(layer.get('name')=='THERMAL'){
          layer.setVisible(true)
        }
        if(layer.get('name')=='photo'){
          layer.setVisible(false)
        }
      })
    },
    photo(){
      this.map_select = 3
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='water'){
          layer.setVisible(false)
        }
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

<style scoped>
.select{
  justify-content: center;
  width:80%;
  left: 10%;
}
</style>