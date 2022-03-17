<template>
  <p></p>
  <div class="container">
    <button class="btn">情報提供</button>
    <img src="http://abehiroshi.la.coocan.jp/abe-top-20190328-2.jpg" class="img-fluid d-block mx-auto">
    <h1 class="text-center">{{hot.name}}</h1>
    <div class="text-center">
      <a :href="'https://www.google.co.jp/maps/@'+hot.latitude+','+hot.longtitude+',15z?hl=ja'" class="link-dark">lat:{{hot.latitude}}, long:{{hot.longtitude}}</a>
    </div>
    <p></p>

    <div class="description wrapper container">
      <div class="lead">Description</div>
      <div class="container-sm" style="white-space: pre-line;">{{hot.description}}</div>
    </div>
    <p></p>

    <div class="comment wrapper container">
      <div class="lead">Comments</div>
      <div v-if="user_name" class="input-group container-sm">
        <textarea ref="comment" rows="1" @input="input" class="form-control form-control-plaintext" @focus="editing=true" v-model="new_comment" placeholder="コメントを入力してください"></textarea>
        <button @click="submit" v-if="editing" class="btn">+</button>
      </div>
      <div class="container-sm" v-for="comment in comments" :key="comment.id" style="white-space: pre-line;">
        {{comment.attributes.comment}}
        <div class="text-end">
          {{comment.attributes.user.data.attributes.name}}
        </div>
      </div>
    </div>
    <p></p>

    <div class="articles wrapper container">
      <div class="lead">Articles</div>
      <div v-if="user_name" class="input-group container-sm">
        <input type="url" class="form-control form-control-plaintext" @focus="editing_url=true" v-model="new_url" placeholder="URLを入力してください">
        <button @click="add_url" v-if="editing_url" class="btn">+</button>
      </div>
      <div class="container-sm">
        <Article />
      </div>
    </div>

  </div>

  <p></p>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'
import StarRating from 'vue-star-rating'
import Article from '../components/Article.vue'

export default{
  data(){
    return{
      new_comment: '',
      new_url: '',
      editing: false,
      editing_url: false,
    }
  },
  components:{
    StarRating,
    Article
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring','hotsprings']),
    ...mapGetters('users',['user_name']),
    hot(){
      return this.hotspring.name ? this.hotspring : {'name':'loading...','latitude':'loading...','longtitude':'loading...','description':'loading...'}
    },
    comments(){
      // 要改修
      return this.hotspring.comments ? this.hotspring.comments.data.slice().reverse() : [{'comment':'loading...', 'attributes':{'comment':'loading','user':{'data':{'attributes':{'name':'loading...'}}}}}]
    },
  },
  created(){
    this.fetchHotspring(this.$route.params.name)
  },
  methods:{
    ...mapMutations('hotsprings', ['setHotspring']),
    ...mapActions('hotsprings', ['fetchHotspring', 'postArticle']),
    ...mapActions('users', ['postComment']),
    submit(){
      this.postComment({'hotspring_id':this.hotspring.id, 'comment':this.new_comment})
      this.new_comment = ''
    },
    add_url(){
      this.postArticle({'hotspring_id':this.hotspring.id, 'url':this.new_url})
      this.new_url = ''
    },
    input(){
    }
  }
}
</script>

<style scoped>
.form{
  outline: none;
}
</style>