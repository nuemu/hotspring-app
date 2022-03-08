<template>
  <div 
    id="map"
    ref="map-root"
    style="width: 100%; height: 100vh">
  </div>
</template>

<script>
import View from 'ol/View'
import Map from 'ol/Map'

import VectorTileLayer from 'ol/layer/VectorTile';
import VectorTileSource from 'ol/source/VectorTile';
import MVTFormat from 'ol/format/MVT';
import { fromLonLat, transform } from 'ol/proj'

import 'ol/ol.css'

export default {
  mounted() {
    const vt = new VectorTileLayer({
      source: new VectorTileSource({
        format: new MVTFormat({
          layers: ['coastline']
        }),
        url: 'https://cyberjapandata.gsi.go.jp/xyz/experimental_bvmap/{z}/{x}/{y}.pbf',
        attributions: [
          '<a href="https://github.com/gsi-cyberjapan/gsimaps-vector-experiment" target="_blank" rel=”noopener noreferrer”>国土地理院</a>',
        ],
      })
    })

    var map = new Map({
      target: 'map',
      layers: [
        vt
      ],
      view: new View({
        zoom: 5,
        center: fromLonLat([140.46, 36.37]),
        constrainResolution: true
      }),
    })

    map.on('click', function(e) {
      const lonlat = transform(e.coordinate, 'EPSG:3857', 'EPSG:4326');
      alert("lat: " + lonlat[1] + ", lat: " + lonlat[0]);
    });


    
  },
}
</script>