<template>
  <div class="container">
    <p />
    <h3 class="text-center mt-5">自己紹介</h3>
    <div
      class="container-sm text-center"
      style="white-space: pre-wrap;"
    >
      {{ introduce }}
    </div>
  </div>
</template>

<script>
export default{
  props:['introduce']
}
</script>