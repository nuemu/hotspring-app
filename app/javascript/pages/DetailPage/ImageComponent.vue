<template>
  <div class="text-center">
    <img
      :src="img"
      class="img-fluid"
      style="height: 250px;"
    >
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default{
  data(){
    return{
      file: null,
      url: null,
    }
  },
  computed:{
    ...mapGetters('hotsprings', ['hotspring', 'status']),
    img(){
      if(this.url) return this.url
      const hotspring_icon = require('camera.svg')
      if(this.hotspring.image_url){
        return this.hotspring.image_url
      }
      return hotspring_icon
    }
  },
}
</script>