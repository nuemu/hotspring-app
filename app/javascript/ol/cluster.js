import {
  Circle as CircleStyle,
  Fill,
  Stroke,
  Style,
  Text,
} from 'ol/style';
import {Cluster, OSM, Vector as VectorSource} from 'ol/source';
import {Vector as VectorLayer} from 'ol/layer';

import Feature from 'ol/Feature';
import Point from 'ol/geom/Point'
import { fromLonLat } from 'ol/proj'

import hotspring_status from './hotspring_status.js'

export function cluster(hotsprings){
  // require elements of hotsprings have .longtitude .latitude .name .status
  let categorized_hotsprings = {}
  let categorized_clusters = {}
  hotspring_status.forEach(status => {
    categorized_hotsprings[status]=[]
    categorized_clusters[status] = []
  })
  hotsprings.forEach(element => {
    categorized_hotsprings[element.status].push(element)
  })

  hotspring_status.forEach(status => {
    const clusterSource = generate_features(categorized_hotsprings[status])

    categorized_clusters[status] = generate_clusters(clusterSource, status)
  })

  let clusters = []

  hotspring_status.forEach(status => {
    clusters = clusters.concat(categorized_clusters[status])
    console.log(clusters)
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
  const clusters = new VectorLayer({
    name: status,
    source: clusterSource,
    style: function (feature) {
      const size = feature.get('features').length;
      let style = styleCache[size];
      if (!style) {
        style = new Style({
          image: new CircleStyle({
            radius: 10,
            stroke: new Stroke({
              color: '#fff',
            }),
            fill: new Fill({
              color: '#3399CC',
            }),
          }),
          text: new Text({
            text: size.toString(),
            fill: new Fill({
              color: '#fff',
            }),
          }),
        });
        styleCache[size] = style;
      }
      return style;
    },
  })

  return clusters
}