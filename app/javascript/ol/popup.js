import Overlay from 'ol/Overlay';
import {toLonLat, fromLonLat, transformExtent} from 'ol/proj';
import { getCenter } from 'ol/extent';
import View from 'ol/View'
import Feature from 'ol/Feature';

import store from '../store/index.js'
import status from '../ol/hotspring_status.js'

export function popup(map){
  const container = document.getElementById('popup');
  const content = document.getElementById('popup-content');
  const closer = document.getElementById('popup-closer');

  const overlay = new Overlay({
    element: container,
  });
  
  closer.onclick = function () {
    overlay.setPosition(undefined);
    closer.blur();
    return false;
  };

  map.addOverlay(overlay);

  map.on('click', function (evt) {
    const feature = map.forEachFeatureAtPixel(evt.pixel, function (feature) {
      return feature;
    });
    if (feature instanceof Feature) {
      const coordinate = toLonLat(getCenter(feature.getGeometry().getExtent()))

      const view = new View({
        maxZoom: 18,
        minZoom: 5,
        zoom: 10,
        center: fromLonLat([coordinate[0]+0.05,coordinate[1]+0.05]),
        constrainResolution: false,
        extent: transformExtent([110, 20, 170, 46], 'EPSG:4326', 'EPSG:3857')
      })
      map.setView(view)

      const name = feature.values_.features[0].values_.name
      overlay.setPosition(fromLonLat(coordinate));
      store.dispatch('hotsprings/fetchHotspring',coordinate.join(','))
        .then((response) => {
          let image
          if(response.image_url) image = '<img src=http://drive.google.com/uc?export=view&id='+response.image_url.split('d/')[1].split('/view')[0] + " height='240'>"
          else image = 'no image'
          content.innerHTML
            = '<h4><a href=/hotspring/' + coordinate + " class='link-dark'>" + name + '</a></h4>'   
            + image
            + '<div><code>' + coordinate + '</code></div>'
            + '<div>' + '状態:' + status[response.status] + '</div>'
        })
      }
    }
  );
}