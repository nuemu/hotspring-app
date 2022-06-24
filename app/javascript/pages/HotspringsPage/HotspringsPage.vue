<template>
  <div class="container">
    <input type="search" v-model="keyword">
    <ul class="list-group list-group-flush">
      <li class="list-group-item" v-for="hotspring in filterHotsprings" key="hotspring.id">
        {{hotspring}}
      </li>
      <li v-if="filterHotsprings.length === 0">No match</li>
    </ul>
  </div>
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
  mounted(){
    if(this.$route.query.keyword){
      this.keyword = this.$route.query.keyword
    }
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotsprings']),
  }
}
</script>