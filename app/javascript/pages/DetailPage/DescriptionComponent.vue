<template>
  <div>
    <div class="lead">
      Description
    </div>
    <div
      class="container-sm"
      style="white-space: pre-line;"
    >
      {{ hot.description }}
    </div>
  </div>
</template>

<script>
export default{
  props:['hot'],
}
</script>