<template>
  <div class="text-end article_user">
    投稿者：{{user}}{{id}}
    <span v-if="user == user_name">
      <button class="btn" @click="deleteArticle(id)">x</button>
    </span>
  </div>
  <div @click="click" class="ratio ratio-21x9" style="outline: solid;">
    <iframe :srcdoc="html" sandbox scrolling="no" loading="lazy"></iframe>
  </div>
  <a :href="url">{{title}}</a>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import axios from '../plugins/axios.js'
export default{
  props:['id','url', 'user'],
  data(){
    return{
      html: '',
      title: '',
    }
  },
  computed:{
    ...mapGetters('users',['user_name'])
  },
  created(){
    if(this.url !== 'loading...') this.getDom()
  },
  methods:{
    ...mapActions('hotsprings',['deleteArticle']),
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
.article_user{
  display: flex;
  align-items: center;
}
</style>