import Overlay from 'ol/Overlay';

export function register_popup(map){
  const container = document.getElementById('register_popup');
  const closer = document.getElementById('register_popup-closer');

  const overlay = new Overlay({
    name: 'register',
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
}