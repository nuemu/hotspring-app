<template>
<transition name="fade">
  <div v-if="modal_appearance">
    <div class="modal" @click.self="modal_appearance=false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-body">       
            <span class="d-grid gap-2 d-md-flex justify-content-md-end">
              <button type="button" class="btn-close" @click="modal_appearance=false"></button>
            </span>
            準備中
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
      modal_appearance: false,
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