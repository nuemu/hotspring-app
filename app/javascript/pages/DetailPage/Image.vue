<template>
<div class="text-center">
  <img :src="img" height="480">
</div>
<button id="authorize_button" style="display: none;">Authorize</button>
<button id="signout_button" style="display: none;">Sign Out</button>
<pre id="content" style="white-space: pre-wrap;"></pre>
</template>

<script>
import { mapGetters } from 'vuex'
export default{
  computed:{
    ...mapGetters('hotsprings', ['hotspring', 'status']),
    img(){
      const hotspring_icon = require('hotspring.svg')
      if(this.hotspring){
        if(this.hotspring.image_url) {
          return "http://drive.google.com/uc?export=view&id="+this.hotspring.image_url.split('d/')[1].split('/view')[0]
        }
      }
      return hotspring_icon
    }
  },
}
</script>