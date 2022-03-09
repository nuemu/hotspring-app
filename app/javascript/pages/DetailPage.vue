<template>
  <h1>{{hot.name}}</h1>
  <img src="http://abehiroshi.la.coocan.jp/abe-top-20190328-2.jpg">
  <div>lat:{{hot.latitude}}, long:{{hot.longtitude}}</div>
  <p>Description</p>
  <div>{{hot.description}}</div>
  <p>Ratings</p>
  <div>快適性:{{comfort}}</div>
  <div>危険性:{{danger}}</div>
  <p>Comments</p>
  <button @click="submit" class="btn btn-secondary">+</button><input v-model="new_comment">
  <div v-for="comment in comments" :key="comment.id">{{comment.comment}}{{comment.user_id}}</div>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'

export default{
  data(){
    return{
      new_comment: '',
    }
  },
  computed:{
    ...mapGetters('map',['hotspring','hotsprings']),
    ...mapGetters('users',['user_name']),
    hot(){
      return this.hotspring.name ? this.hotspring : {'name':'loading...','latitude':'loading...','longtitude':'loading...','description':'loading...'}
    },
    comments(){
      return this.hotspring.comments ? this.hotspring.comments.slice().reverse() : [{'comment':'loading...'}]
    },
    comfort(){
      if(this.hotspring.posts){
        const confs = this.hotspring.posts.reduce((prev,curr) => prev + curr.water_tempreature, 0)/this.hotspring.posts.length
        return confs
      }else{
        return 0
      }
    },
    danger(){
      if(this.hotspring.posts){
        const confs = this.hotspring.posts.reduce((prev,curr) => prev + curr.water_tempreature, 0)/this.hotspring.posts.length
        return confs
      }else{
        return 0
      }
    }
  },
  created(){
    this.fetchHotspring(this.$route.params.name)
  },
  methods:{
    ...mapMutations('map', ['setHotspring']),
    ...mapActions('map', ['fetchHotspring']),
    ...mapActions('users', ['postComment']),
    submit(){
      this.postComment({'hotspring_id':this.hotspring.id, 'comment':this.new_comment})
    }
  }
}
</script>