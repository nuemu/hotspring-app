<template>
<div class="text-center">
  <img :src="img" height="480">
</div>
<p><input type="file" @change="upLoad"></p>
<button @click="uploadImage">アップロード</button>
</template>

<script>
import { mapGetters } from 'vuex'
import axios from '../../plugins/axios.js'
export default{
  data(){
    return{
      file: null,
    }
  },
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
  methods:{
    upLoad(e){
      this.file = e.target.files[0]
    },
    async uploadImage(){
      let formData = new FormData();
      formData.append("title", 'sample');
      console.log(formData)
      if (this.file !== null) {
        formData.append("image", this.file);
      }
      console.log(formData.get('title'), formData.get('image'))
      await axios.post('image',formData , { "content-type": "multipart/form-data" })
    }
  }
}
</script>