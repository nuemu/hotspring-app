<template>
  <div class="card">
    <iframe :srcdoc="html" sandbox scrolling="no" class="card-img-top"></iframe>
  </div>
</template>

<script>
import axios from '../plugins/axios.js'
export default{
  data(){
    return{
      html: '',
      url: 'https://getbootstrap.jp/docs/5.0/components/card/'
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