import {toLonLat} from 'ol/proj';
import {Vector as VectorSource} from 'ol/source';
import LineString from 'ol/geom/LineString';
import {getDistance} from 'ol/sphere'

export function register(evt) {
  const content = document.getElementById('popup-content');
  const coordinate = evt.coordinate;
  const lonlat = toLonLat(coordinate);

  var tempSource = new VectorSource()

  evt.map.getLayers().forEach(element => {
    switch(element.get('name')){
      case 'unexplored':
        tempSource.addFeatures(element.getSource().getFeatures())
        break
      case 'not_exist':
        tempSource.addFeatures(element.getSource().getFeatures())
        break
      case 'prohibit':
        tempSource.addFeatures(element.getSource().getFeatures())
        break
      case 'open':
        tempSource.addFeatures(element.getSource().getFeatures())
        break
    }
  })
  let distance = 1000
  if(tempSource.getFeatures().length > 0){
    const closest = toLonLat(tempSource.getClosestFeatureToCoordinate(coordinate).getGeometry().getCoordinates())

    distance = getDistance(lonlat, closest)
  }

  if(distance > 200){
    content.innerHTML = '<p>この地点を登録しますか？:</p><code>' + lonlat + '</code>';
    let overlay
    evt.map.getOverlays().forEach(over => {if(over.options.name == 'register') overlay = over})
    overlay.setPosition(coordinate);
  }
  else alert('他の登録地点に近すぎます(200m以上離してください)')
};