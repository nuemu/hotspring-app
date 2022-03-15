import {Vector as VectorLayer} from 'ol/layer';
import {Circle as CircleStyle, Fill, Stroke, Style} from 'ol/style';

export function InteractionStyle(source){
  const vector = new VectorLayer({
    source: source,
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

  return vector
}