import {Vector as VectorLayer} from 'ol/layer';
import {Circle as CircleStyle, Fill, Stroke, Style} from 'ol/style';
import {Vector as VectorSource} from 'ol/source';

export function InteractionStyle(map){
  const source = new VectorSource();
  const vector = new VectorLayer({
    source: source,
    zIndex: 10,
    name: 'interaction',
    style: new Style({
      fill: new Fill({
        color: 'rgba(255, 255, 255, 0.2)',
      }),
      stroke: new Stroke({
        color: '#ffcc33',
        width: 2,
      }),
      image: new CircleStyle({
        radius: 7,
        fill: new Fill({
          color: '#ffcc33',
        }),
      }),
    }),
  });

  map.addLayer(vector)
}