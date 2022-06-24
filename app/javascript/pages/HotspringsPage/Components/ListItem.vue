<template>
  <td class="thumbnail">
    <img :src="hot.image_url" class="img-fluid mh-10" style="max-height: 100px">
  </td>
  <td>
    <h3>{{hot.name}} &nbsp;<StatusIcons :status="hot.status" /></h3>
    <div>{{hot.prefecture}}</div>
  </td>
</template>

<script>
import StatusIcons from '../../../components/StatusIcons.vue'

export default{
  props: ['hot'],
  components:{
    StatusIcons
  }
}
</script>

<style>
.thumbnail{
  width: 15%;
  text-align: center;
}
</style>