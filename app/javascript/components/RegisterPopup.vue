<template>
<div id="register_popup" class="ol-popup">
  <a href="#" id="register_popup-closer" class="ol-popup-closer"></a>
  <div id="register-popup-content" ref="popup"></div>
  <p></p>
  <div class="mb-3">
    <Form @submit="DescriptionSubmit">
      <div class="input-group">
        <Field v-model="description" v-slot="{ field }" name="description" rules="present">
          <button class="btn">+</button>
          <textarea ref="description" rows="1" v-bind="field" class="form-control form-control-plaintext" placeholder="登録理由等記入"></textarea>
        </Field>
      </div>
      <ErrorMessage name="description" style="color:red;" as="p" />
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
        .then(() => document.getElementById('popup-closer').click())
    },
  }
}
</script>

<style scoped>
@import '../ol/popup.css';
</style>