<template>
  <div>
    <Policies ref="policy" />
    <About ref="about" />
    <footer class="footer bg-light">
      <div class="container">
        <span class="row justify-content-md-center">
          <a
            class="col-md-auto text-decoration-none link-secondary"
            href=""
            @click.prevent="$refs.about.modal_appearance=true"
          >このアプリについて</a>
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
  </div>
</template>

<script>
import About from './AboutThis.vue'
import Policies from './ThePolicies.vue'

export default{
  components:{
    Policies,
    About,
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
  position: relative;
  bottom: 0;
  width: 100%;
}
</style>