<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal"
        @click.self="modal_appearance=false"
      >
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-body">       
              <span class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button
                  type="button"
                  class="btn-close"
                  @click="modal_appearance=false"
                />
              </span>

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
                    @change="StatusSubmit"
                  >
                  <label
                    class="form-check-label"
                    for="radio"
                  >{{ status_all[st] }}</label>
                </div>
              </div>

              <Form @submit="DescriptionSubmit">
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
                    <button class="btn">
                      +
                    </button>
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
        </div>
      </div>
      <div class="modal-backdrop show" />
    </div>
  </transition>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';

export default{
  components:{
    Form,
    Field,
    ErrorMessage,
  },
  data(){
    return{
      user: {'name': '', 'password': ''},
      modal_appearance: false,
    }
  },
  computed:{
    ...mapGetters('hotsprings', ['hotspring', 'status']),
  },
  methods:{
    ...mapActions('hotsprings', ['updateHotspring']),
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