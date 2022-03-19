<template>
<AuthenticationModal ref="authentication" />
<FavoriteModal ref="favorite" />
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <router-link to="/" class="navbar-brand">App Icon Here</router-link>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li v-if="user_name && $route.path == '/'" class="nav-item">
          <router-link to="/explore" class="nav-link active">野湯登録</router-link>
        </li>
        <li v-else-if="$route.path!=='/'" class="nav-item">
          <router-link to="/" class="nav-link active">野湯一覧</router-link>
        </li>
        <li v-if="user_name" class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            {{user_name}}
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
            <li><a class="dropdown-item" href="#" @click.prevent="$refs.favorite.modal_appearance = true">お気に入り</a></li>
            <li><a class="dropdown-item" href="#" @click="logout">ログアウト</a></li>
          </ul>
        </li>
        <li v-else class="nav-item">
          <a href="" class="nav-link active" @click.prevent = "$refs.authentication.modal_appearance = true" >ログイン/新規登録</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import AuthenticationModal from './AuthenticationModal.vue'
import FavoriteModal from './FavoriteModal.vue'

export default{
  components:{
    AuthenticationModal,
    FavoriteModal
  },
  computed:{
    ...mapGetters('users',['user_name'])
  },
  methods:{
    ...mapMutations('users',['logout'])
  },
}
</script>