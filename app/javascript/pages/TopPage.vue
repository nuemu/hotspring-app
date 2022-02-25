<template>
  <div id="map"></div>
</template>

<script>
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'

export default{
  data(){
    return{
      hotsprings:[],
      map:'',
    }
  },
  created(){
    L.Icon.Default.imagePath = '.'
    L.Icon.Default.mergeOptions({
      iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
      iconUrl: require('leaflet/dist/images/marker-icon.png'),
      shadowUrl: require('leaflet/dist/images/marker-shadow.png'),
    })
  },
  mounted(){
    this.map = this.CreateMap();
    this.fetchHotsprings();
  },
  methods:{
    fetchHotsprings() {
      this.$axios.get('hotsprings?status=open')
        .then(res => {
          this.hotsprings = res.data
          this.generateMarkers()
        })
        .catch(err => console.log(err.status))
    },
    CreateMap(){
      var map = L.map("map");

      L.tileLayer('https://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png', {
        attribution: "<a href='https://maps.gsi.go.jp/development/ichiran.html' target='_blank'>地理院タイル</a>"
      }).addTo(map);

      map.setView([35.3622222, 138.7313889], 5);

      return map
    },
    generateMarkers(){
      this.hotsprings.forEach(element => {
        console.log(element)
        var marker = L.marker([element.latitude, element.longtitude]).addTo(this.map)
        marker.bindPopup(
          "<b>"+element.name+"</b><br>"
          +element.description+"<br>"
          +"<a href='/'>aaa</a>"
        )
      })
    }
  }
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