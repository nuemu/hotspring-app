import VectorTileLayer from 'ol/layer/VectorTile';
import VectorTileSource from 'ol/source/VectorTile';
import MVTFormat from 'ol/format/MVT';

const gsi = new VectorTileLayer({
  name: 'water',
  source: new VectorTileSource({
    format: new MVTFormat({
      layers: ['coastline', 'waterarea']
    }),
    url: 'https://cyberjapandata.gsi.go.jp/xyz/experimental_bvmap/{z}/{x}/{y}.pbf',
    attributions: [
      '<a href="https://github.com/gsi-cyberjapan/gsimaps-vector-experiment" target="_blank" rel=”noopener noreferrer”>国土地理院</a>',
    ],
  })
})

export default gsi