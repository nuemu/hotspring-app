<template>
<Policy ref="policy" />
<About ref="about" />
<footer class="footer bg-light">
  <div class="container">
    <span class="row justify-content-md-center">
      <a class="col-md-auto text-decoration-none link-secondary" href="" @click.prevent="$refs.about.modal_appearance=true">このアプリについて</a>
      <a class="col-md-auto text-decoration-none link-secondary" href="" @click.prevent="$refs.policy.modal_appearance=true">利用規約</a>
      <a class="col-md-auto text-decoration-none link-secondary" href="" @click.prevent>問い合わせ</a>
    </span>
  </div>
</footer>
</template>

<script>
import Policy from './Policy .vue'
import About from './AboutThis.vue'
export default{
  components:{
    Policy,
    About
  }
}
</script>