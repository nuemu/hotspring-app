import {toLonLat, fromLonLat, transformExtent} from 'ol/proj';
import { getCenter, boundingExtent } from 'ol/extent';
import View from 'ol/View'
import Feature from 'ol/Feature';

import store from '../store/index.js'

export function detail(evt) {
  const content = document.getElementById('detail-popup-content');
  let map = evt.map
  const feature = map.forEachFeatureAtPixel(evt.pixel, function (feature) {
    return feature;
  })

  if(feature instanceof Feature){
    const features = feature.get('features');
    if (features.length > 1) {
      const extent = boundingExtent(
        features.map((r) => r.getGeometry().getCoordinates())
      );
      map.getView().fit(extent, {duration: 500, padding: [100, 100, 100, 100]});
    }
    if (features.length == 1) {
      const coordinate = toLonLat(getCenter(feature.getGeometry().getExtent()))

      let zoom = map.getView().getZoom()
      if(zoom <= 12) zoom = 12

      const view = new View({
        maxZoom: 18,
        minZoom: 5.5,
        zoom: zoom,
        center: fromLonLat([coordinate[0],coordinate[1]]),
        constrainResolution: false,
        extent: transformExtent([110, 20, 170, 46], 'EPSG:4326', 'EPSG:3857')
      })

      const name = feature.values_.features[0].values_.name
      let overla
      map.getOverlays().forEach(over => {if(over.options.name == 'detail') overla = over})
      store.dispatch('hotsprings/fetchHotspring',coordinate.join(','))
        .then(() => {
          overla.setPosition(fromLonLat([coordinate[0],coordinate[1]]));
          const extent = boundingExtent(
            features.map((r) => r.getGeometry().getCoordinates())
          );
          map.getView().fit(extent, {duration: 500, maxZoom: zoom});
        })
        .catch((e) => {overla.setPosition(undefined); console.log(e)})
      }
    }
  }