import Tile from 'ol/layer/Tile'
import  TileWMS  from 'ol/source/TileWMS'

const thermal = new Tile({
  name: 'thermal_low',
  opacity: 0.4,
  source: new TileWMS({
    url: "https://services-uswest2.sentinel-hub.com/ogc/wms/" + process.env.VUE_APP_THERMAL270,
    params: {"urlProcessingApi":"https://services-uswest2.sentinel-hub.com/ogc/wms/8439a8a1-9c27-4ce5-9398-4991965607db","maxcc":20,"minZoom":10,"maxZoom":10,"preset":"THERMAL","layers":"THERMAL","time":"2021-09-01/2022-03-12"},
    serverType: 'geoserver',
    transition: 0,
    attributions: ["<a href='https://www.sentinel-hub.com'>Sentinel Hub, Sinergise Ltd.</a>"]
  })
})

export default thermal