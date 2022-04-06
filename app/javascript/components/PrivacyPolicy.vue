<template>
<transition name="fade">
  <div v-if="modal_appearance">
    <div class="modal" @click.self="closeEvent">
      <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-body">       
            <span v-if="!initial" class="d-grid gap-2 d-md-flex justify-content-md-end">
              <button type="button" class="btn-close" @click="closeEvent"></button>
            </span>
            <div class="policy">
              <iframe class="ratio ratio-1x1" style="height:600px;" src="https://kiyac.app/privacypolicy/dzGXXWWOb33BaPHG4JP4"></iframe>
            </div>

            <span v-if="initial" class="d-grid gap-2 d-md-flex justify-content-md-center">
              <button class="btn btn-outline-secondary" @click="accept">同意</button>
            </span>
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
</style>