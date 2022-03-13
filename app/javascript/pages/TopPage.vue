<template>
  <Map  ref="map"/>
</template>

<script>
import Map from '../components/Map.vue'
import { mapActions, mapGetters } from 'vuex'

export default{
  components:{
    Map
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring_icons']),
    ...mapGetters('users',['user_name']),
  },
  created(){
    if(this.user_name !== '') this.fetchHotsprings(1)
    this.fetchHotsprings(0)
  },
  watch:{
    hotspring_icons(){
      this.$refs.map.map.addLayer(this.hotspring_icons)
    },
    user_name(){
      if(this.user_name !== '') this.fetchHotsprings(1)
      this.fetchHotsprings(0)
    }
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings'])
  }
}
</script>

<style scoped>
#map{
  min-height: 100vh;
  height: 100%;
}
</style>