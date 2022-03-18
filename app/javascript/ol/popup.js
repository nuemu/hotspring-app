import Overlay from 'ol/Overlay';
import {toLonLat} from 'ol/proj';
import store from '../store/index.js'

import status from '../ol/hotspring_status.js'

export function popup(map){
  const container = document.getElementById('popup');
  const content = document.getElementById('popup-content');
  const closer = document.getElementById('popup-closer');

  const overlay = new Overlay({
    element: container,
    autoPan: {
      animation: {
        duration: 250,
      },
    },
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
    if (feature) {
      if(feature.get('features')){
        const coordinate = (toLonLat(feature.get('features')[0].get('geometry').flatCoordinates))
        const name = feature.values_.features[0].values_.name
        overlay.setPosition(evt.coordinate);
        store.dispatch('hotsprings/fetchHotspring',coordinate.join(','))
          .then((response) => {
            console.log(response)
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
  });
}