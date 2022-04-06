<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal"
        @click.self="modal_appearance=false"
      >
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-body">       
              <span class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button
                  type="button"
                  class="btn-close"
                  @click="modal_appearance=false"
                />
              </span>
              <nav>
                <div
                  id="nav-tab"
                  class="nav nav-tabs"
                  role="tablist"
                >
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

              <p class="error_message">
                {{ error_message }}
              </p>

              <Form @submit="Submit">
                <div class="input-group mb-3">
                  <span class="input-group-text">@</span>
                  <Field
                    v-model="user.name"
                    name="name"
                    type="text"
                    class="form-control"
                    placeholder="Username"
                    rules="present"
                  />
                </div>

                <ErrorMessage
                  name="name"
                  style="color:red;"
                  as="p"
                />
                <div class="input-group mb-3">
                  <span class="input-group-text">PW</span>
                  <Field
                    v-model="user.password"
                    name="password"
                    type="password"
                    class="form-control"
                    rules="minimum"
                    placeholder="Password"
                  />
                </div>
                <ErrorMessage
                  name="password"
                  style="color:red;"
                  as="p"
                />

                <div
                  id="nav-tabContent"
                  class="tab-content d-grid gap-2 d-md-flex justify-content-md-end"
                >
                  <button
                    type="button"
                    class="btn btn-secondary"
                    @click="Submit"
                  >
                    Submit
                  </button>
                </div>
              </Form>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-backdrop show" />
    </div>
  </transition>
</template>

<script>
import { mapActions } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';

export default{
  components:{
    Form,
    Field,
    ErrorMessage,
  },
  data(){
    return{
      user: {'name': '', 'password': ''},
      modal_appearance: false,
      first_tab: 'active',
      second_tab: '',
      error_message: '',
    }
  },
  methods:{
    ...mapActions('users',['login','register']),
    async Submit(){
      if(this.first_tab=='active'){
        await this.login(this.user)
          .then((res) => {
            if(res) location.reload()
            else this.error_message = 'ログイン失敗しました'
          })
      }
      else{
        await this.register(this.user)
          .then((res) => {
            if(res) location.reload()
            else this.error_message = '登録失敗しました'
          })
      }
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