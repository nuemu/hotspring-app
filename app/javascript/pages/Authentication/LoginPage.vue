<template>
  <div class="text-center w-100 h-75">
    <div class="mx-auto h-100 justify-content-center">
      <h1>ログイン</h1>
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

          <div
            id="nav-tabContent"
            class="tab-content d-grid gap-2 d-md-flex justify-content-md-end"
          >
            <button
              type="button"
              class="btn btn-secondary"
              @click="Submit"
            >
              登録
            </button>
          </div>
        </Form>
      </div>
      <div>登録がお済みでない方は：<a href="/register" class="link-dark">新規登録ページ</a>へ</div>
    </div>
  </div>
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
      error_message: '',
    }
  },
  methods:{
    ...mapActions('users',['login']),
    async Submit(){
      await this.login(this.user)
        .then((res) => {
          if(res) this.$router.push('/hotsprings')
          else this.error_message = '登録失敗しました'
        })
    },
  }
}
</script>