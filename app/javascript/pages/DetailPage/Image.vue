<template>
<div class="text-center">
  <Form @submit="uploadImage" v-if="status=='unexplored'">
    <label>
      <img :src="img" class="img-fluid" style="max-height: 400px;">
      <Field type="file" style="display:none" @change="uploadFile" name="image" rules="file_present" />
    </label>
    <button class="btn">+</button>
    <ErrorMessage name="image" style="color:red;" as="p" />
  </Form>
  <img v-else :src="img" class="img-fluid" style="max-height: 400px;">
</div>
</template>

<script>
import { mapGetters } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';
import axios from '../../plugins/axios.js'

export default{
  components:{
    Form,
    Field,
    ErrorMessage,
  },
  data(){
    return{
      file: null,
    }
  },
  computed:{
    ...mapGetters('hotsprings', ['hotspring', 'status']),
    img(){
      const hotspring_icon = require('hotspring.svg')
      if(this.hotspring.image_url){
        return this.hotspring.image_url
      }
      return hotspring_icon
    }
  },
  methods:{
    Click(){
      this.$refs.file.click()
    },
    uploadFile(e){
      this.file = e.target.files[0]
    },
    async uploadImage(){
      let formData = new FormData();
      formData.append("title", this.hotspring.latitude + ',' + this.hotspring.longtitude);
      if (this.file !== null) {
        formData.append("image", this.file);
      }
      await axios.post('image',formData , { "content-type": "multipart/form-data" })
    }
  }
}
</script>