<template>
<transition name="fade">
  <div v-if="modal_appearance">
    <div class="modal" @click.self="closeEvent">
      <div :class="'modal-dialog modal-dialog-centered modal-dialog-scrollable ' + modal_size">
        <div class="modal-content">
          <div class="modal-body">

            <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light">
              <div class="col-md-5 p-lg-5 mx-auto my-5">
                <h1 class="display-4 font-weight-normal fadeLeft">湯tellite</h1>
                <p class="lead font-weight-normal fadeRight">野湯探しのお供に...</p>
                <a :class="'btn btn-outline-secondary ' + first_appearance" href="#" @click="Initial">始める♨︎</a>
              </div>
            </div>

            <div :class="'d-md-flex flex-md-equal w-100 my-md-3 pl-md-3 ' + first_appearance">
              <div class="bg-dark mr-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center text-white overflow-hidden">
                <div class="my-3 py-3">
                  <h2 class="display-5">衛星画像で</h2>
                  <img @load="first_loaded+=1" src="https://drive.google.com/uc?id=1SHVf5Rsnz0hbVihXRkbSX30jQg8xuBPx" class="img-fluid">
                </div>
              </div>
              <div class="bg-light mr-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center overflow-hidden">
                <div class="my-3 p-3">
                  <h2 class="display-5">航空写真で</h2>
                  <img @load="first_loaded+=1" src="https://drive.google.com/uc?id=1UJnJJ8nV9pr-exqFVvPJTUMuI8P6CMIu" class="img-fluid">
                </div>
              </div>
            </div>

            <div :class="'position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light ' + first_appearance">
              <p class="lead font-weight-normal fadeRight">野湯の候補地を探しましょう！ </p>
              <p class="lead font-weight-normal fadeRight">発見があるかも...</p>
              <img src="https://drive.google.com/uc?id=1EE2K67IQtZj0TYb4PWk5e1V7MKuXBWXO" class="card-img">
            </div>

            <div :class="'position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center text-white bg-dark ' + first_appearance">
              <p class="lead font-weight-normalt">野湯探索は時に非常に危険な活動となり得ます。</p>
              <p class="lead font-weight-normalt">探索される場合は、十分な下調べ、準備、訓練を行なってください</p>
              <p class="lead font-weight-normalt">なお、本サービスに起因してユーザーに生じたあらゆる損害について、一才の責任を負いません。</p>
              <p class="lead font-weight-normalt">
                <a :class="'btn btn-outline-light ' + first_appearance" href="#" @click="Initial">始める♨︎</a>
              </p>
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
      initial: true,
      modal_appearance: true,
      first_loaded: 0,
    }
  },
  created(){
    if(localStorage.getItem('initial')=='done'){
      this.initial = false
      this.modal_appearance = false
    }
  },
  computed:{
    first_appearance(){
      if(this.first_loaded > 1) return 'fadeIn'
      return 'invisible'
    },
    modal_size(){
      if(!this.initial) return 'modal-xl'
      return 'modal-fullscreen'
    }
  },
  methods:{
    Initial(){
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

.invisible{
  display: none;
}

.fadeIn{
animation-name:fadeInAnime;
animation-duration:1s;
animation-fill-mode:forwards;
opacity:0;
}

@keyframes fadeInAnime{
  from {
    opacity: 0;
  }

  to {
    opacity: 1;
  }
}

.fadeLeft{
animation-name:fadeLeftAnime;
animation-duration:1s;
animation-fill-mode:forwards;
opacity:0;
}

@keyframes fadeLeftAnime{
  from {
    opacity: 0;
	transform: translateX(-100px);
  }

  to {
    opacity: 1;
	transform: translateX(0);
  }
}

.fadeRight{
animation-name:fadeRightAnime;
animation-duration:1s;
animation-fill-mode:forwards;
opacity:0;
}

@keyframes fadeRightAnime{
  from {
    opacity: 0;
	transform: translateX(100px);
  }

  to {
    opacity: 1;
	transform: translateX(0);
  }
}
</style>