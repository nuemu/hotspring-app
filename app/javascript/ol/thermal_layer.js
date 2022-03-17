import Tile from 'ol/layer/Tile'
import  TileWMS  from 'ol/source/TileWMS'

const thermal = new Tile({
  name: 'THERMAL',
  opacity: 0.4,
  source: new TileWMS({
    url: "https://services-uswest2.sentinel-hub.com/ogc/wms/dc690d7c-88fe-46be-88b1-e67bb119f0a9",
    params: {"urlProcessingApi":"https://services-uswest2.sentinel-hub.com/ogc/wms/8439a8a1-9c27-4ce5-9398-4991965607db","maxcc":20,"minZoom":10,"maxZoom":10,"preset":"THERMAL","layers":"THERMAL","time":"2021-09-01/2022-03-12"},
    serverType: 'geoserver',
    transition: 0
  })
})

export default thermal