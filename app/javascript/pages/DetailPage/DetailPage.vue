<template>
  <p />

  <div class="container">
    <a
      :href="google_form"
      class="btn"
    >情報提供</a>

    <Image />
    
    <Title
      ref="title"
      :hot="hot"
    />

    <p />

    <div
      v-if="user_name!=='Guest'"
      class="status wrapper container"
    >
      <Status :hot="hot" />
    </div>

    <p />

    <div class="description wrapper container">
      <Description
        ref="description"
        :hot="hot"
      />
    </div>

    <p />

    <div class="comment wrapper container">
      <Comment />
    </div>

    <p />

    <div class="articles wrapper container">
      <Article />
    </div>
  </div>

  <p />
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'

import Image from './Image.vue'
import Title from './Title.vue'
import Status from './Status.vue'
import Description from './Description.vue'
import Comment from './Comment.vue'
import Article from './Article.vue'

export default{
  components:{
    Image,
    Title,
    Status,
    Description,
    Comment,
    Article,  
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring']),
    ...mapGetters('users',['user_name','posts']),
    hot(){
      return this.hotspring ? this.hotspring : {'id':0, 'name':'loading...','latitude':'loading...','longtitude':'loading...','description':'loading...'}
    },
  },
  data(){
    return{
      google_form: 'https://docs.google.com/forms/d/e/1FAIpQLScrmNcEZt_ATMBAmAr3woHa3TC7Uh1IsPxD89sEYUU5o_VcPQ/viewform?usp=pp_url&entry.639094191='
    }
  },
  created(){
    this.fetchHotspring(this.$route.params.name)
      .then(() => {
        this.$refs.title.new_name = this.hot.name
        this.$refs.description.new_description = this.hot.description
        this.google_form = this.google_form + this.hot.latitude + ',' + this.hot.longtitude
      })
  },
  methods:{
    ...mapActions('hotsprings', ['fetchHotspring']),
  }
}
</script>

<style scoped>
textarea{
  resize: none;
}
.comment_user{
  display: flex;
  align-items: center;
}
</style>