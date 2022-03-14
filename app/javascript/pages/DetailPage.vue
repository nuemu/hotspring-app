<template>
  <p></p>
  <div class="container">
    <button class="btn btn-white">情報提供</button>
    <img src="http://abehiroshi.la.coocan.jp/abe-top-20190328-2.jpg" class="img-fluid d-block mx-auto">
    <h1 class="text-center">{{hot.name}}</h1>
    <div class="text-center">
      <a :href="'https://www.google.co.jp/maps/@'+hot.latitude+','+hot.longtitude+',15z?hl=ja'" class="link-dark">lat:{{hot.latitude}}, long:{{hot.longtitude}}</a>
    </div>
    <div class="description wrapper container">
      <div class="title">Description</div>
      <div class="container-sm">{{hot.description}}</div>
    </div>
    <div class="rating wrapper container">
      <div class="title">Ratings</div>
      <div class="container-sm row align-items-start">
        <span class="col-sm">快適性：<StarRating :inline="true" :read-only="true" :star-size="20" :rating="comfort"/></span>
        <span class="col-sm">危険性：<StarRating :inline="true" :read-only="true" :star-size="20" :rating="danger" active-color="#9c0000"/></span>
      </div>
      <div class="container-sm" v-if="false">
        <span class="row align-items-start">
        <span class="col-sm">水温：<StarRating :inline="true" :star-size="20" :rating="comfort"/></span>
        <span class="col-sm">経路：<StarRating :inline="true" :star-size="20" :rating="comfort"/></span>
        <span class="col-sm">ガス：<StarRating :inline="true" :star-size="20" :rating="comfort"/></span>
        </span>
      </div>
    </div>
    <div class="comment wrapper container">
      <div class="title">Comments</div>
        <div class="input-group">
          <input class="form" @focus="editing=true" v-model="new_comment" placeholder="コメントを入力してください">
          <button @click="submit" v-if="editing" class="btn btn-white">+</button>
        </div>
        <div class="container-sm comments" v-for="comment in comments" :key="comment.id">
          {{comment.attributes.comment}}
          <span class="text-right">
            -{{comment.attributes.user.data.attributes.name}}
          </span>
        </div>
      </div>
    </div>
  <p></p>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'
import StarRating from 'vue-star-rating'

export default{
  data(){
    return{
      new_comment: '',
      editing: false,
    }
  },
  components:{
    StarRating
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
    comfort(){
      return 3
    },
    danger(){
      return 3
    }
  },
  created(){
    this.fetchHotspring(this.$route.params.name)
  },
  methods:{
    ...mapMutations('hotsprings', ['setHotspring']),
    ...mapActions('hotsprings', ['fetchHotspring']),
    ...mapActions('users', ['postComment']),
    submit(){
      this.postComment({'hotspring_id':this.hotspring.id, 'comment':this.new_comment})
    }
  }
}
</script>

<style scoped>
.wrapper{
  text-indent: 10%;
}
.title{
  font-size: 200%;
  font-weight: lighter;
}
.input-group{
  width: 100%;
  text-align: center;
  position:relative;
  left: 12.5%;
}
.form{
  width: 70%;
  border: none;
  outline: none;
}
.input-group-text{
  background-color:none;
}
.container-sm{
  position: relative;
  left: 2%;
}
.align-items-start{
  position: relative;
  width:60%;
  left: 20%;
}
.btn{
  color: grey;
}
.comments{
  overflow-wrap: anywhere;
}
</style>