<template>
  <div class="container">
    <p />
    <div class="d-flex justify-content-center align-items-center">
      <img src="http://abehiroshi.la.coocan.jp/abe-top-20190328-2.jpg" class="rounded-circle img-fluid" style="height: 100px">
      <h3>{{user.name}}</h3>
    </div>
    <div class="">
      行った野湯一覧
      <div v-for="hotspring in user.hotsprings" :key="hotspring">
        {{hotspring}}
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data(){
    return {
      user: {name: 'loading...', hotsprings: ['loading...']}
    }
  },
  created(){
    this.fetchUser(this.$route.params.id)
      .then((response) => {
        this.user.name = response.data.attributes.name
        this.user.hotsprings = response.included.map(data => data.attributes.hotspring.data.attributes)
      })
  },
  methods: {
    ...mapActions('users', ['fetchUser'])
  }
}
</script>