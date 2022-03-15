import Draw from 'ol/interaction/Draw.js';
import Modify from 'ol/interaction/Modify.js';
import Snap from 'ol/interaction/Snap.js';

export function Interaction(map, source){
  const modify = new Modify({source: source});
  map.addInteraction(modify);

  function addInteractions() {
    const draw = new Draw({
      source: source,
      type: 'Circle',
    });
    map.addInteraction(draw);
    const snap = new Snap({source: source});
    map.addInteraction(snap);
  }

  addInteractions()
}