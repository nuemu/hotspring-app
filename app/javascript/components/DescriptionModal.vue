<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal overflow-hidden"
        @click.self="modal_appearance=false"
      >
        <div
          :class="modal_class"
          :style="modal_position"
        >
          <div class="modal-left-arrow" v-if="description[index].ref!=='center'" />
          <div class="modal-content border border-0" :style="modal_style">
            <div
              ref="modal"
              class="modal-body"
            >
              <div class="d-grid gap-2 d-md-flex justify-content-between">
                <span class="lead">温泉の探し方{{index+1}}/{{description_number+1}}</span>
                <button
                  type="button"
                  class="btn-close"
                  @click="modal_appearance=false"
                />
              </div>
              <p />
              <div
                class="container"
                style="white-space: pre-wrap;"
                v-html="description[index].description"
              />
              <p />
              <div class="container d-grid gap-2 d-md-flex justify-content-between">
                <a href="" @click.prevent="previous">前へ</a>
                <a href="" @click.prevent="next">次へ</a>
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
import description from './Tutorials.js'

export default{
  data(){
    return{
      index: 0,
      description_number: 8,
      modal_appearance: true,
      target_position: [0,0],
      description: description
    }
  },
  computed:{
    modal_position(){
      if(this.description[this.index].ref == 'center') return ''
      return 'left:'+this.target_position[0]+'px;'+'top:'+this.target_position[1]+'px;'
    },
    modal_class(){
      if(this.description[this.index].ref == 'center') return 'modal-dialog modal-dialog-centered'
      return 'modal-dialog modal-sm position-absolute modal-scrollable m-0 p-0'
    },
    modal_style(){
      if(this.description[this.index].ref == 'center') return 'top: -50px;'
      return ''
    }
  },
  watch:{
    index(){
      if(this.description[this.index].ref !== 'center') this.positionSet()
    }
  },
  created(){
    if(localStorage.getItem('initial')=='done'){
      this.initial = false
      this.modal_appearance = false
    }
  },
  mounted(){
    window.addEventListener("resize", ()=>{
      if(this.modal_appearance) this.positionSet()
    })
  },
  beforeUnmount(){
    window.removeEventListener("resize")
  }, 
  methods:{
    next(){
      this.index = this.index + 1
      if(this.index == this.description_number + 1) this.index = 0 
    },
    previous(){
      this.index = this.index - 1
      if(this.index == -1) this.index = this.description_number
    },
    positionSet(){
      const ref = this.description[this.index].ref

      if(ref !== 'center'){
        var target
        if(ref !== 'pencil' && ref !== 'pin'){
          this.$parent.$refs[ref][0].scrollIntoView(true)
          target = this.$parent.$refs[ref][0].getBoundingClientRect()
        }else{
          this.$parent.$refs[ref].scrollIntoView(true)
          target = this.$parent.$refs[ref].getBoundingClientRect()
        }

        this.target_position[0] = target.right + window.pageXOffset+30
        this.target_position[1] = (target.top+target.bottom)/2 + window.pageYOffset - 85
      }
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
.modal-left-arrow {
  content: "";
  display: block;
  position: relative;
  top: 50px;
  left: -7%;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 25px 35px 25px 0;
  border-color: transparent #ffffff transparent transparent;
}
.modal-right-arrow {
  content: "";
  display: block;
  position: relative;
  top: 50px;
  right: -93%;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 25px 35px 25px 0;
  border-color: transparent #ffffff transparent transparent;
  transform: rotate(180deg);
}
a{
  color:black;
}
</style>