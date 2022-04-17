<template>
  <div class="text-center">
    <Form
      v-if="status=='unexplored'"
      @submit="upload"
    >
      <label>
        <img
          :src="img"
          class="img-fluid"
          style="max-height: 300px;"
        >
        <Field
          type="file"
          style="display:none"
          name="image"
          rules="file_present|file_size"
          @change="uploadFile"
        />
      </label>
      <p v-if="url">
        これはプレビューです。<button class="btn">
          +
        </button>
      </p>
      <ErrorMessage
        name="image"
        style="color:red;"
        as="p"
      />
    </Form>
    <img
      v-else
      :src="img"
      class="img-fluid"
      style="max-height: 300px;"
    >
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
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
      url: null,
    }
  },
  computed:{
    ...mapGetters('hotsprings', ['hotspring', 'status']),
    img(){
      if(this.url) return this.url
      const hotspring_icon = require('hotspring.svg')
      if(this.hotspring.image_url){
        return this.hotspring.image_url
      }
      return hotspring_icon
    }
  },
  methods:{
    ...mapActions('hotsprings', ['uploadImage']),
    Click(){
      this.$refs.file.click()
    },
    uploadFile(e){
      this.file = e.target.files[0]
      this.url = URL.createObjectURL(this.file)
    },
    upload(){
      let formData = new FormData();
      if (this.file !== null) {
        formData.append("image", this.file);
      }
      const params = {'id': this.hotspring.id, 'image': formData}
      this.uploadImage(params)
        .then(() => alert('更新しました'))
    }
  }
}
</script>