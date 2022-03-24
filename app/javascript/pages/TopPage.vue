<template>
  <Map  ref="map"/>
  <DetailPopup />
</template>

<script>
import Map from '../components/Map.vue'
import DetailPopup from '../components/DetailPopup.vue'
import { mapActions, mapGetters } from 'vuex'

import VisibilityControl from '../ol/ol_control.js'
import { detail_popup } from '../ol/detail_popup.js'

export default{
  components:{
    Map,
    DetailPopup
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring_icons']),
    ...mapGetters('users',['user_name']),
  },
  mounted(){
    detail_popup(this.$refs.map.map)
    this.$refs.map.map.addControl(new VisibilityControl)
    this.fetchHotsprings(1)
  },
  watch:{
    hotspring_icons(){
      this.hotspring_icons.forEach(icons => this.$refs.map.map.addLayer(icons))
    },
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings'])
  }
}
</script>