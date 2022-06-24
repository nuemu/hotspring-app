<template>
  <div class="container vh-100 h-100 mt-5">
    <div class="h-50">
      <Map ref="map"/>
      <DetailPopup />
    </div>
    <div class="card">
      <div class="card-body">
        <div class="input-group justify-content-center">
        <label for="status" class="input-group-text"><img src="~search.svg"></label>
          <input type="search" id="form1" class="form-control shadow-none" placeholder="野湯名・県名を入力" v-model="keyword"/>
        </div>
        <p />
        <div class="input-group">
          <label for="status" class="input-group-text">状態</label>
          <select class="form-control form-select shadow-none" v-model="status" id="status">
            <option selected value="">All</option>
            <option v-for="key in Object.keys(statuses)" :value="key" key="key">{{statuses[key]}}</option>
          </select>
        </div>
        <div class="tex-algin-center">
          <span v-for="key in Object.keys(statuses)" key="key"><StatusIcons :status="key"/>：{{statuses[key]}}&nbsp;</span>
        </div>
      </div>
    </div>
    <p class="mt-3">条件に一致した温泉数：{{filterHotsprings.length}}件</p>

    <table class="table table-hover mb-5">
      <tbody>
        <tr class="" v-for="hotspring in filterHotsprings" key="hotspring.id" @click="pageChange(hotspring)">
          <ListItem :hot="hotspring" />
        </tr>
      </tbody>
    </table>
  </div>
  <div v-if="filterHotsprings.length === 0">Not Found</div>
</template>

<script>
import axios from 'axios'
import { mapActions, mapGetters } from 'vuex'

import ListItem from './Components/ListItem.vue'

import hotspring_status from '../../ol/hotspring_status.js'
import StatusIcons from '../../components/StatusIcons.vue'

import Map from '../../components/TheMap.vue'
import { cluster } from '../../ol/cluster.js'
import { detail_popup } from '../../ol/detail_popup.js'
import { detail } from '../../ol/detail_event.js'
import DetailPopup from '../../components/DetailPopup.vue'

export default{
  data(){
    return {
      keyword: '',
      statuses: hotspring_status,
      status: ''
    }
  },
  components:{
    ListItem,
    StatusIcons,
    Map,
    DetailPopup,
  },
  computed:{
    ...mapGetters('hotsprings',['hotsprings']),
    filterHotsprings(){
      var hotsprings = []
      if(this.keyword !== ''){
        this.hotsprings.forEach(hotspring => {
          if(hotspring.name.indexOf(this.keyword) !== -1 ||
            hotspring.prefecture.indexOf(this.keyword) !== -1
          ){
            if(this.status === '') hotsprings.push(hotspring)
            else if(hotspring.status === this.status) hotsprings.push(hotspring)
          }
        })
        return hotsprings
      }

      else if(this.status !== ''){
        this.hotsprings.forEach(hotspring => {
          if(hotspring.status === this.status) hotsprings.push(hotspring)
        })
        return hotsprings
      }

      return this.hotsprings
    }
  },
  watch:{
    filterHotsprings(){
      this.$refs.map.map.un('click', detail)
      this.$refs.map.map.getLayers().forEach(layer => {
        if(layer){
          if(layer.get('name') !== '標準地図') this.$refs.map.map.removeLayer(layer)
        }
      })
      const icons = cluster(this.filterHotsprings)
      icons.forEach(icons => this.$refs.map.map.addLayer(icons))
      this.$refs.map.map.on('click', detail)
    }
  },
  created(){
    this.fetchHotsprings(1)
  },
  mounted(){
    if(this.$route.query.keyword){
      this.keyword = this.$route.query.keyword
    }
    detail_popup(this.$refs.map.map)
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings']),
    pageChange(hotspring){
      
      this.$router.push('/hotspring/'+hotspring.longtitude+','+hotspring.latitude)
    }
  }
}
</script>