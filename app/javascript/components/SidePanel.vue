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
    <ol class="list-group list-group-flush ">
      <li @click="none" :class="'text-center list-group-item list-group-item-action '+options[2]">-</li>
      <li @click="draw" :class="'text-center list-group-item list-group-item-action '+options[1]">囲む</li>
      <li @click="register" :class="'text-center list-group-item list-group-item-action '+options[0]">野湯登録</li>
    </ol>
  </div>
</div>
<p></p>
<div>
  <div class="container">
    <h5 class="lead">Map</h5>
    <ol class="list-group list-group-flush">
      <li v-for="(name, index) in names" :key="name" @click="Render(index)" :class="'text-center list-group-item list-group-item-action '+maps[index]">{{name}}</li>
    </ol>
  </div>
</div>
</template>

<script>
import { Interaction } from '../ol/interaction.js'
import { register } from '../ol/register_event.js'

import Description from './DescriptionModal.vue'
import layer_names from '../ol/layers/layer_names'

export default{
  components:{
    Description
  },
  data(){
    return{
      option_select: 2,
      map_select: 0,
      names: layer_names
    }
  },
  computed:{
    options(){
      let options = ['','','']
      options[this.option_select]='list-group-item-secondary'
      return options
    },
    maps(){
      let maps = []
      for(let i=0; i<layer_names.length; i++){
        maps.push('')
      }
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
    RemoveLayers(){
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')== layer_names[0]){
          layer.setVisible(true)
        }
        else if(layer_names.includes(layer.get('name'))) layer.setVisible(false)
      })
    },
    Render(index){
      this.RemoveLayers()
      this.map_select = index
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')== layer_names[index]){
          layer.setVisible(true)
        }
      })
    },
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