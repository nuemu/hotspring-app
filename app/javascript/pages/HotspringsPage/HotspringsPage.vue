<template>
  <div class="container vh-100 h-100 mt-5">
    <div class="h-75">
      <Map ref="map" />
      <DetailPopup />
    </div>
    <div class="card">
      <div class="card-body">
        <div class="input-group justify-content-center">
          <label
            for="status"
            class="input-group-text"
          >
            <img src="~search.svg">
          </label>
          <input
            id="form1" 
            v-model="keyword"
            type="search"
            class="form-control shadow-none"
            placeholder="キーワード(野湯名・県名等)を入力"
          >
        </div>
        <p />
        <div class="input-group">
          <label
            for="status"
            class="input-group-text"
          >状態</label>
          <select
            id="status"
            v-model="status"
            class="form-control form-select shadow-none"
          >
            <option
              selected
              value=""
            >
              All
            </option>
            <option
              v-for="key in Object.keys(statuses)"
              :key="key"
              :value="key"
            >
              {{ statuses[key] }}
            </option>
          </select>
        </div>
        <div class="tex-algin-center">
          <span
            v-for="key in Object.keys(statuses)"
            :key="key"
          ><StatusIcons :status="key" />：{{ statuses[key] }}&nbsp;</span>
        </div>
      </div>
    </div>
    <p class="mt-3">
      条件に一致した温泉数：{{ filterHotsprings.length }}件
    </p>

    <table class="table table-hover">
      <tbody>
        <tr
          v-for="hotspring in filterHotsprings"
          :key="hotspring.id"
          @click="pageChange(hotspring)"
        >
          <ListItemThumb :hot="hotspring" />
          <ListItem :hot="hotspring" />
        </tr>
        <tr
          class="overflow-hidden"
          style="height: 50px;"
        >
          <p />
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from '../../plugins/axios'
import { mapActions, mapGetters } from 'vuex'

import ListItem from './Components/ListItem.vue'
import ListItemThumb from './Components/ListItemThumb.vue'

import hotspring_status from '../../ol/hotspring_status.js'
import StatusIcons from '../../components/StatusIcons.vue'

import Map from '../../components/TheMap.vue'
import { cluster } from '../../ol/cluster.js'
import { detail_popup } from '../../ol/detail_popup.js'
import { detail } from '../../ol/detail_event.js'
import DetailPopup from '../../components/DetailPopup.vue'

export default{
  components:{
    ListItem,
    ListItemThumb,
    StatusIcons,
    Map,
    DetailPopup,
  },
  data(){
    return {
      keyword: '',
      statuses: hotspring_status,
      status: ''
    }
  },
  computed:{
    ...mapGetters('hotsprings',['hotsprings']),
    filterHotsprings(){
      var hotsprings = []
      if(this.keyword !== ''){
        this.keyword.split(' ').forEach((keyword) => {
          if(keyword !== ''){
            this.hotsprings.forEach(hotspring => {
              if(hotspring.name.indexOf(keyword) !== -1 ||
                hotspring.description.indexOf(keyword) !== -1 ||
                hotspring.prefecture.indexOf(keyword) !== -1 ||
                String(hotspring.latitude).indexOf(keyword) !== -1 ||
                String(hotspring.longtitude).indexOf(keyword) !== -1
              ){
                console.log(hotspring.status, this.status)
                if(this.status === '') hotsprings.push(hotspring)
                else if(hotspring.status === this.status) hotsprings.push(hotspring)
              }
            })
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
    keyword(){
      this.mapIcon()
    },
    status(){
      this.mapIcon()
    },
  },
  created(){
    this.fetchHotsprings(1)
      .then(() => this.mapIcon())
  },
  mounted(){
    if(this.$route.query.keyword){
      this.keyword = this.$route.query.keyword
    }
    if(this.$route.query.lat && this.$route.query.lng){
      this.fetchCloseHotsprings()
    }
    detail_popup(this.$refs.map.map)
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings']),
    pageChange(hotspring){
      this.$router.push('/hotspring/'+hotspring.longtitude+','+hotspring.latitude)
    },
    mapIcon(){
      this.$refs.map.map.un('click', detail)
      this.$refs.map.map.getLayers().forEach(layer => {
        if(layer){
          if(layer.get('name') !== '標準地図') this.$refs.map.map.removeLayer(layer)
        }
      })
      const icons = cluster(this.filterHotsprings)
      icons.forEach(icons => this.$refs.map.map.addLayer(icons))
      this.$refs.map.map.on('click', detail)
    },
    async fetchCloseHotsprings(){
      const response = await axios.get('find?lat='+this.$route.query.lat+'&lng='+this.$route.query.lng)
      if(response.data.length > 0){
        this.keyword = response.data.map(hotspring => {
          hotspring.latitude + ' ' + hotspring.longtitude
        }).join(' ')
      }
      else alert('5km圏内に温泉が見つかりませんでした。')
    }
  }
}
</script>