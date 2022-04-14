<template>
  <div
    id="register_popup"
    class="ol-popup"
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
    <div class="mb-3">
      <Form @submit="DescriptionSubmit">
        <div class="input-group">
          <Field
            v-slot="{ field }"
            v-model="description"
            name="description"
            rules="present"
          >
            <button class="btn">
              +
            </button>
            <textarea
              ref="description"
              rows="1"
              v-bind="field"
              class="form-control form-control-plaintext"
              placeholder="登録理由等記入"
              @input="resizeTextarea"
            />
          </Field>
        </div>
        <ErrorMessage
          name="description"
          style="color:red;"
          as="p"
        />
      </Form>
    </div>
  </div>
</template>

<script>
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
      const params = {'description':this.description ,'latitude': latlon[1],'longtitude': latlon[0]}
      this.postHotspring(params)
        .then(() => {
          document.getElementById('register_popup-closer').click()
          this.description=''
        })
    },
    resizeTextarea(){
      const PADDING_Y = 20;
      const textarea = this.$refs.description
      
      let lineHeight = getComputedStyle(textarea).lineHeight
      lineHeight = lineHeight.replace(/[^-\d\.]/g, '')

      const lines = (textarea.value + '\n').match(/\n/g).length
      if(lines < 9) textarea.style.height = lineHeight * lines + PADDING_Y + 'px'
    }
  }
}
</script>

<style scoped>
@import '../ol/popup.css';
#register_popup{
  overflow: scroll;
}
</style>