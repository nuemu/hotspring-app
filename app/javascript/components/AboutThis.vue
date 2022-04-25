<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal"
        @click.self="closeEvent"
      >
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable full modal-fullscreen">
          <div class="modal-content">
            <div class="modal-body bg-light p-0 position-absolute h-100 w-100">

              <div class="text-center d-flex w-100 h-100">
                <div class="col-md-5 p-lg-5 mx-auto my-5 align-self-center">
                  <h1 class="display-4 font-weight-normal fadeLeft">
                    湯tellite
                  </h1>
                  <p class="lead font-weight-normal fadeRight">
                    衛星画像を用いて野湯を探してみましょう。
                  </p>
                  <a
                    class="btn btn-outline-dark fadeIn"
                    href="#"
                    @click="Initial"
                  >
                    始める
                  </a>
                </div>
                <a href="" class="arrow" @click.prevent="next(1)" />
                <img src="~tree1.svg" class="top tree" style="left:0%;">
                <img src="~tree2.svg" class="top tree" style="right:0%;">
                <img src="~cloud_l.svg" class="top cloud" style="left:0%;top:-20%;">
                <img src="~cloud_r.svg" class="top cloud" style="right:0%;">
              </div>

              <div class="vh-100" ref="1">
                <div class="d-flex justify-content-center w-100 h-100">
                  <div class="container text-center p-lg-5 mx-auto my-5 align-self-center">
                    <h1 class="display-4 font-weight-normal">
                      野湯って？
                    </h1>
                    <div>温泉は</div>
                  </div>
                  <a href="" class="arrow" @click.prevent="next(2)" />
                </div>
              </div>

              <div class="vh-100" ref="2">
                <div class="d-flex justify-content-center w-100 h-100">
                  <div class="container text-center p-lg-5 mx-auto my-5 align-self-center">
                    <img src="~adventure.svg" class="img-fluid col-md-5">
                    <p />
                    <h1 class="display-4 font-weight-normal">
                      野湯探しにお困りですか？
                    </h1>
                    <div>極上の温泉体験を追い求め、辿り着いたのは母なる自然。</div>
                    <div>そんな斜め上な好事家のためのサービスです。</div>
                    <p />
                    <div>観光地化への忌避感、安全への懸念...様々な思惑で野湯情報は公開されにくいものです。</div>
                    <div>この状況を踏まえ、湯telliteは単なる情報ポータルサイトとしてではなく、野湯を自らの手で探す浪漫を提供しようと開発されています。</div>
                  </div>
                  <a href="" class="arrow" @click.prevent="next(3)" />
                </div>
              </div>

              <div class="vh-100 text-light" ref="3">
                <div class="d-flex justify-content-center w-100 h-100">
                  <div class="container col-md-5 p-lg-5 mx-auto my-5 align-self-center">
                    <h1 class="display-4 font-weight-normal fadeLeft">
                      湯telliteでできること
                    </h1>
                    <ul class="list-group list-group-flush">
                      <li v-for="(about,index) in abouts" :key="about" class="list-group-item bg-light border-dark">
                        <div v-if="selecting==index" class="container">
                          <a class="link-dark link" href="" @click.prevent="select(index)">{{about.title}}</a>
                          <p />
                          <div class="container-sm" style="white-space: pre-wrap;">
                            {{about.description}}
                          </div>
                        </div>
                        <div v-else class="container">
                          <a class="link-secondary link" href="" @click.prevent="select(index)">{{about.title}}</a>
                        </div>
                      </li>
                    </ul>
                  </div>

                  <div class="container col-md-5 p-lg-5 mx-auto my-5 align-self-center flex-grow-1">
                    <div class="swiper">
                      <div class="swiper-wrapper">
                        <img src="~normal.jpg" class="img-fluid swiper-slide">
                        <img src="~thermal.jpg" class="img-fluid swiper-slide">
                        <img src="~air.jpg" class="img-fluid swiper-slide">
                      </div>
                    </div>
                  </div>
                  <a href="" class="arrow" @click.prevent="next(4)" />
                </div>
              </div>

              <div class="vh-100" ref="4">
                <div class="d-flex justify-content-center w-100 h-100">

                  <div class="container col-md-5 p-lg-5 mx-auto my-5 align-self-center flex-grow-1">
                    <img src="~desc.jpg" class="img-fluid">
                  </div>

                  <div class="container col-md-5 p-lg-5 mx-auto my-5 align-self-center">
                    <h1 class="display-4 font-weight-normal fadeLeft">
                      情報共有しましょう
                    </h1>
                    <div class="container-sm">
                      <div>温泉を見つけましたか？あるいは温泉が存在しないことを確認したかもしれません。もし、よろしければ、情報を提供してください。</div>
                      <div>温泉の状態の投票、コメント機能、記事のリンク機能を設けています。</div>
                    </div>
                  </div>
                  <a href="" class="arrow" @click.prevent="next(5)" />
                </div>
              </div>

              <div class="vh-100" ref="5">
                <div class="d-flex justify-content-center w-100 h-100">
                  <div class="container col-md-5 p-lg-5 mx-auto my-5 align-self-center">
                    <h1 class="display-4 font-weight-normal fadeLeft">
                      野湯探索は危険を伴う活動です
                    </h1>
                    <div class="container-sm">
                      <div>現地調査をする場合は、十分な準備を行なって、注意深く行動するようにしてください。</div>
                      <div>なお、当サイトで得た情報で不利益が生じた場合には、一切の責任を負いません。</div>
                      <p />
                      <div class="text-center">
                        <a
                          class="btn btn-outline-dark"
                          href="#"
                          @click="Initial"
                        >
                          始める
                        </a>
                      </div>
                    </div>
                  </div>

                  <div class="container col-md-5 p-lg-5 mx-auto my-5 align-self-center flex-grow-1">
                    <img src="~danger.svg" class="img-fluid" style="width:80%;">
                  </div>
                  
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
import Swiper from 'swiper/swiper-bundle';
import 'swiper/swiper-bundle.css';
import abouts from './Abouts.js'

export default{
  data(){
    return{
      initial: true,
      modal_appearance: true,
      first_loaded: 0,
      abouts: abouts,
      selecting: 0,
      swiper: null,
    }
  },
  created(){
    if(localStorage.getItem('initial')=='done'){
      this.initial = false
      this.modal_appearance = false
    }
  },
  mounted(){
    this.swiper = new Swiper('.swiper', {
      loop: true,
      autoplay: true,
    })
  },
  methods:{
    Initial(){
      this.modal_appearance = false
      this.initial = false
    },
    closeEvent(){
      if(!this.initial) this.modal_appearance=false
    },
    next(num){
      this.$refs[num].scrollIntoView({behavior: "smooth"})
    },
    select(index){
      this.selecting = index
    }
  }
}
</script>

<style scoped>
.top{
  position:absolute;
  bottom:0%;
  z-index: 10;
}
.cloud{
  width: 30%;
}
.tree{
  height: 50%;
}
.btn-init{
  position: relative;
  bottom: 10%;
  left: -50%;
}
.arrow{
  position: relative;
  display: inline-block;
  left: -50%;
}
.arrow:before{
  opacity: 0.3;
  content: '';
  width: 20px;
  height: 20px;
  border: 0px;
  border-top: solid 2px #000;
  border-right: solid 2px #000;
  -ms-transform: rotate(135deg);
  -webkit-transform: rotate(135deg);
  transform: rotate(135deg);
  position: absolute;
  top: 90%;
  left: -50%;
  margin-top: -4px;
}
.arrow:hover:before{
  opacity: 1;
}
.link{
  text-decoration: none;
}
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