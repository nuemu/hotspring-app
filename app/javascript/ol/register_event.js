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
    if(element.get('name')=='unexplored'){
      tempSource.addFeatures(element.getSource().getFeatures())
    }
    if(element.get('name')=='not_exist'){
      let features = element.getSource().getFeatures()
    }
  })
  const closest = toLonLat(tempSource.getClosestFeatureToCoordinate(coordinate).getGeometry().getCoordinates())

  const distance = getDistance(lonlat, closest)

  if(distance > 200){
    content.innerHTML = '<p>この地点を登録しますか？:</p><code>' + lonlat + '</code>';
    let overlay
    evt.map.getOverlays().forEach(over => {if(over.options.name == 'register') overlay = over})
    overlay.setPosition(coordinate);
  }
};