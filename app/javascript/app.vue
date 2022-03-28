<template>
  <Header />
  <router-view>
  </router-view>
  <Footer />
</template>

<script>
import 'bootstrap/scss/bootstrap.scss'
import 'bootstrap/dist/js/bootstrap.js'
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'

export default {
  components:{
    Header,
    Footer
  },
}
</script>

<style>
html, body {
  margin: 0;
  height: 100%;
  min-height: 100%;
}
body {
  display: flex;
  flex-direction: column;
}
#app{
  height:90%;
}
</style>