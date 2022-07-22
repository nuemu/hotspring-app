<template>
  <div>
    <div class="lead">
      Comments
    </div>
    <div
      v-if="user_name!=='Guest'"
      class="mb-1"
    >
      <div
        class="list-group-item rounded d-flex"
      >
        <div>
          <img
            :src="avatar"
            class="img-fluid thumbnail rounded-circle mt-1"
            style="width: 25px; height; 25px"
          >
        </div>
        <div class="w-100 h-100">
          <a
            :href="'/user/'+user_name"
            class="text-start comment_user text-dark d-flex align-items-center"
          >
            <h3 class="m-0">&nbsp;{{ user_name }}</h3>
            <span class="text-secondary">&nbsp;投稿日時：{{ date(Date.now()) }}</span>
          </a>
          <Form @submit="CommentSubmit">
            <div class="input-group h-100">
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
                  @input="resizeTextarea"
                />
              </Field>
              <button
                class="btn btn-warning rounded"
                style="height: 40px;"
              >
                投稿
              </button>
            </div>
            <ErrorMessage
              name="comment"
              style="color:red;"
              as="p"
            />
          </Form>
        </div>
      </div>
    </div>
    <div
      v-for="comment in comments.slice().reverse()"
      :key="comment.id"
      class="mb-1"
    >
      <div
        class="list-group-item rounded d-flex"
      >
        <div>
          <img
            :src="comment.attributes.user.data.attributes.image_url ? comment.attributes.user.data.attributes.image_url : person"
            :class="'img-fluid thumbnail rounded-circle mt-1 border border-2 border-'+level(comment.attributes.user.data.attributes.level)"
            style="width: 25px; height; 25px"
          >
        </div>
        <div class="w-100">
          <a
            :href="'/user/'+comment.attributes.user.data.attributes.name"
            class="text-start comment_user text-dark d-flex align-items-center"
          >
            <h3 class="m-0">&nbsp;{{ comment.attributes.user.data.attributes.name }}</h3>
            <span class="text-secondary">&nbsp;投稿日時：{{ date(comment.attributes.created_at) }}</span>
            <span v-if="comment.attributes.user.data.attributes.name == user_name">
              &emsp;<a
                href="#"
                class="link-dark"
                @click.prevent="deleteComment(comment.id)"
              >x</a>
            </span>
          </a>
          <div
            class="container-sm w-100"
            style="white-space: pre-line; overflow-wrap: anywhere;"
          >
            {{ comment.attributes.comment }}
          </div>
        </div>
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
  data(){
    return{
      person: require('person.svg'),
      new_comment: '',
    }
  },
  computed:{
    ...mapGetters('hotsprings', ['hotspring','comments']),
    ...mapGetters('users', ['user_name', 'avatar'])
  },
  methods:{
    ...mapActions('hotsprings',['postComment', 'deleteComment']),
    CommentSubmit(){
      this.postComment({'hotspring_id':this.hotspring.id, 'comment':this.new_comment})
      this.$refs.comment.blur()
    },
    date(date){
      const day = new Date(date)
      const year = 2000+day.getYear()-100
      return year + '/' + (day.getMonth()+1) + '/' + day.getDate()
    },
    resizeTextarea(){
      const PADDING_Y = 20;
      const textarea = this.$refs.comment
      
      let lineHeight = getComputedStyle(textarea).lineHeight
      lineHeight = lineHeight.replace(/[^-\d\.]/g, '')

      const lines = (textarea.value + '\n').match(/\n/g).length
      textarea.style.height = lineHeight * lines + PADDING_Y + 'px'
    },
    level(level){
      var color = 'primary'
      if(level > 0) color = 'info'
      if(level >= 2) color = 'success'
      if(level >= 5) color = 'warning'
      if(level >= 10) color = 'danger'
      return color
    }
  }
}
</script>

<style scoped>
a{
  text-decoration: none;
}
</style>