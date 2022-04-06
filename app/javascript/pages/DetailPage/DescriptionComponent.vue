<template>
  <div>
    <div class="lead">
      Description
    </div>
    <div
      v-if="status!=='unexplored'"
      class="container-sm"
      style="white-space: pre-line;"
    >
      {{ hot.description }}
    </div>
    <div
      v-else
      class="container-sm"
    >
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
              rows="1"
              v-bind="field"
              class="form-control form-control-plaintext"
              placeholder="詳細情報欄"
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
  props:['hot'],
  data(){
    return{
      new_description: '',
    }
  },
  computed:{
    ...mapGetters('hotsprings', ['status'])
  },
  methods:{
    ...mapActions('hotsprings', ['updateHotspring']),
    DescriptionSubmit(){
      const params = {'description': this.new_description, 'lat':this.hot.latitude,'lon':this.hot.longtitude}
      this.updateHotspring(params)
      alert('更新しました')
    },
  }
}
</script>