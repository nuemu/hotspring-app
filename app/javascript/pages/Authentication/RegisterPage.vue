<template>
  <div class="text-center w-100 h-75">
    <div class="mx-auto h-100 justify-content-center">
      <h3>新規登録</h3>
      <div class="container">
        <Form @submit="Submit">
          <div class="input-group mb-3">
            <span class="input-group-text">ユーザー名</span>
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
            <span class="input-group-text">パスワード</span>
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

          <div class="input-group mb-3">
            <span class="input-group-text">パスワード(確認)</span>
            <Field
              v-model="user.password_confirmation"
              name="password_confirmation"
              type="password"
              class="form-control"
              rules="confirmed:@password"
              placeholder="Password Confirmation"
            />
          </div>
          <ErrorMessage
            name="password_confirmation"
            style="color:red;"
            as="p"
          />

          <div
            class="tab-content d-grid gap-2 d-md-flex justify-content-md-end"
          >
            <button
              class="btn btn-secondary"
            >
              登録
            </button>
          </div>
        </Form>
        <div
          v-if="error_message!==''"
          style="color: red;"
        >
          {{ error_message }}
        </div>
      </div>
      <div>
        登録済みの方は：<a
          href="/login"
          class="link-dark"
        >ログインページ</a>へ
      </div>
    </div>
  </div>
</template>

<script>
import axios from '../../plugins/axios.js'
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
      user: {'name': '', 'password': '', 'password_confirmation': ''},
      error_message: '',
    }
  },
  methods:{
    ...mapActions('users',['register']),
    async Submit(){
      await this.register(this.user)
        .then((res) => {
          if(res) this.$router.push('/hotsprings')
          else this.error_message = '登録失敗しました'
        })
    },
  }
}
</script>