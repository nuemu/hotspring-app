<template>
  <h1
    v-if="status!=='unexplored' || !user_name"
    class="text-center"
  >
    <StatusIcons :status="status" />
    {{ hot.name }}
    <Star :hotspring_id="hot.id" />
  </h1>
  <h1
    v-else
    class="text-center"
  >
    <Form @submit="TitleSubmit">
      <StatusIcons :status="status" />
      <Field
        ref="title"
        v-model="new_name"
        name="title"
        class="form"
        rules="present"
      />
      <button class="btn">
        +
      </button>
      <Star :hotspring_id="hot.id" />
      <ErrorMessage
        name="title"
        style="color:red;"
        as="p"
      />
    </Form>
  </h1>
  <div class="text-center">
    <a
      :href="'https://www.google.com/maps/search/?api=1&query='+hot.latitude+'%2C'+hot.longtitude"
      class="link-dark"
      target="_blank"
      rel="noopener noreferrer"
    >
      lat:{{ hot.latitude }}, long:{{ hot.longtitude }}
    </a>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';

import Star from '../../components/TheStar.vue'
import StatusIcons from '../../components/StatusIcons.vue'

export default{
  components:{
    Star,
    StatusIcons,
    Form,
    Field,
    ErrorMessage,
  },
  props:['hot'],
  computed:{
    ...mapGetters('hotsprings', ['hotspring', 'status']),
    ...mapGetters('users', ['user_name']),
    img(){
      const hotspring_icon = require('hotspring.svg')
      if(this.hotspring){
        if(this.hotspring.image_url) {
          return "http://drive.google.com/uc?export=view&id="+this.hotspring.image_url.split('d/')[1].split('/view')[0]
        }
      }
      return hotspring_icon
    }
  },
  data(){
    return{
      new_name: '',
    }
  },
  methods:{
    ...mapMutations('hotsprings', ['setHotspring']),
    ...mapActions('hotsprings', ['updateHotspring']),
    TitleSubmit() {
      const params = {'name': this.new_name, 'lat':this.hot.latitude,'lon':this.hot.longtitude}
      this.updateHotspring(params)
      alert('更新しました')
    },
  }
}
</script>

<style scoped>
.form{
  border: none;
  outline: none;
  text-align: center;
}
</style>