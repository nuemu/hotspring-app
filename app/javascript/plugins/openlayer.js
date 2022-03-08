import VectorLayer from 'ol/layer/Vector'
import VectorSource from 'ol/source/Vector'
import Feature from 'ol/Feature'
import Point from 'ol/geom/Point'
import {Style, Icon} from 'ol/style'
import { fromLonLat } from 'ol/proj'

export function create_icon(name, lon, lat){

  const hotspring = require('hotspring.svg')

  const iconFeature = new Feature({
    geometry: new Point(fromLonLat([lat, lon])),
    name: name
  });

  const iconStyle = new Style({
    image: new Icon({
      src: hotspring,
      scale: 0.03
    },)
  });

  const vectorSource = new VectorSource({
      features: [iconFeature]
  });

  const vectorLayer = new VectorLayer({
      source: vectorSource,
      style: iconStyle
  })

  return vectorLayer
}