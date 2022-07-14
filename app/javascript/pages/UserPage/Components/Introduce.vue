<template>
  <div class="container">
    <h3>自己紹介</h3>
    <div class="container-sm" style="white-space: pre-wrap;">{{introduce}}</div>
  </div>
</template>

<script>
export default{
  props:['introduce']
}
</script>