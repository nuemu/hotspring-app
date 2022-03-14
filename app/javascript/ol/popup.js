import Overlay from 'ol/Overlay';
import {toLonLat} from 'ol/proj';

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
        content.innerHTML = '<a href=/hotspring/' + coordinate + '>' + name + '</div>'
      }
    }
  });
}