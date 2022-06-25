<template>
  <td class="thumbnail">
    <img v-if="hot.image_url" :src="hot.image_url" class="img-fluid mh-10" style="max-height: 100px">
    <img v-else src="~camera.svg" class="img-fluid mh-10" style="height: 100px">
  </td>
  <td class="overflow-hidden overflow-hidden" style="max-height: 100px;">
    <div class="h-10" style="max-height: 100px;">
      <h3 class="text-align-center">{{ hot.name }} &nbsp;<StatusIcons :status="hot.status" /></h3>
      <div>
        {{ hot.prefecture }}
        (<a class="link-dark" @click.stop :href="'https://www.google.com/maps/search/?api=1&query='+hot.latitude+'%2C'+hot.longtitude">
          Google Map
        </a>)
      </div>
      <div style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 500px;">{{ hot.description }}</div>
    </div>
  </td>
</template>

<script>
import StatusIcons from '../../../components/StatusIcons.vue'

export default{
  components:{
    StatusIcons
  },
  props: ['hot'],
}
</script>

<style>
.thumbnail{
  width: 15%;
  text-align: center;
}
</style>