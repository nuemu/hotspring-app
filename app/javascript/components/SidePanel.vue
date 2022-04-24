<template>
  <div class="container">
    <Description ref="description" />
    <p />
      <button
        class="btn btn-light btn-outline-warning rounded-circle"
        @click="$refs.description.modal_appearance=true"
        data-bs-toggle="tooltip"
        data-bs-placement="right"
        title="温泉の探し方"
        ref="info"
      >
        <img :src="icons['question']">
      </button>
    <p />
    <div>
      <div class="text-center">
        <h5 class="lead">
          Click
        </h5>
          <button 
            :class="'btn rounded-circle '+options[2]"
            @click="none"
            data-bs-toggle="tooltip"
            data-bs-placement="right"
            title="アイコンをクリックする"
          >
            <img :src="icons['hand']">
          </button>
          <p />
          <button
            :class="'btn rounded-circle '+options[1]"
            @click="draw"
            data-bs-toggle="tooltip"
            data-bs-placement="right"
            title="地図上に多角形を描画する"
            ref="pencil"
          >
            <img :src="icons['pencil']">
          </button>
          <p />
          <button
            :class="'btn rounded-circle '+options[0]"
            @click="register"
            data-bs-toggle="tooltip"
            data-bs-placement="right"
            title="選択した地点を登録する"
            ref="pin"
          >
            <img :src="icons['pin']">
          </button>
      </div>
    </div>
    <p />
    <div>
      <div class="text-center">
        <h5 class="lead">
          Map
        </h5>
        <div
          v-for="(name, index) in names"
          :key="name"
        >
          <button
            :class="'btn rounded-circle '+maps[index]"
            @click="Render(index)"
            :ref="name.layer"
            @mouseover="Mouseover"
            data-bs-toggle="tooltip"
            data-bs-placement="right"
            data-bs-html="true"
            :title="name.description"
          >
            <img :src="icons[name.layer]">
          </button>
          <p />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Interaction } from '../ol/interaction.js'
import { register } from '../ol/register_event.js'
import { detail } from '../ol/detail_event.js'

import Description from './DescriptionModal.vue'
import layer_names from '../ol/layers/layer_names'
import icons from '../ol/layer_icons/icon_loader'

export default{
  components:{
    Description,
  },
  data(){
    return{
      option_select: 2,
      map_select: 0,
      names: layer_names,
      title: 'title',
      message: "sample<div id='sample'></div>",
      icons: icons
    }
  },
  computed:{
    options(){
      let options = []
      for(let i=0; i<3; i++){
        options.push('btn-light btn-outline-warning')
      }
      options[this.option_select]='btn-warning'
      return options
    },
    maps(){
      let maps = []
      for(let i=0; i<layer_names.length; i++){
        maps.push('btn-light btn-outline-warning')
      }
      maps[this.map_select]='btn-warning'
      return maps
    },
    layers(){
      return layer_names.map(element => element.layer)
    }
  },
  methods:{
    ref(index){
      const num = index+1
      return 'item' + num
    },
    none(){
      this.option_select = 2
      const map = this.$parent.$refs.map.map
      Interaction(map, false)
      map.on('click', detail)
      map.un('singleclick', register)
    },
    register(){
      this.option_select = 0
      const map = this.$parent.$refs.map.map
      map.un('click', detail)
      map.on('singleclick', register)

      Interaction(map, false)
    },
    draw(){
      this.option_select = 1
      const map = this.$parent.$refs.map.map
      map.un('click', detail)
      map.un('singleclick', register)

      Interaction(map, true)
    },
    RemoveLayers(){
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')== layer_names[0].layer){
          layer.setVisible(true)
        }
        else if(this.layers.includes(layer.get('name'))) layer.setVisible(false)
      })
    },
    Render(index){
      this.RemoveLayers()
      this.map_select = index
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')== layer_names[index].layer){
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