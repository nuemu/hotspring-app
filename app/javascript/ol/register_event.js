import {toLonLat} from 'ol/proj';

export function register(evt) {
  const content = document.getElementById('popup-content');
  const coordinate = evt.coordinate;
  const lonlat = toLonLat(coordinate);

  content.innerHTML = '<p>この地点を登録しますか？:</p><code>' + lonlat + '</code>';
  let overlay
  evt.map.getOverlays().forEach(over => {if(over.options.name == 'register') overlay = over})
  overlay.setPosition(coordinate);
};