<template>
  <div>
    <div class="text-end article_user">
      投稿者：{{ user }}
      <span v-if="user == user_name">
        &emsp;<a
          href="#"
          class="link-dark"
          @click.prevent="deleteArticle(id)"
        >x</a>
      </span>
    </div>
    <div
      class="article"
      @click="click"
    >
      <div
        class="card"
        style="min-width: 18rem; height:100%;"
      >
        <img
          :src="img"
          class="card-img-top"
          style="height: 150px;"
        >
        <div class="card-body">
          <h5 class="card-title">
            {{ edit_title }}
          </h5>
          <p class="card-text">
            {{ edit_description }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import axios from '../plugins/axios.js'
export default{
  props:['id','url', 'user'],
  data(){
    return{
      img: '',
      title: '',
      description: '',
    }
  },
  computed:{
    ...mapGetters('users',['user_name']),
    edit_description(){
      if(this.description.length > 60) return this.description.substr(0, 60) + '...'
      return this.description
    },
    edit_title(){
      if(this.title.length > 30) return this.title.substr(0, 30) + '...'
      return this.title
    }
  },
  created(){
    if(this.url !== 'loading...') this.getDom()
  },
  methods:{
    ...mapActions('hotsprings',['deleteArticle']),
    getDom(){
      // CORS対策
      axios.get('article', {params:{'url': this.url}})
        .then(response => {
          const html = new DOMParser().parseFromString(response.data, 'text/html');
          const headEls = (html.head.children)
          Array.from(headEls).map(v => {
              const prop = v.getAttribute('property')
              if (!prop) return;
              switch(prop){
                case 'og:image':
                  this.img = v.getAttribute("content")
                  break
                case 'og:title':
                  this.title = v.getAttribute("content")
                  break
                case 'og:description':
                  this.description = v.getAttribute("content")
                  break
              } 
          })
        })
    },
    click(){
      window.open(this.url, "_blank", "noreferrer")
    }
  }
}
</script>

<style scoped>
.article_user{
  display: flex;
  align-items: center;
}
a{
  text-decoration: none;
}
</style>