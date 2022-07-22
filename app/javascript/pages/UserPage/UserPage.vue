<template>
  <div class="user-page">
    <Edit ref="edit" />
    <div class="container">
      <span class="row">
        <a
          v-if="user.name === user_name"
          class="btn col text-end"
          @click="$refs.edit.modal_appearance=true"
        >編集</a>
      </span>
      <p />
      <div class="d-flex justify-content-center align-items-center">
        <img
          :src="avatar"
          :class="'rounded-circle border img-thumbnail img-fluid border border-3 border-'+level"
          style="height: 100px"
        >
        <div class="ms-5">
          <h3>{{ user.name }}</h3>
          <div>投稿したコメント数:{{ user.comments.length }}</div>
          <div>共有した記事数:{{ user.articles.length }}</div>
          <div>行ったことのある野湯数:{{ user.hotsprings.length }}</div>
        </div>
      </div>
      <Introduce :introduce="user.introduce" />
      <p />
      <div class="container">
        <div class="d-flex align-items-center">
          <h3
            v-if="user.hotsprings.length !== 0"
            class="text-center"
          >
            行ったことのある野湯
          </h3>
          &nbsp;
          <Add v-if="user_name===$route.params.id && user.hotsprings.length !== 0" />
        </div>
        <table class="table table-hover">
          <tbody>
            <tr
              v-for="hotspring in user.hotsprings"
              :key="hotspring.id"
              @click="pageChange(hotspring)"
            >
              <ListItemThumb :hot="hotspring" />
              <ListItem :hot="hotspring" />
            </tr>
            <tr v-if="user.hotsprings.length === 0 && user_name===$route.params.id">
              <div class="justify-content-center d-flex">
                <Add v-if="user_name===$route.params.id" />
              </div>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import Edit from './Components/EditPage.vue'
import ListItem from '../HotspringsPage/Components/ListItem.vue'
import ListItemThumb from '../HotspringsPage/Components/ListItemThumb.vue'
import Add from './Components/AddHotspring.vue'
import Introduce from './Components/SelfIntroduce.vue'
const avatar = require('person.svg')

export default {
  components:{
    Edit,
    ListItem,
    ListItemThumb,
    Add,
    Introduce,
  },
  data(){
    return {
      user: {name: 'loading...', avatar: avatar, articles: ['loading...'], comments: ['loading...'], hotsprings: ['loading...'], introduce: '未入力', level: 0}
    }
  },
  computed:{
    ...mapGetters('users', ['user_name']),
    avatar(){
      return this.user.avatar ? this.user.avatar : avatar
    },
    level(){
      var color = 'primary'
      if(this.user.level > 0) color = 'info'
      if(this.user.level >= 2) color = 'success'
      if(this.user.level >= 5) color = 'warning'
      if(this.user.level >= 10) color = 'danger'
      return color
    }
  },
  created(){
    if(this.$route.params.id === 'Guest') this.$router.push('/login')
    this.fetchUser(this.$route.params.id)
      .then((response) => {
        if(!response.data) this.$router.push('/')
        this.user.name = response.data.attributes.name
        this.user.level = response.data.attributes.level
        this.user.avatar = response.data.attributes.image_url
        this.user.introduce = response.data.attributes.introduce
        this.user.comments = response.included.filter(data => data.type==='comment').map(data => data.attributes.comment)
        this.user.articles = response.included.filter(data => data.type==='article').map(data => data.attributes.url)
        this.user.hotsprings = response.included.filter(data => data.type==='post').map(data => data.attributes.hotspring.data.attributes)
      })
  },
  methods: {
    ...mapActions('users', ['fetchUser']),
    pageChange(hotspring){
      this.$router.push('/hotspring/'+hotspring.longtitude+','+hotspring.latitude)
    },
  }
}
</script>