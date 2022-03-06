<template>
<transition name="fade">
  <div v-if="modal_appearance">
    <div class="modal" @click.self="modal_appearance=false">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-body">       
            <span class="d-grid gap-2 d-md-flex justify-content-md-end">
              <button type="button" class="btn-close" @click="modal_appearance=false"></button>
            </span>
            <nav>
              <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <button
                  :class="'nav-link '+first_tab"
                  @click="first_tab='active';second_tab=''"
                >
                  ログイン
                </button>
                <button
                  :class="'nav-link '+second_tab"
                  @click="second_tab='active';first_tab=''"
                >
                  新規登録
                </button>
              </div>
            </nav>

            <p class="error_message">{{error_message}}</p>

            <div class="input-group mb-3">
              <span class="input-group-text">@</span>
              <input v-model="user.name" id="name" type="text" class="form-control" placeholder="Username">
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text">PW</span>
              <input v-model="user.password" id="password" type="password" class="form-control" placeholder="Password">
            </div>

            <div class="tab-content d-grid gap-2 d-md-flex justify-content-md-end" id="nav-tabContent">
              <div
                :class="'tab-pane fade show '+first_tab"
              >
                <button type="button" class="btn btn-secondary" @click="login_click()">Login</button>
              </div>
              <div
                :class="'tab-pane fade show '+second_tab"
              >
                <button type="button" class="btn btn-secondary" @click="register_click()">Register</button>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
    <div class="modal-backdrop show"></div>
  </div>
</transition>
</template>

<script>
import { mapActions } from 'vuex'

export default{
  data(){
    return{
      user: {'user_name': '', 'password': ''},
      modal_appearance: false,
      first_tab: 'active',
      second_tab: '',
      error_message: '',
    }
  },
  methods:{
    ...mapActions('users',['login','register']),
    login_click(){
      // 名前とパスワードが登録済み ->　ログイン
      // 名前が被っている場合 -> 名前かパスワードを間違えています
      this.login(this.user)
        .then(() => this.modal_appearance = false)
        .catch((res) => this.error_message='名前かパスワードを間違えています')
    },
    register_click(){
      // 名前とパスワードok ->　ログイン
      // 名前が被っている場合 -> 登録済みの名前です
      this.register(this.user)
        .then(() => this.modal_appearance = false)
        .catch((res) => this.error_message='登録済みの名前です')
    },
  }
}
</script>

<style scoped>
.modal {
  display: block;
}
.fade-enter-active, .fade-leave-active {
  transition: opacity .15s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
.error_message{
  color: red;
}
</style>