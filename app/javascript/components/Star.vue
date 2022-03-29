<template>
  <span @click="click" v-if="user_name!=='Guest'">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" :class="'star ' + favorite" viewBox="0 0 16 16">
      <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
    </svg>
  </span>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default{
  props:['hotspring_id'],
  data(){
    return{
      fav: false,
      id: 0
    }
  },
  watch:{
    hotspring_id(){
      this.fav_set()
    },
  },
  mounted(){
    this.fav_set()
  },
  computed:{
    ...mapGetters('users',['user_name','favorites']),
    favorite(){
      return this.fav ? 'favorite' : 'unfavorite'
    }
  },
  methods:{
    ...mapActions('users',['Fav','unFav']),
    click(){
      if(!this.fav) this.Fav(this.hotspring_id).then(() => this.fav_set())
      else this.unFav(this.id).then(() => this.fav_set())

      this.fav = !this.fav
    },
    fav_set(){
      this.favorites.forEach(element => {
        if(this.hotspring_id==element.attributes.hotspring_id){
          this.fav = true
          this.id = element.id
        }
      })
    }
  }
}
</script>

<style scoped>
.favorite{
  stroke: black;
  fill: yellow;
}
.unfavorite{
  stroke: black;
  fill: grey;
}
</style>