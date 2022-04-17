<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal"
        @click.self="closeEvent"
      >
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable full modal-fullscreen">
          <div class="modal-content">
            <div class="modal-body bg-dark p-0 position-absolute h-100 w-100">
              <div class="text-center bg-light top d-flex">
                <div class="col-md-5 p-lg-5 mx-auto my-5 text-light align-self-center">
                  <h1 class="display-4 font-weight-normal fadeLeft">
                    湯tellite
                  </h1>
                  <p class="lead font-weight-normal fadeRight">
                    衛星画像を用いて野湯を探してみましょう。
                  </p>
                  <a
                    class="btn btn-outline-light fadeIn"
                    href="#"
                    @click="Initial"
                  >
                    始める♨︎
                  </a>
                </div>
                <a href="" class="arrow" @click.prevent="next" />
              </div>

              <div class="second text-light" ref="1">
                <div class="d-flex justify-content-center w-100 h-100">
                  <div class="container col-md-5 p-lg-5 mx-auto my-5 align-self-center">
                    <h1 class="display-4 font-weight-normal fadeLeft">
                      湯telliteでできること
                    </h1>
                    <ul class="list-group list-group-flush">
                      <li v-for="(about,index) in abouts" :key="about" class="list-group-item bg-dark border-light text-light">
                        <div v-if="selecting==index" class="container">
                          <a class="link-light link" href="" @click.prevent="select(index)">{{about.title}}</a>
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
  computed:{
    first_appearance(){
      if(this.first_loaded > 1) return 'fadeIn'
      return 'invisible'
    },
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
    next(){
      this.$refs[1].scrollIntoView({behavior: "smooth"})
    },
    select(index){
      this.selecting = index
    }
  }
}
</script>

<style scoped>
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
  border-top: solid 2px #FFF;
  border-right: solid 2px #FFF;
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
.second{
  height:100vh;
  height: 100%;
  width: 100%;
}
.link{
  text-decoration: none;
}
.top{
  background: linear-gradient(rgba(0, 0, 0, .4),  rgba(0, 0, 0, .4)),  url("https://www.nasa.gov/sites/default/files/ldcm.jpg"); 
  /* 画像の位置やサイズの調整 */
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  height:100vh;
  height: 100%;
  width: 100%;
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