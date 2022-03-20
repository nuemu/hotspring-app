<template>
  <p></p>
  <div class="container">
    <button class="btn">情報提供</button>
    <div class="text-center">
      <img :src="img" height="480">
    </div>
    <h1 class="text-center" v-if="status!=='unexplored'">
      <StatusIcons :status="status"/>
      {{hot.name}}
      <Star :hotspring_id="hot.id"/>
    </h1>
    <h1 class="text-center" v-else>
      <Form @submit="TitleSubmit">
        <Field ref="title" v-model="new_name" name="title" class="form" rules="present"/>
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
      <div class="container-sm text-center">
        投票：
        <div class="form-check form-check-inline" v-for="st in Object.keys(status_all)" :key="st">
          <input @change="StatusSubmit" class="form-check-input" v-model="check" name="status" type="radio" id="radio" :value="st">
          <label class="form-check-label" for="radio">{{status_all[st]}}</label>
        </div>
      </div>
    </div>
    <p></p>

    <div class="description wrapper container">
      <div class="lead">Description</div>
      <div class="container-sm" style="white-space: pre-line;" v-if="status!=='unexplored'">{{hot.description}}</div>
      <div class="container-sm" v-else>
        <Form>
          <div class="input-group">
            <Field v-model="new_description" v-slot="{ field }" name="description" rules="present">
              <textarea ref="description" rows="1" v-bind="field" class="form-control form-control-plaintext" @keydown.enter.shift="DescriptionSubmit" placeholder="詳細はShift+Enterで送信できます"></textarea>
            </Field>
          </div>
          <ErrorMessage name="description" style="color:red;" as="p" />
        </Form>
      </div>
    </div>
    <p></p>

    <div class="comment wrapper container">
      <div class="lead">Comments</div>
      <div v-if="user_name" class="container-sm">
        <Form>
          <div class="input-group">
            <Field v-model="new_comment" v-slot="{ field }" name="comment" rules="present">
              <textarea ref="comment" rows="1" v-bind="field" class="form-control form-control-plaintext" @keydown.enter.shift="CommentSubmit" placeholder="コメントはShift+Enterで送信できます"></textarea>
            </Field>
          </div>
          <ErrorMessage name="comment" style="color:red;" as="p" />
        </Form>
      </div>
      <div class="container-sm" v-for="comment in comments.reverse()" :key="comment.id" style="white-space: pre-line;">
        {{comment.comment}}
        <div class="text-end">
          {{comment.user.data.attributes.name}}
        </div>
      </div>
    </div>
    <p></p>

    <div class="articles wrapper container">
      <div class="lead">Articles</div>
      <div v-if="user_name" class="container-sm">
        <Form @submit="UrlSubmit">
          <div class="input-group">
            <Field ref="url" name="url" v-model="new_url" class="form-control form-control-plaintext" rules="present|url" placeholder="情報提供をお願いします..."/>
          </div>
          <ErrorMessage name="url" style="color:red;" as="p" />
        </Form>
      </div>
      <div class="container-sm" v-for="article in articles.reverse()" :key="article.url">
        <Article :url="article.url" />
        <p></p>
      </div>
    </div>

  </div>

  <p></p>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';

import Article from '../components/Article.vue'
import Star from '../components/Star.vue'
import StatusIcons from '../components/StatusIcons.vue'
import axios from '../plugins/axios.js'
import status from '../ol/hotspring_status.js'

export default{
  data(){
    return{
      new_name: '',
      new_comment: '',
      new_description: '',
      new_url: '',
      status_all: status,
      posted: -1,
      check: 0
    }
  },
  components:{
    Article,
    Star,
    StatusIcons,
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
  watch:{
    hot(){
      this.posts.forEach(post => {
        if(post.attributes.hotspring_id == this.hot.id){
          this.posted = post.id
          this.check = post.attributes.status
        }
      })
      if(this.hot.status !== this.status && this.user_name){
        const params = {'id':this.hot.id, 'status':this.status, 'name':this.hot.name, 'lat':this.hot.latitude,'lon':this.hot.longtitude,'description':this.hot.description}
        this.updateHotspring(params)
      }
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
    ...mapActions('hotsprings', ['fetchHotspring', 'postArticle', 'postComment', 'postPost','updatePost', 'updateHotspring']),
    TitleSubmit() {
      const params = {'name': this.new_name, 'lat':this.hot.latitude,'lon':this.hot.longtitude}
      this.updateHotspring(params)
      alert('投稿しました')
    },
    DescriptionSubmit() {
      const params = {'description': this.new_description, 'lat':this.hot.latitude,'lon':this.hot.longtitude}
      this.updateHotspring(params)
      alert('投稿しました')
    },
    StatusSubmit() {
      // サーバーイジメ？
      const params = {'id':this.posted, 'hotspring_id':this.hot.id, 'status':this.check}
      if(this.posted == -1){
        this.postPost(params)
          .then((res) => this.posted = res)
      }else{
        this.updatePost(params)
      }
    },
    CommentSubmit() {
      this.postComment({'hotspring_id':this.hotspring.id, 'comment':this.new_comment})
      this.$refs.comment.blur()
    },
    async UrlSubmit() {
      await axios.get('article', {params:{'url': this.new_url}})
        .then(() => {
          this.postArticle({'hotspring_id':this.hotspring.id, 'url':this.new_url})
        })
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
</style>