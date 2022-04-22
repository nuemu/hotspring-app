import {
  Circle as CircleStyle,
  Fill,
  Stroke,
  Style,
  Text,
  Icon,
} from 'ol/style';
import {Cluster, Vector as VectorSource} from 'ol/source';
import {Vector as VectorLayer} from 'ol/layer';

import Feature from 'ol/Feature';
import Point from 'ol/geom/Point'
import { fromLonLat } from 'ol/proj'

import hotspring_status from './hotspring_status.js'
import status_icons from './status_icons/icon_loader'

export function cluster(hotsprings){
  // require elements of hotsprings have .longtitude .latitude .name .status
  let categorized_hotsprings = {}
  let categorized_clusters = {}
  Object.keys(hotspring_status).forEach(status => {
    categorized_hotsprings[status]=[]
    categorized_clusters[status] = []
  })
  hotsprings.forEach(element => {
    categorized_hotsprings[element.status].push(element)
  })

  Object.keys(hotspring_status).forEach(status => {
    const clusterSource = generate_features(categorized_hotsprings[status])

    categorized_clusters[status] = generate_clusters(clusterSource, status)
  })

  let clusters = []

  Object.keys(hotspring_status).forEach(status => {
    clusters = clusters.concat(categorized_clusters[status])
  })

  return clusters
}

function generate_features(hotsprings){
  const features = hotsprings.map(element => {
    return new Feature({
      geometry: new Point(fromLonLat([element.longtitude, element.latitude])),
      name: element.name
    })
  })

  const source = new VectorSource({
    features: features,
  });

  const distanceInput = 50
  const minDistanceInput = 10

  const clusterSource = new Cluster({
    distance: parseInt(distanceInput, 10),
    minDistance: parseInt(minDistanceInput, 10),
    source: source,
  });

  return clusterSource
}

function generate_clusters(clusterSource, status){
  const styleCache = {};
  let stroke_color = '#fff'
  let fill_color = '#3399CC'
  switch(status){
    case 'unexplored':
      break
    case 'not_exist':
      fill_color = 'grey'
      break
    case 'prohibit':
      fill_color = 'red'
      break
    case 'open':
      fill_color = 'green'
      break
    case 'others':
      fill_color = 'black'
      break
  }
  const clusters = new VectorLayer({
    name: status,
    source: clusterSource,
    style: function (feature) {
      const size = feature.get('features').length;
      let style = styleCache[size];

      const icon = new Icon({
        src: status_icons[status],
        size: [20,20],
      });

      if (!style) {
        if(size > 1){
          style = new Style({
            image: new CircleStyle({
              radius: 10,
              stroke: new Stroke({
                color: stroke_color,
              }),
              fill: new Fill({
                color: fill_color,
              }),
            }),
            text: new Text({
              text: size.toString(),
              fill: new Fill({
                color: '#fff',
              }),
            }),
          });
        }
        else{
          style = new Style({
            image: icon
          });
        }
        styleCache[size] = style;
      }
      return style;
    },
  })

  return clusters
}