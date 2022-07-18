<template>
  <td class="thumbnail">
    <img
      v-if="hot.image_url"
      :src="hot.image_url"
      class="img-fluid mh-10"
      style="max-height: 100px"
    >
    <img
      v-else
      src="~camera.svg"
      class="img-fluid mh-10"
      style="height: 100px"
    >
  </td>
</template>

<script>

export default{
  props: ['hot'],
}
</script>