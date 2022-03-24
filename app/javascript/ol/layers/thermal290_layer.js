import Tile from 'ol/layer/Tile'
import  TileWMS  from 'ol/source/TileWMS'

const thermal = new Tile({
  name: 'サーマル(290~300K)',
  opacity: 0.4,
  source: new TileWMS({
    url: "https://services-uswest2.sentinel-hub.com/ogc/wms/d69d438b-c21d-4497-a306-745287625b9f",
    params: {"urlProcessingApi":"https://services-uswest2.sentinel-hub.com/ogc/wms/8439a8a1-9c27-4ce5-9398-4991965607db","maxcc":20,"minZoom":10,"maxZoom":10,"preset":"THERMAL","layers":"THERMAL","time":"2021-09-01/2022-03-12"},
    serverType: 'geoserver',
    transition: 0,
    attributions: ["<a href='https://www.sentinel-hub.com'>Sentinel Hub, Sinergise Ltd.</a>"]
  })
})

export default thermal