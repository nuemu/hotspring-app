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
    this.fetchHotsprings()
  },
  methods:{
    fetchHotsprings() {
      this.$axios.get('hotsprings?status[]=0&status[]=1&status[]=2&status[]=3')
        .then(res => {
          this.hotsprings = res.data
          const markers = this.generateMarkers()
          var layer = this.generateLayer()
          this.createMap(layer, markers)
        })
        .catch(err => console.log(err.status))
    },
    createMap(layer,markers){
      this.map = L.map('map', {
        center: [35.3622222, 138.7313889],
        zoom: 5,
        layers: [layer],
        zoomControl: false
      })

      const options = {
        collapsed: false,
        position: 'topleft'
      }

      L.control.layers({}, markers, options).addTo(this.map)
    },
    generateLayer(){
      var layer = L.tileLayer('https://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png', {
        attribution: "<a href='https://maps.gsi.go.jp/development/ichiran.html' target='_blank'>地理院タイル</a>"
      })

      return layer
    },
    generateMarkers(){
      var unexplored = []
      var not_exist = []
      var prohibit = []
      var open = []

      this.hotsprings.forEach(element => {
        var marker = L.marker([element.latitude, element.longtitude])
        marker.bindPopup(
          "<b>"+element.name+"</b><br>"
          +element.status+"<br>"
          +element.description+"<br>"
          +"<a href='/'>aaa</a>"
        )
        
        switch(element.status){
          case 'unexplored':{
            unexplored.push(marker)
          }
          case 'not_exist':{
            not_exist.push(marker)
          }
          case 'prohibit':{
            prohibit.push(marker)
          }
          case 'open':{
            open.push(marker)
          }
        }
      })

      const markers = {
        "Unexplored": L.layerGroup(unexplored),
        "Not_exist": L.layerGroup(not_exist),
        "Prohibit": L.layerGroup(prohibit),
        "Open": L.layerGroup(open)
      }

      return markers
    }
  }
}
</script>

<style scoped>
#map{
  min-height: 100vh;
  height: 100%;
}
</style>