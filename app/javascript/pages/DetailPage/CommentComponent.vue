<template>
  <div>
    <div class="lead">
      Comments
    </div>
    <div
      v-if="user_name"
      class="container-sm"
    >
      <Form @submit="CommentSubmit">
        <div class="input-group">
          <Field
            v-slot="{ field }"
            v-model="new_comment"
            name="comment"
            rules="present"
          >
            <textarea
              ref="comment"
              rows="1"
              v-bind="field"
              class="form-control form-control-plaintext"
              placeholder="コメント欄"
            />
            <button class="btn">
              +
            </button>
          </Field>
        </div>
        <ErrorMessage
          name="comment"
          style="color:red;"
          as="p"
        />
      </Form>
    </div>
    <div
      v-for="comment in comments.slice().reverse()"
      :key="comment.id"
      class="container-sm"
    >
      <div class="text-start comment_user">
        投稿者：{{ comment.attributes.user.data.attributes.name }}
        <span v-if="comment.attributes.user.data.attributes.name == user_name">
          &emsp;<a
            href="#"
            class="link-dark"
            @click.prevent="deleteComment(comment.id)"
          >x</a>
        </span>
      </div>
      <div
        class="container-sm"
        style="white-space: pre-line;"
      >
        {{ comment.attributes.comment }}
      </div>
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
  computed:{
    ...mapGetters('hotsprings', ['hotspring','comments']),
    ...mapGetters('users', ['user_name'])
  },
  data(){
    return{
      new_comment: '',
    }
  },
  methods:{
    ...mapActions('hotsprings',['postComment', 'deleteComment']),
    CommentSubmit(){
      this.postComment({'hotspring_id':this.hotspring.id, 'comment':this.new_comment})
      this.$refs.comment.blur()
    },
  }
}
</script>

<style scoped>
a{
  text-decoration: none;
}
</style>