<template>
<div class="lead">Articles</div>
<div v-if="user_name" class="container-sm">
  <Form @submit="UrlSubmit">
    <div class="input-group">
      <Field ref="url" name="url" v-model="new_url" class="form-control form-control-plaintext" rules="present|url" placeholder="情報提供をお願いします..."/>
      <button class="btn">+</button>
    </div>
    <ErrorMessage name="url" style="color:red;" as="p" />
  </Form>
</div>
<div class="container-sm row">
  <div class="col-sm-6" v-for="article in articles.slice().reverse()" :key="article.attributes.url">
    <Article :id="article.id" :url="article.attributes.url" :user="article.attributes.user.data.attributes.name"/>
    <p></p>
  </div>
</div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';
import Article from '../../components/Article.vue'
import axios from '../../plugins/axios.js'

export default{
  props:['hot'],
  components:{
    Article,
    Form,
    Field,
    ErrorMessage,
  },
  data(){
    return{
      new_url: '',
    }
  },
  computed:{
    ...mapGetters('users', ['user_name']),
    ...mapGetters('hotsprings', ['hotspring', 'articles'])
  },
  methods:{
    ...mapActions('hotsprings',['postArticle']),
    async UrlSubmit(){
      await axios.get('article', {params:{'url': this.new_url}})
        .then(() => {
          this.postArticle({'hotspring_id':this.hotspring.id, 'url':this.new_url})
        })
    },
  }
}
</script>