<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal"
        @click.self="modal_appearance=false"
      >
        <div class="modal-dialog modal-dialog-centered modal-xl">
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
                >
                  <div class="container text-center">
                    <img
                      :src="hot.image_url"
                      class="img-fluid"
                      style="height: 100px"
                    >
                    ->
                    <img
                      :src="img"
                      class="img-fluid"
                      style="height: 100px"
                    >
                  </div>
                  <label
                    for="image"
                    class="form-label"
                  >画像(ファイル)</label>
                  <Field
                    id="image"
                    type="file"
                    name="image"
                    class="form-control"
                    rules="file_size|file_present"
                    @change="uploadFile"
                  />
                  <ErrorMessage
                    name="image"
                    style="color:red;"
                    as="p"
                  />

                  <label
                    for="image_url"
                    class="form-label"
                  >画像(URL)</label>
                  <Field
                    id="image_url"
                    ref="image_url"
                    v-model="new_image_url"
                    name="image_url"
                    class="form-control"
                  />

                  <label
                    for="title"
                    class="form-label"
                  >温泉名</label>
                  <Field
                    id="title"
                    ref="title"
                    v-model="new_name"
                    name="title"
                    class="form-control"
                    rules="present"
                  />
                  <ErrorMessage
                    name="title"
                    style="color:red;"
                    as="p"
                  />

                  <label
                    for="latitude"
                    class="form-label"
                  >座標</label>
                  <div class="input-group">
                    <span class="input-group-text">経度</span>
                    <Field
                      id="latitude"
                      ref="latitude"
                      v-model="new_latitude"
                      name="latitude"
                      class="form-control"
                      rules="present"
                    />
                    <span class="input-group-text">経度</span>
                    <Field
                      ref="longtitude"
                      v-model="new_longtitude"
                      name="longtitude"
                      class="form-control"
                      rules="present"
                    />
                  </div>

                  <label>状態</label>
                  <div class="container-sm text-center">
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

                  <label>詳細情報</label>
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
                        class="form-control"
                        placeholder="詳細情報欄"
                        @input="resizeTextarea"
                      />
                    </Field>
                    <ErrorMessage
                      name="description"
                      style="color:red;"
                      as="p"
                    />
                  </div>

                  <div class="form-check">
                    <Field
                      ref="fix"
                      v-model="fix"
                      type="checkbox"
                      class="form-check-input"
                      name="fix"
                      value="true"
                    />
                    <label class="form-check-label">編集固定</label>
                  </div>

                  <div>
                    <button class="btn btn-primary">
                      更新
                    </button>
                    <button
                      class="btn btn-danger"
                      @click.stop="deleteHot"
                    >
                      削除
                    </button>
                  </div>
                </Form>
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
  components:{
    Form,
    Field,
    ErrorMessage,
  },
  props:['hot'],
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
      new_image_url: '',
      new_latitude: '',
      new_longtitude: '',
      fix: false,
    }
  },
  computed:{
    ...mapGetters('hotsprings', ['hotspring', 'status']),
    img(){
      if(this.url) return this.url
      const hotspring_icon = require('camera.svg')
      if(this.new_image_url){
        return this.new_image_url
      }
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
        this.new_latitude = this.hot.latitude
        this.new_longtitude = this.hot.longtitude
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
      this.new_image_url=''
      this.file = e.target.files[0]
      this.url = URL.createObjectURL(this.file)
    },
    upload(){
      let formData = new FormData();
      if (this.file !== null) {
        formData.append("image", this.file);
      }
      const imageParams = {'id': this.hotspring.id, 'image': formData}
      const params = {
        'status':this.check,
        'description': this.new_description,
        'name': this.new_name,
        'id': this.hot.id,
        'fix': this.fix
      }
      if(this.new_image_url !== '') params.image_url = this.new_image_url
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
    },
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