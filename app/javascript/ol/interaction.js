import {Draw, Modify, Snap} from 'ol/interaction';

const modify = new Modify({source: source});
map.addInteraction(modify);

function addInteractions() {
  draw = new Draw({
    source: source,
    type: 'Cycle',
  });
  map.addInteraction(draw);
  snap = new Snap({source: source});
  map.addInteraction(snap);
}