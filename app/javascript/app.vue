<template>
  <Header />
  <router-view>
  </router-view>
  <Footer />
</template>

<script>
import 'bootstrap/scss/bootstrap.scss'
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'
import { mapActions, mapMutations } from 'vuex'

export default {
  components:{
    Header,
    Footer
  },
  created(){
    const token = localStorage.getItem('token')
    if(token){
      this.set_token(token)
      this.who_is_me()
    }
  },
  methods:{
    ...mapActions('users',['who_is_me']),
    ...mapMutations('users',['set_token'])
  }
}
</script>