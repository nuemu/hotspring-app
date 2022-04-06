<template>
  <div>
    <div class="container-sm text-center">
      投票：
      <div
        v-for="st in Object.keys(status_all)"
        :key="st"
        class="form-check form-check-inline"
      >
        <input
          id="radio"
          v-model="check"
          class="form-check-input"
          name="status"
          type="radio"
          :value="st"
          @change="StatusSubmit"
        >
        <label
          class="form-check-label"
          for="radio"
        >{{ status_all[st] }}</label>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import status from '../../ol/hotspring_status.js'

export default{
  props:['hot'],
  data(){
    return{
      status_all: status,
      posted: -1,
      check: 0
    }
  },
  computed:{
    ...mapGetters('users', ['posts'])
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
  methods:{
    ...mapActions('hotsprings', ['postPost','updatePost']),
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
  }
}
</script>