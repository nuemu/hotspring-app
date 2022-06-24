<template>
  <div class="app_wrapper">
    <Header />
    <router-view ref="view"/>
    <Footer />
  </div>
</template>

<script>
import 'bootstrap/scss/bootstrap.scss'
import 'bootstrap/dist/js/bootstrap.js'
import Header from './components/TheHeader.vue'
import Footer from './components/TheFooter.vue'

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
  overflow: scroll;
}
body {
  display: flex;
  flex-direction: column;
}
#app{
  height:100%;
}
.app_wrapper{
  height:100%;
}
</style>