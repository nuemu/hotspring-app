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
  watch:{
    hot:{
      handler(){
        this.new_description = this.hot.description 
        this.resizeTextarea()
      },
      deep:true
    }
  },
  computed:{
    ...mapGetters('hotsprings', ['status'])
  },
  methods:{
    ...mapActions('hotsprings', ['updateHotspring']),
    DescriptionSubmit(){
      const params = {'description': this.new_description, 'id':this.hot.id}
      this.updateHotspring(params)
      alert('更新しました')
    },
    resizeTextarea(){
      const PADDING_Y = 20;
      const textarea = this.$refs.description
      
      let lineHeight = getComputedStyle(textarea).lineHeight
      lineHeight = lineHeight.replace(/[^-\d\.]/g, '')

      const lines = (this.new_description + '\n').match(/\n/g).length
      textarea.style.height = lineHeight * lines + PADDING_Y + 'px'
    }
  }
}
</script>