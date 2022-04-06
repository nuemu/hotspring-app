<template>
  <div>
    <AuthenticationModal ref="authentication" />
    <FavoriteModal ref="favorite" />
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container-fluid">
        <router-link
          to="/"
          class="navbar-brand"
        >
          <HotspringIcon />
        </router-link>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon" />
        </button>
        <div
          id="navbarSupportedContent"
          class="collapse navbar-collapse"
        >
          <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
            <li
              v-if="user_name!=='Guest'"
              class="nav-item dropdown"
            >
              <a
                id="navbarDropdownMenuLink"
                class="nav-link dropdown-toggle"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
              >
                {{ user_name }}
              </a>
              <ul
                class="dropdown-menu dropdown-menu-end"
                aria-labelledby="navbarDropdownMenuLink"
              >
                <li>
                  <a
                    class="dropdown-item"
                    href="#"
                    @click.prevent="$refs.favorite.modal_appearance = true"
                  >お気に入り</a>
                </li>
                <li>
                  <a
                    class="dropdown-item"
                    href="#"
                    @click="logout"
                  >ログアウト</a>
                </li>
              </ul>
            </li>
            <li
              v-else
              class="nav-item"
            >
              <a
                href=""
                class="nav-link active"
                @click.prevent="$refs.authentication.modal_appearance = true"
              >ログイン/新規登録</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import AuthenticationModal from './AuthenticationModal.vue'
import FavoriteModal from './FavoriteModal.vue'
import HotspringIcon from './hotspring_icon.vue'

export default{
  components:{
    AuthenticationModal,
    FavoriteModal,
    HotspringIcon
  },
  computed:{
    ...mapGetters('users',['user_name'])
  },
  methods:{
    ...mapMutations('users',['logout'])
  },
}
</script>