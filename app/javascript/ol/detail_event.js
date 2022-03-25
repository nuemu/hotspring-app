import {toLonLat, fromLonLat, transformExtent} from 'ol/proj';
import { getCenter } from 'ol/extent';
import View from 'ol/View'
import Feature from 'ol/Feature';

import store from '../store/index.js'
import status from './hotspring_status.js'

export function detail(evt) {
  const content = document.getElementById('detail-popup-content');
  let map = evt.map
  const feature = map.forEachFeatureAtPixel(evt.pixel, function (feature) {
    return feature;
  });
  if (feature instanceof Feature) {
    const coordinate = toLonLat(getCenter(feature.getGeometry().getExtent()))

    let zoom = map.getView().getZoom()
    if(zoom <= 10) zoom = 10

    const view = new View({
      maxZoom: 18,
      minZoom: 5,
      zoom: zoom,
      center: fromLonLat([coordinate[0],coordinate[1]]),
      constrainResolution: false,
      extent: transformExtent([110, 20, 170, 46], 'EPSG:4326', 'EPSG:3857')
    })

    const name = feature.values_.features[0].values_.name
    let overla
    map.getOverlays().forEach(over => {if(over.options.name == 'detail') overla = over})
    store.dispatch('hotsprings/fetchHotspring',coordinate.join(','))
      .then((response) => {
        overla.setPosition(fromLonLat(coordinate));
        map.setView(view)
        let image
        if(response.image_url) image = '<img src=http://drive.google.com/uc?export=view&id='+response.image_url.split('d/')[1].split('/view')[0] + " height='240'>"
        else image = 'no image'
        content.innerHTML
          = '<h4><a href=/hotspring/' + coordinate + " class='link-dark'>" + name + '</a></h4>'   
          + image
          + '<div><code>' + coordinate + '</code></div>'
          + '<div>' + '状態:' + status[response.status] + '</div>'
      })
      .catch((e) => {overla.setPosition(undefined); console.log(e)})
    }
  }