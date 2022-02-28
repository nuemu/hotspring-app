<template>
<transition name="fade">
  <div v-if="modal_appearance">
    <div class="modal" @click.self="close_modal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title">ログイン/新規登録</h4>
            <button type="button" class="btn-close" @click="close_modal"></button>
          </div>
          <div class="modal-body">

            <p><input v-model="name" id="name" class=”form-control” placeholder="名前を入力してください"></p>
            <input type="password" v-model="password" id="password" class=”form-control” placeholder="パスワードを入力してください">
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" @click="submit">送信</button>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-backdrop show"></div>
  </div>
</transition>
</template>

<script>
export default{
  props:['modal_appearance'],
  data(){
    return{
      name: '',
      password: ''
    }
  },
  mounted(){
    console.log("mount")
  },
  methods:{
    close_modal(){
      this.$parent.modal_appearance=false
    },
    submit(){
      this.$axios.post('authentication?name='+this.name+'&password='+this.password)
        .then(res => {
          this.user = res.data
          console.log(this.user)
        })
        .catch(err => console.log(err.status))
    }
  },
  watch:{
    modal_appearance(){
      console.log(this.modal_appearance)
    }
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
</style>