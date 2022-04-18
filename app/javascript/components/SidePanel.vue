<template>
  <div>
    <Description ref="description" />
    <HowTo ref="howto" />
    <p />
    <div class="container">
      <ul class="list-group list-group-flush">
        <li
          class="list-group-item list-group-item-action text-center"
          @click="$refs.description.modal_appearance=true"
          data-bs-toggle="tooltip"
          data-bs-placement="right"
          title="機能説明"
        >
          <img :src="icons['info']">
        </li>
        <li
          class="list-group-item list-group-item-action text-center"
          @click="$refs.howto.modal_appearance=true"
          data-bs-toggle="tooltip"
          data-bs-placement="right"
          title="温泉の探し方"
        >
          <img :src="icons['question']">
        </li>
      </ul>
    </div>
    <p />
    <div>
      <div class="container text-center">
        <h5 ref="item2" class="lead">
          Click
        </h5>
        <ol class="list-group list-group-flush ">
          <li
            ref="item3"
            :class="'text-center list-group-item list-group-item-action '+options[2]"
            @click="none"
            data-bs-toggle="tooltip"
            data-bs-placement="right"
            title="アイコンをクリックする"
          >
            <img :src="icons['hand']">
          </li>
          <li
            ref="item4"
            :class="'text-center list-group-item list-group-item-action '+options[1]"
            @click="draw"
            data-bs-toggle="tooltip"
            data-bs-placement="right"
            title="地図上に多角形を描画する"
          >
            <img :src="icons['pencil']">
          </li>
          <li
            ref="item5"
            :class="'text-center list-group-item list-group-item-action '+options[0]"
            @click="register"
            data-bs-toggle="tooltip"
            data-bs-placement="right"
            title="選択した地点を登録する"
          >
            <img :src="icons['pin']">
          </li>
        </ol>
      </div>
    </div>
    <p />
    <div>
      <div class="container text-center">
        <h5 class="lead" ref="item6">
          Map
        </h5>
        <ol class="list-group list-group-flush">
          <li
            v-for="(name, index) in names"
            :key="name"
            :class="'text-center list-group-item list-group-item-action '+maps[index]"
            @click="Render(index)"
            :ref="ref(index)"
            @mouseover="Mouseover"
            data-bs-toggle="tooltip"
            data-bs-placement="right"
            :title="name"
          >
            <img :src="icons[name]">
          </li>
        </ol>
      </div>
    </div>
  </div>
</template>

<script>
import { Interaction } from '../ol/interaction.js'
import { register } from '../ol/register_event.js'
import { detail } from '../ol/detail_event.js'

import Description from './DescriptionModal.vue'
import HowTo from './HowTo.vue'
import layer_names from '../ol/layers/layer_names'
import icons from '../ol/layer_icons/icon_loader'

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle.min.js'

export default{
  components:{
    Description,
    HowTo
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
  mounted(){
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
  },
  methods:{
    ref(index){
      const num = index+7
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