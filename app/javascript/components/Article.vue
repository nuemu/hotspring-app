<template>
  <div @click="click" class="ratio ratio-21x9" style="outline: solid;">
    <iframe :src="url" :srcdoc="html" sandbox scrolling="no" allow="none"></iframe>
  </div>
  <a :href="url">{{title}}</a>
</template>

<script>
import axios from '../plugins/axios.js'
export default{
  props:['url'],
  data(){
    return{
      html: '',
      title: '',
    }
  },
  created(){
    if(this.url !== 'loading...') this.getDom()
  },
  methods:{
    async getDom(){
      // CORS対策
      await axios.get('article', {params:{'url': this.url}})
        .then(response => {
          const html = new DOMParser().parseFromString(response.data, 'text/html');
          const base = document.createElement('base')
          base.href = this.url
          base.target = "_self"
          html.head.prepend(base)
          this.title = html.title

          this.html = new XMLSerializer().serializeToString(html)
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
  pointer-events:none;
}
</style>