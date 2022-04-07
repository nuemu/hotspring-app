<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal"
        @click.self="closeEvent"
      >
        <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
          <div class="modal-content">
            <div class="modal-body">       
              <span
                v-if="!initial"
                class="d-grid gap-2 d-md-flex justify-content-md-end"
              >
                <button
                  type="button"
                  class="btn-close"
                  @click="closeEvent"
                />
              </span>

              <h3>規約</h3>
              このサービスの利用にあたって、以下の利用規約及び、プライバシーポリシーに同意して頂く必要があります。

              <ul>
                <li>
                  <a
                    href="https://kiyac.app/termsOfService/o4xPtYnY7l9DT56Xwyxo"
                    class="link-dark"
                    target="_blank"
                    rel="noopener noreferrer"
                  >利用規約</a>
                </li>
                <li>
                  <a
                    href="https://kiyac.app/privacypolicy/dzGXXWWOb33BaPHG4JP4"
                    class="link-dark"
                    target="_blank"
                    rel="noopener noreferrer"
                  >プライバシーポリシー</a>
                </li>
              </ul>

              <span
                v-if="initial"
                class="d-grid gap-2 d-md-flex justify-content-md-center"
              >
                <button
                  class="btn btn-outline-secondary"
                  @click="accept"
                >同意</button>
              </span>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-backdrop show" />
    </div>
  </transition>
</template>

<script>
export default{
  data(){
    return{
      modal_appearance: true,
      initial: true,
    }
  },
  created(){
    if(localStorage.getItem('initial') == 'done'){
      this.modal_appearance = false
      this.initial = false
    }
  },
  methods:{
    accept(){
      localStorage.setItem('initial', 'done')
      this.modal_appearance = false
      this.initial = false
    },
    closeEvent(){
      if(!this.initial) this.modal_appearance=false
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
.error_message{
  color: red;
}
</style>g