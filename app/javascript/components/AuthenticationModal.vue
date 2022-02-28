<template>
<transition name="fade">
   <div v-if="modal_appearance">
     <div class="modal" v-on:click.self="click">
       <div class="modal-dialog">
         <div class="modal-content">
           <div class="modal-header">
             <h4 class="modal-title">タイトルタイトル</h4>
             <button type="button" class="close" v-on:click="click">×</button>
           </div>
           <div class="modal-body">
             <p>ダイアログの中身</p>
             <p>ダイアログの中身</p>
             <p>ダイアログの中身</p>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-primary">フッターのボタンなど</button>
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
  mounted(){
    console.log("mount")
  },
  methods:{
    click(){
      this.$parent.modal_appearance=false
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