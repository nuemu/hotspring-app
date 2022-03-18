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

export default {
  components:{
    Header,
    Footer
  },
}
</script>