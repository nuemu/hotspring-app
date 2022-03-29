<template>
<div class="lead">Description</div>
  <div class="container-sm" style="white-space: pre-line;" v-if="status!=='unexplored'">{{hot.description}}</div>
  <div class="container-sm" v-else>
    <Form @submit="DescriptionSubmit">
      <div class="input-group">
        <Field v-model="new_description" v-slot="{ field }" name="description" rules="present">
          <textarea ref="description" rows="1" v-bind="field" class="form-control form-control-plaintext" placeholder="詳細情報欄"></textarea>
          <button class="btn">+</button>
        </Field>
      </div>
      <ErrorMessage name="description" style="color:red;" as="p" />
    </Form>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { Field, Form, ErrorMessage } from 'vee-validate';

export default{
  props:['hot'],
  components:{
    Form,
    Field,
    ErrorMessage,
  },
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