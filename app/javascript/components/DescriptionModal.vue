<template>
<transition name="fade">
  <div v-if="modal_appearance">
    <div class="modal" @click.self="modal_appearance=false">
      <div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-body">       
            <span class="d-grid gap-2 d-md-flex justify-content-md-end">
              <button type="button" class="btn-close" @click="modal_appearance=false"></button>
            </span>
            工事中...
            <h4>STEP1:温泉のありそうな場所を探しましょう。</h4>
            Hint:温泉の沸いている場所には大抵温泉街があります。火山の近い、川沿いなども狙い目です。
            <h4>STEP2:サーマルで暖かそうな地点を探して印を付けましょう。</h4>
            Hint:都会や、広い河川敷など、草木の少ない箇所は地表温度が高くなりがちです。
            <div>温度レンジは270Kから300Kまでを10K感覚で準備しておきました。</div>
            <h4>STEP3:航空写真や標準地図で状況を確認しましょう。</h4>
            Hint:川沿いに湧いていることが多いです。
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