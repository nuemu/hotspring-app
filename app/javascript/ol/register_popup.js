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

  map.on('singleclick', function (evt) {
    const coordinate = evt.coordinate;
    const lonlat = toLonLat(coordinate);
  
    content.innerHTML = '<p>この周辺を登録しますか？:</p><code>' + lonlat + '</code>';
    overlay.setPosition(coordinate);
  });
}