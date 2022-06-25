<template>
  <div>
    <h1
      class="text-center"
    >
      <StatusIcons :status="hot.status" />
      {{ hot.name }}
      <Star :hotspring_id="hot.id" />
    </h1>
    <div class="text-center">
      <a
        :href="'https://www.google.com/maps/search/?api=1&query='+hot.latitude+'%2C'+hot.longtitude"
        class="link-dark"
        target="_blank"
        rel="noopener noreferrer"
      >
        lat:{{ hot.latitude }}, long:{{ hot.longtitude }}
      </a>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'

import Star from '../../components/TheStar.vue'
import StatusIcons from '../../components/StatusIcons.vue'

export default{
  components:{
    Star,
    StatusIcons,
  },
  props:['hot'],
  computed:{
    ...mapGetters('hotsprings', ['hotspring', 'status']),
    ...mapGetters('users', ['user_name']),
  },
}
</script>

<style scoped>
.form{
  border: none;
  outline: none;
  text-align: center;
}
</style>