<template>
  <div
    id="detail-popup"
    class="ol-popup"
  >
    <a
      id="detail-popup-closer"
      href="#"
      class="ol-popup-closer"
    />
    <div
      id="detail-popup-content"
      ref="popup"
    >
      <div
        class="container overflow-scroll"
        style="max-height:250px;"
      >
        <h4 class="text-center">
          <a
            :href="'/hotspring/' + coordinate"
            class="link-dark"
          >{{ name }}</a>
        </h4>
        <div class="text-center">
          <img
            v-if="image!=='no image'"
            :src="image"
            class="img-fluid"
            style="height:150px;"
          >
          <div v-else>
            no image
          </div>
        </div>
        <div>
          <a
            :href="google_map"
            class="link-danger"
            target="_blank"
            rel="noopener noreferrer"
          >{{ coordinate }}</a>
        </div>
        <div class="text-center">
          状態:{{ status }}
        </div>
        <div style="white-space: pre-line;">
          {{ hotspring.description }}
        </div>
      </div>
    </div>
    <p />
    <div class="mb-3" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import status from '../ol/hotspring_status.js'

export default{
  computed:{
    ...mapGetters('hotsprings',['hotspring']),
    google_map(){
      return 'https://www.google.com/maps/search/?api=1&query=' + this.hotspring.latitude + ',' + this.hotspring.longtitude
    },
    coordinate(){
      return this.hotspring.longtitude + ',' + this.hotspring.latitude
    },
    name(){
      return this.hotspring.name
    },
    status(){
      return status[this.hotspring.status]
    },
    image(){
      let image
      if(this.hotspring.image_url) image = this.hotspring.image_url
      else image = 'no image'
      return image
    }
  }
}
</script>

<style scoped>
@import '../ol/popup.css';
</style>