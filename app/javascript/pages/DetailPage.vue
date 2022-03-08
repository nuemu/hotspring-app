<template>
  <h1>{{name}}</h1>
  <div>lat:{{lat}}, long:{{long}}</div>
  <p>{{desc}}</p>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'

export default{
  data(){
    return{
      hot:{},
    }
  },
  computed:{
    ...mapGetters('map',['hotspring','hotsprings']),
    name(){
      return this.hotspring.name ? this.hotspring.name : 'wait...'
    },
    lat(){
      return this.hotspring.name ? this.hotspring.latitude : 'wait...'
    },
    long(){
      return this.hotspring.name ? this.hotspring.longtitude : 'wait...'
    },
    desc(){
      return this.hotspring.name ? this.hotspring.description : 'wait...'
    }
  },
  created(){
    this.fetchHotspring(this.$route.params.name)
  },
  methods:{
    ...mapMutations('map', ['setHotspring']),
    ...mapActions('map',['fetchHotspring']),
  }
}
</script>