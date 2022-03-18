<template>
  <p></p>
  <div class="container">
    <button class="btn">情報提供</button>
    <div class="text-center">
      <img :src="img" height="640">
    </div>
    <h1 class="text-center">{{hot.name}}<Star :hotspring_id="hot.id"/></h1>
    <div class="text-center">
      <a :href="'https://www.google.com/maps/search/?api=1&query='+hot.latitude+'%2C'+hot.longtitude" class="link-dark" target="_blank" rel="noopener noreferrer">
        lat:{{hot.latitude}}, long:{{hot.longtitude}}
      </a>
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
        <textarea ref="comment" rows="1" @input="input" class="form-control form-control-plaintext" v-model="new_comment" placeholder="コメントを入力してください"></textarea>
        <button @click="submit" class="btn">+</button>
      </div>
      <div class="container-sm" v-for="comment in comments" :key="comment.id" style="white-space: pre-line;">
        {{comment.comment}}
        <div class="text-end">
          {{comment.user.data.attributes.name}}
        </div>
      </div>
    </div>
    <p></p>

    <div class="articles wrapper container">
      <div class="lead">Articles</div>
      <div v-if="user_name" class="input-group container-sm">
        <input type="url" class="form-control form-control-plaintext" v-model="new_url" placeholder="URLを入力してください">
        <button @click="add_url" class="btn">+</button>
      </div>
      <div class="container-sm" v-for="article in articles" :key="article.url">
        <Article :url="article.url" />
        <p></p>
      </div>
    </div>

  </div>

  <p></p>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'
import Article from '../components/Article.vue'
import Star from '../components/Star.vue'

export default{
  data(){
    return{
      new_comment: '',
      new_url: '',
    }
  },
  components:{
    Article,
    Star
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring','hotsprings','comments', 'articles']),
    ...mapGetters('users',['user_name']),
    hot(){
      return this.hotspring ? this.hotspring : {'id':0, 'name':'loading...','latitude':'loading...','longtitude':'loading...','description':'loading...'}
    },
    img(){
      return "http://drive.google.com/uc?export=view&id="+"https://drive.google.com/file/d/1O78Aw8NYaBEbne-ZUCgdwRboSvHS3-AZ/view?usp=sharing".split('d/')[1].split('/view')[0]
    }
  },
  created(){
    this.fetchHotspring(this.$route.params.name)
  },
  methods:{
    ...mapMutations('hotsprings', ['setHotspring']),
    ...mapActions('hotsprings', ['fetchHotspring', 'postArticle', 'postComment']),
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
textarea{
  resize: none;
}
</style>