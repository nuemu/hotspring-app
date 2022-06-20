<template>
  <input type="search" v-model="keyword">
  <div v-for="hotspring in filterHotsprings" key="hotspring.id">{{hotspring}}</div>
</template>

<script>
import axios from 'axios'
import { mapActions, mapGetters } from 'vuex'

export default{
  data(){
    return {
      keyword: '',
    }
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
            hotsprings.push(hotspring)
          }
        })
        return hotsprings
      }

      return this.hotsprings
    }
  },
  created(){
    this.fetchHotsprings(1)
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings']),
  }
}
</script>