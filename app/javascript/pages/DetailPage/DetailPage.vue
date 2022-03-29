<template>
  <p></p>
  <div class="container">
    <button class="btn">情報提供</button>
    <div class="text-center">
      <img :src="img" height="480">
    </div>
    <h1 class="text-center" v-if="status!=='unexplored' || !this.user_name">
      <StatusIcons :status="status"/>
      {{hot.name}}
      <Star :hotspring_id="hot.id"/>
    </h1>
    <h1 class="text-center" v-else>
      <Form @submit="TitleSubmit">
        <StatusIcons :status="status"/>
        <Field ref="title" v-model="new_name" name="title" class="form" rules="present"/>
        <button class="btn">+</button>
        <Star :hotspring_id="hot.id"/>
        <ErrorMessage name="title" style="color:red;" as="p" />
      </Form>
    </h1>
    <div class="text-center">
      <a :href="'https://www.google.com/maps/search/?api=1&query='+hot.latitude+'%2C'+hot.longtitude" class="link-dark" target="_blank" rel="noopener noreferrer">
        lat:{{hot.latitude}}, long:{{hot.longtitude}}
      </a>
    </div>

    <p></p>

    <div class="status wrapper container" v-if="user_name">
      <Status :hot="hot" />
    </div>

    <p></p>

    <div class="description wrapper container">
      <Description :hot="hot" />
    </div>

    <p></p>

    <div class="comment wrapper container">
      <Comment />
    </div>

    <p></p>

    <div class="articles wrapper container">
      <Article />
    </div>

  </div>

  <p></p>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';

import Star from '../../components/Star.vue'
import StatusIcons from '../../components/StatusIcons.vue'

import Status from './Status.vue'
import Description from './Description.vue'
import Comment from './Comment.vue'
import Article from './Article.vue'

export default{
  data(){
    return{
      new_name: '',
      new_url: '',
    }
  },
  components:{
    Article,
    Star,
    StatusIcons,

    Status,
    Description,
    Comment,
    Article,

    Form,
    Field,
    ErrorMessage,
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring', 'hotsprings', 'comments', 'articles', 'status']),
    ...mapGetters('users',['user_name','posts']),
    hot(){
      return this.hotspring ? this.hotspring : {'id':0, 'name':'loading...','latitude':'loading...','longtitude':'loading...','description':'loading...'}
    },
    img(){
      const hotspring_icon = require('hotspring.svg')
      if(this.hotspring){
        if(this.hotspring.image_url) {
          return "http://drive.google.com/uc?export=view&id="+this.hotspring.image_url.split('d/')[1].split('/view')[0]
        }
        return hotspring_icon  
      }
      else return hotspring_icon
    }
  },
  created(){
    this.fetchHotspring(this.$route.params.name)
      .then(() => {
        this.new_name = this.hot.name
        this.new_description = this.hot.description
      })
  },
  methods:{
    ...mapMutations('hotsprings', ['setHotspring']),
    ...mapActions('hotsprings', ['fetchHotspring', 'postArticle', 'postComment', 'deleteComment', 'updateHotspring']),
    TitleSubmit() {
      const params = {'name': this.new_name, 'lat':this.hot.latitude,'lon':this.hot.longtitude}
      this.updateHotspring(params)
      alert('更新しました')
    },
  }
}
</script>

<style scoped>
.form{
  border: none;
  outline: none;
  text-align: center;
}
textarea{
  resize: none;
}
.comment_user{
  display: flex;
  align-items: center;
}
</style>