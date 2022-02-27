<template>
  <Header />
  <router-view/>
</template>

<script>
import 'bootstrap/scss/bootstrap.scss'
import Header from './components/Header.vue'

export default {
  components:{
    Header
  }
}
</script>