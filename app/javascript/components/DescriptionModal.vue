<template>
<transition name="fade">
  <div v-if="modal_appearance">
    <div class="modal" @click.self="modal_appearance=false">
      <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-body">       
            <span class="d-grid gap-2 d-md-flex justify-content-md-end">
              <button type="button" class="btn-close" @click="modal_appearance=false"></button>
            </span>

            <h3 class="text-center">使い方</h3>

            <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light">
              <h3 class="font-weight-normal">Step1</h3>
              <p class="lead font-weight-normal">温泉のありそうな場所に着目しましょう。</p>
              <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-start bg-white">
                Tips:
                <ul class="list-group-flush">
                  <li>温泉の沸いている場所
                    <ul>
                      <li>温泉街、火山...</li>
                    </ul>
                  </li>
                  <li>地名に注目
                    <ul>
                      <li>湯や硫黄を含む地名(例：湯河原・硫黄谷...)</li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>

            <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light">
              <h3 class="font-weight-normal">Step2</h3>
              <p class="lead font-weight-normal">近くをサーマル画像で調べてみましょう。</p>
              <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-start bg-white">
                Tips:
                <ul class="list-group-flush">
                  <li>設定された温度レンジ内で赤が高温、青が低温を表しています。</li>
                  <li>囲む機能で赤い部分を囲んでおくと切り替え回数が減って楽です。</li>
                  <li>地面が露出している部分は高温になりやすいです。
                    <ul>
                      <li>都市部、農場、禿山、広い河原...</li>
                    </ul>
                  </li>
                  <li>温度レンジは270Kから300Kまでを10K感覚で設定してあります。
                    <ul>
                      <li>直近２ヶ月の平均値です</li>
                      <li>寒冷地では地表も冷えます...</li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>

            <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light">
              <h3 class="font-weight-normal">Step3</h3>
              <p class="lead font-weight-normal">標準地図・航空写真で候補地を絞り込み、登録しましょう。</p>
              <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-start bg-white">
                Tips:
                <ul class="list-group-flush">
                  <li>航空写真で地表の様子を確認しましょう。
                    <ul>
                      <li>高温でも、地表が露出しているだけかもしれません。</li>
                    </ul>
                  </li>
                  <li>標準地図で周辺の情報を確認しましょう。
                    <ul>
                      <li>温泉が沸いているということは、基本的に水が流れているはずです。</li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>

            <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light">
              <h3 class="font-weight-normal">Step4</h3>
              <p class="lead font-weight-normal">登録して、調査しましょう。</p>
              <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-start bg-white">
                Tips:
                <ul class="list-group-flush">
                  <li>現地に行かずとも調べられる場合は多いです。
                    <ul>
                      <li>近くに登山道はありませんか？あれば登山記録を探してみましょう。</li>
                      <li>SNSで情報を探してみましょう。</li>
                    </ul>
                  </li>
                  <li>現地に向かう場所は最新の注意を払ってください。
                    <ul>
                      <li>ガスの溜まりやすい地形ではないか、周辺の遭難情報、熊出没情報...</li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
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