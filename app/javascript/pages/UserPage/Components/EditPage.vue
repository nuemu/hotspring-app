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

              <Form @submit="Submit">
                <div class="form-group">
                  <label for="image" class="form-label">画像(ファイル)</label>
                  <Field
                    type="file"
                    id="image"
                    name="image"
                    class="form-control"
                    rules="file_size|file_present"
                    v-model="file"
                  />
                  <ErrorMessage
                    name="image"
                    style="color:red;"
                    as="p"
                  />
                </div>

                <div class="form-group">
                  <label for="name" class="form-label">ユーザー名</label>
                  <Field
                    id="name"
                    ref="name"
                    v-model="new_name"
                    name="name"
                    class="form-control"
                    rules="present"
                  />
                </div>
                <p />
                <div class="d-flex justify-content-center">
                  <button class="btn btn-primary">登録</button>
                </div>
              </Form>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-backdrop show" />
    </div>
  </transition>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import { Form, Field, ErrorMessage } from 'vee-validate'

export default{
  components: {
    Form,
    Field,
    ErrorMessage
  },
  data(){
    return {
      modal_appearance: false,
      new_name: '',
      file: null,
    }
  },
  computed:{
    ...mapGetters('users', ['user_name'])
  },
  created(){
    this.new_name = this.user_name
  },
  methods: {
    ...mapActions('users', ['updateUser', 'updateImage']),
    getLocation(){
      navigator.geolocation.getCurrentPosition((position)=> {
        //緯度
        let lat = position.coords.latitude;
        //経度
        let lng = position.coords.longitude;

        this.postPost({lat: lat, long: lng})
      });
    },
    async Submit(){
      var params = {id: this.user_name}
      let formData = new FormData();
      formData.append('name', this.new_name)
      if (this.file !== null) {
        formData.append('avatar', this.file[0])
      }
      params.data = formData
      this.updateUser(params)
        .then((response) => {this.$router.push('/user/'+response)})
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