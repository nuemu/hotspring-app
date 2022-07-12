<template>
  <div
    id="register_popup"
    class="ol-popup"
    style="max-height: 500px;"
  >
    <a
      id="register_popup-closer"
      href="#"
      class="ol-popup-closer"
    />
    <div
      id="register-popup-content"
      ref="popup"
    />
    <p />
    <div class="mb-3 over-flow-scroll">
      <Form @submit="DescriptionSubmit">
        <Field
          v-slot="{ field }"
          v-model="description"
          name="description"
          rules="present"
        >
          <div>
            <textarea
              ref="description"
              rows="1"
              v-bind="field"
              class="form-control form-control-plaintext"
              placeholder="登録理由等記入"
              @input="resizeTextarea"
            />
          </div>
          <ErrorMessage
            name="description"
            style="color:red;"
            as="p"
          />
          <div class="d-flex justify-content-center">
            <button class="btn btn-warning rounded">
              登録
            </button>
          </div>
        </Field>
      </Form>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

import { mapActions } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';

export default{
  components:{
    Form,
    Field,
    ErrorMessage,
  },
  data(){
    return{
      longtitude: '',
      latitude: '',
      description: '',
    }
  },
  methods:{
    ...mapActions('hotsprings', ['postHotspring']),
    DescriptionSubmit(){
      const latlon = this.$refs.popup.children[1].innerText.split(',')
      axios.get('https://aginfo.cgk.affrc.go.jp/ws/rgeocode.php?json&lat='+latlon[1]+'&lon='+latlon[0])
        .then(response => {
          const params = {'description':this.description ,'latitude': latlon[1],'longtitude': latlon[0], prefecture: response.data.result.prefecture.pname}
          this.postHotspring(params)
            .then(() => {
              document.getElementById('register_popup-closer').click()
              this.description=''
            })
            .catch(() => alert('登録失敗しました'))
        })
        .catch(() => alert('登録失敗しました(外部APIエラー)'))
    },
    resizeTextarea(){
      const PADDING_Y = 20;
      const textarea = this.$refs.description
      
      let lineHeight = getComputedStyle(textarea).lineHeight
      lineHeight = lineHeight.replace(/[^-\d\.]/g, '')

      const lines = (textarea.value + '\n').match(/\n/g).length
      if(lines < 5) textarea.style.height = lineHeight * lines + PADDING_Y + 'px'
    }
  }
}
</script>

<style scoped>
@import '../ol/popup.css';
</style>