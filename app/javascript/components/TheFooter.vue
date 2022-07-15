<template>
    <Policies ref="policy" />
    <footer class="footer bg-light">
      <div class="container">
        <span class="row justify-content-md-center">
          <router-link to="/howto">使い方</router-link>
          <a
            class="col-md-auto text-decoration-none link-secondary"
            href=""
            @click.prevent="$refs.policy.modal_appearance=true"
          >利用規約・プライバシーポリシー
          </a>
          <a
            class="col-md-auto text-decoration-none link-secondary"
            :href="form"
          >問い合わせ</a>
        </span>
      </div>
    </footer>
</template>

<script>
import Policies from './ThePolicies.vue'

export default{
  components:{
    Policies
  },
  data(){
    return{
      form: 'https://docs.google.com/forms/d/e/1FAIpQLScFcIGyhC8BUTN7FEKCO4x5MlIVIps5CMUrWADWK0lyVow5VA/viewform?usp=sf_link'
    }
  }
}
</script>

<style scoped>
.footer {
  width: 100%;
  position: absolute;
  bottom: 0;
}
</style>