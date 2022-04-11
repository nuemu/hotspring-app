<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal"
        @click.self="close"
      >
        <div v-if="index==-1" class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
          <div class="modal-content">
            <div class="modal-body">       
              <span class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button
                  type="button"
                  class="btn-close"
                  @click="modal_appearance=false"
                />
              </span>

              <h3 class="text-center">
                使い方(1/x)
              </h3>

              <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light">
                <h3 class="font-weight-normal">
                  湯telliteをご利用いただきありがとうございます。
                </h3>
                <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-end">
                  次へ
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
      <div class="modal-backdrop show" />
    </div>
  </transition>
</template>

<script>

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle.js'
export default{
  data(){
    return{
      index: -1,
      modal_appearance: false,
      popovers: null,
    }
  },
  watch:{
    modal_appearance(){
      if(this.modal_appearance == true ){
        if(this.index >= 0) this.popovers[this.index].show()
      }
    },
    index(){
      console.log(document.getElementById('sample'))
      console.log(this.index)
      if(this.index !== -1) document.getElementById('sample').addEventListener('click', () => this.close())
    }
  },
  mounted(){
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    this.popovers = popoverTriggerList.map(function (popoverTriggerEl) {
      return new bootstrap.Popover(popoverTriggerEl)
    })
  },
  methods:{
    close(){
      if(this.index >= 0) this.popovers[this.index].hide()
      if(this.popovers.length - 1 > this.index) this.index = this.index + 1
      else this.index = -1
      if(this.index !== -1) this.popovers[this.index].show()
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
#left {
   width: inherit;
   z-index: 1;
   left: 17px;
}
</style>