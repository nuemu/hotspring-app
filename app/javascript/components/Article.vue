<template>
  <div @click="click">
    <iframe :srcdoc="html" sandbox scrolling="no" class="card-img-top"></iframe>
  </div>
</template>

<script>
import axios from '../plugins/axios.js'
export default{
  data(){
    return{
      html: '',
      url: 'https://tori-kara.hatenablog.com/'
    }
  },
  created(){
    this.getDom()
  },
  methods:{
    async getDom(){
      await axios.get('article', {params:{'url': this.url}})
        .then(response => {
          this.html = response.data
        })
    },
    click(){
      window.open(this.url, "_blank", "noreferrer")
    }
  }
}
</script>

<style scoped>
iframe{
  height: 300px;
  pointer-events:none;
}
</style>