<template>
<AuthenticationModal ref="authentication" />
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <router-link to="/" class="navbar-brand">App Icon Here</router-link>
    <button class="navbar-toggler" type="button">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li v-if="user_name" class="nav-item">
          <a href="" class="nav-link active" @click.prevent = "logout" >{{user_name}}</a>
        </li>
        <li v-else class="nav-item">
          <a href="" class="nav-link active" @click.prevent = "$refs.authentication.modal_appearance = true" >ログイン/新規登録</a>
        </li>
      </ul>
      <ul class="navbar-nav mr-auto mb-2 mb-lg-0">
        <li v-if="user_name" class="nav-item">
          <router-link to="/explore" class="nav-link active">野湯探索</router-link>
        </li>
      </ul>
    </div>
  </div>
</nav>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import AuthenticationModal from './AuthenticationModal.vue'

export default{
  components:{
    AuthenticationModal,
  },
  computed:{
    ...mapGetters('users',['user_name'])
  },
  methods:{
    ...mapMutations('users',['logout'])
  }
}
</script>