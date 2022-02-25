<template>
  <div id="map"></div>
</template>

<script>
import Leaflet from 'leaflet'
import 'leaflet/dist/leaflet.css'

export default{
  mounted(){
    var map = L.map("map");

    L.tileLayer('https://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png', {
      attribution: "<a href='https://maps.gsi.go.jp/development/ichiran.html' target='_blank'>地理院タイル</a>"
    }).addTo(map);

    map.setView([35.3622222, 138.7313889], 5);
  },
}
</script>

<style scoped>
#map{
  margin-padding: 0;
  min-height: 100vh;
  height: 100%;
  width: 100%;
}
</style>