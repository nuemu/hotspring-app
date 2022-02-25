<template>
  <Map />
</template>

<script>
import Map from '../components/Map.vue'

export default{
  components:{
    Map
  },
  data(){
    return{
      hotsprings:[],
    }
  },
  mounted(){
    this.fetchHotsprings()
  },
  methods:{
    fetchHotsprings() {
      this.$axios.get("hotsprings?status=open")
        .then(res => this.hotsprings = res.data)
        .catch(err => console.log(err.status))
    },
  }
}
</script>