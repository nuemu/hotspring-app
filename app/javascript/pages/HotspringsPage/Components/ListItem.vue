<template>
  <td
    class="overflow-hidden overflow-hidden"
    style="max-height: 100px;"
  >
    <div
      class="h-10"
      style="max-height: 100px;"
    >
      <h3 class="text-align-center">
        {{ hot.name }} &nbsp;<StatusIcons :status="hot.status" />
      </h3>
      <div>
        {{ hot.prefecture }}
        (<a
          class="link-dark"
          :href="'https://www.google.com/maps/search/?api=1&query='+hot.latitude+'%2C'+hot.longtitude"
          @click.stop
        >
          Google Map
        </a>)
      </div>
      <div style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 500px;">
        {{ hot.description }}
      </div>
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