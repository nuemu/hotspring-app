<template>
  <div>
    <Edit ref="edit" :hot="hot"/>
    <p />

    <div class="container">
      <span class="row">
        <a
          v-if="!hot.fix"
          class="btn col text-end"
          @click="$refs.edit.modal_appearance=true"
        >編集</a>
        <a
          v-else
          :href="google_form"
          class="btn col text-end"
        >情報提供</a>
      </span>

      <Image />
      
      <Title
        ref="title"
        :hot="hot"
      />

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

    <p class="mb-5">&nbsp;</p>
  </div>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'

import Image from './ImageComponent.vue'
import Title from './TitleComponent.vue'
import Status from './StatusComponent.vue'
import Description from './DescriptionComponent.vue'
import Comment from './CommentComponent.vue'
import Article from './ArticleComponent.vue'

import Edit from './EditPage.vue'

export default{
  components:{
    Image,
    Title,
    Status,
    Description,
    Comment,
    Article,  
    Edit,
  },
  data(){
    return{
      google_form: 'https://docs.google.com/forms/d/e/1FAIpQLScrmNcEZt_ATMBAmAr3woHa3TC7Uh1IsPxD89sEYUU5o_VcPQ/viewform?usp=pp_url&entry.639094191='
    }
  },
  computed:{
    ...mapGetters('hotsprings',['hotspring']),
    ...mapGetters('users',['user_name','posts']),
    hot(){
      return this.hotspring ? this.hotspring : {'id':0, 'name':'loading...','latitude':'loading...','longtitude':'loading...','description':'loading...'}
    },
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