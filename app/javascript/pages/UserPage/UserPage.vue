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
        <img :src="avatar" class="rounded-circle border img-thumbnail img-fluid" style="height: 100px">
        <h3>{{user.name}}</h3>
      </div>
      <div class="">
        <div class="d-flex align-items-center">
          <h3>野湯一覧</h3>
          &nbsp;
          <Add />
        </div>
        <table class="table table-hover">
          <tbody>
            <tr v-for="hotspring in user.hotsprings" :key="hotspring.id" @click="pageChange(hotspring)">
              <ListItem :hot="hotspring" />
            </tr>
            <tr class="overflow-hidden" style="height: 50px;">
              <p />
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
import ListItem from './Components/ListItem.vue'
import Add from './Components/AddHotspring.vue'
const avatar = require('person.svg')

export default {
  data(){
    return {
      user: {name: 'loading...', avatar: avatar, hotsprings: ['loading...']}
    }
  },
  components:{
    Edit,
    ListItem,
    Add
  },
  computed:{
    ...mapGetters('users', ['user_name']),
    avatar(){
      return this.user.avatar ? this.user.avatar : avatar
    },
  },
  created(){
    this.fetchUser(this.$route.params.id)
      .then((response) => {
        this.user.name = response.data.attributes.name
        this.user.avatar = response.data.attributes.image_url
        this.user.hotsprings = response.included.map(data => data.attributes.hotspring.data.attributes)
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