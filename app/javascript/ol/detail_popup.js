import Overlay from 'ol/Overlay';

export function detail_popup(map){
  const container = document.getElementById('detail-popup');
  const closer = document.getElementById('detail-popup-closer');

  const overlay = new Overlay({
    name: 'detail',
    element: container,
  });
  
  closer.onclick = function () {
    overlay.setPosition(undefined);
    closer.blur();
    return false;
  };

  map.addOverlay(overlay);
}