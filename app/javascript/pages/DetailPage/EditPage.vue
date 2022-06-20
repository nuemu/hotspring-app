<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal"
        @click.self="modal_appearance=false"
      >
        <div class="modal-dialog modal-dialog-centered modal-lg">
          <div class="modal-content">
            <div class="modal-body">       
              <span class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button
                  type="button"
                  class="btn-close"
                  @click="modal_appearance=false"
                />
              </span>

              <div class="container">

                <Form
                  @submit="upload"
                  class="text-center"
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
                      rules="file_size|file_present"
                      @change="uploadFile"
                    />
                  </label>
                  <ErrorMessage
                    name="image"
                    style="color:red;"
                    as="p"
                  />

                  <h1
                    class="text-center"
                  >
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
                    <ErrorMessage
                      name="title"
                      style="color:red;"
                      as="p"
                    />
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

                  <div class="container-sm text-center">
                    投票：
                    <div
                      v-for="st in Object.keys(status_all)"
                      :key="st"
                      class="form-check form-check-inline"
                    >
                      <input
                        id="radio"
                        v-model="check"
                        class="form-check-input"
                        name="status"
                        type="radio"
                        :value="st"
                      >
                      <label
                        class="form-check-label"
                        for="radio"
                      >{{ status_all[st] }}</label>
                    </div>
                  </div>

                  <div
                    class="container-sm"
                  >
                    <div class="input-group">
                      <Field
                        v-slot="{ field }"
                        v-model="new_description"
                        name="description"
                        rules="present"
                      >
                        <textarea
                          ref="description"
                          v-bind="field"
                          class="form-control form-control-plaintext"
                          placeholder="詳細情報欄"
                          @input="resizeTextarea"
                        />
                      </Field>
                    </div>
                    <ErrorMessage
                      name="description"
                      style="color:red;"
                      as="p"
                    />
                  </div>

                  <button class="btn btn-primary">
                    更新
                  </button>

                  </Form>

                  <button class="btn btn-danger" @click="deleteHot">
                    削除
                  </button>

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
import { mapActions, mapGetters } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';

import status_icons from '../../ol/status_icons/icon_loader'
import status from '../../ol/hotspring_status.js'

export default{
  props:['hot'],
  components:{
    Form,
    Field,
    ErrorMessage,
  },
  data(){
    return{
      user: {'name': '', 'password': ''},
      modal_appearance: false,
      file: null,
      url: null,
      icons: status_icons,
      new_name: '',
      status_all: status,
      check: 'unexplored',
      new_description: '',
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
    },
  },
  watch:{
    hot:{
      handler(){
        this.new_description = this.hot.description 
        this.new_name = this.hot.name
        this.check = this.hot.status
        if(this.modal_appearance) this.resizeTextarea()
      },
      deep:true
    }
  },
  methods:{
    ...mapActions('hotsprings', ['updateHotspring', 'deleteHotspring']),
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
      const imageParams = {'id': this.hotspring.id, 'image': formData}
      const params = {'status':this.check, 'description': this.new_description, 'name': this.new_name, 'id':this.hot.id }
      this.uploadImage(imageParams)
        .then(() => {
          this.updateHotspring(params)
            .then(() => this.modal_appearance = false)
        })   
    },
    resizeTextarea(){
      const PADDING_Y = 20;
      const textarea = this.$refs.description
      
      let lineHeight = getComputedStyle(textarea).lineHeight
      lineHeight = lineHeight.replace(/[^-\d\.]/g, '')

      const lines = (this.new_description + '\n').match(/\n/g).length
      textarea.style.height = lineHeight * lines + PADDING_Y + 'px'
    },
    deleteHot(){
      this.deleteHotspring(this.hot.id)
        .then(() => this.modal_appearance = false)
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