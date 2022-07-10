<template>
  <Form @input="byGpx">
    <span class="form-group">
      <label for="name" class="form-label"><img src="~plus.svg">(.gpxファイルをアップロードして追加)</label>
      <Field
        id="name"
        type="file"
        ref="name"
        v-model="file"
        name="name"
        class="form-control d-none"
        rules="present"
      />
    </span>
  </Form>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import { Form, Field, ErrorMessage } from 'vee-validate'

export default {
  components: {
    Form,
    Field,
  },
  data(){
    return {
      file: null,
    }
  },
  methods:{
    ...mapActions('users', ['postPost']),
    byGpx(){
      let formData = new FormData();
      if(this.file !== null){
        formData.append("file", this.file[0]);
      }
      this.postPost(formData)
        .then(() => location.reload())
    },
  }
}
</script>