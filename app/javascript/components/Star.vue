<template>
  <span @click="click">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" :class="'star ' + favorite" viewBox="0 0 16 16">
      <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
    </svg>
  </span>
</template>

<script>
import { mapActions } from 'vuex'
export default{
  data(){
    return{
      fav: false,
    }
  },
  computed:{
    favorite(){
      return this.fav ? 'favorite' : 'unfavorite'
    }
  },
  methods:{
    ...mapActions('users',['Fav']),
    click(){
      this.fav = !this.fav
      const lonlat = this.$route.params.name
      this.Fav(lonlat)
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