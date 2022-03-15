import Draw from 'ol/interaction/Draw.js';
import Modify from 'ol/interaction/Modify.js';
import Snap from 'ol/interaction/Snap.js';

export function Interaction(map, type){
  let source
  map.getLayers().forEach(layer => {if(layer.values_.name == 'interaction') source = layer.values_.source})

  const modify = new Modify({source: source});
  map.addInteraction(modify);

  let draw, snap

  map.getInteractions().forEach(inter => {
    if(inter instanceof Draw){
      draw = inter
    }else if(inter instanceof Snap){
      snap = inter
    }
  })

  function addInteractions() {
    draw = new Draw({
      source: source,
      type: 'Circle',
    });
    map.addInteraction(draw);
    snap = new Snap({source: source});
    map.addInteraction(snap);
  }

  function removeInteractions(){
    map.removeInteraction(draw);
    map.removeInteraction(snap);
  }
  if(type == true) addInteractions()
  else removeInteractions()

  return [draw, snap]
}