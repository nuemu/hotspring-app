import Tile from 'ol/layer/Tile';
import XYZ from 'ol/source/XYZ';

const gsi = new Tile({
  name: 'normal',
  source: new XYZ({
    url: "https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png",
    attributions: [
      "<a href='https://maps.gsi.go.jp/development/ichiran.html' target='_blank'>地理院タイル</a>"
    ]
  }),
})

export default gsi