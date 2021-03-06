import icons from '../ol/layer_icons/icon_loader'

export default [
  {'description': "ゆtelliteをご利用いただきありがとうございます。\n画面左上の<img src='"+icons['question']+"'>マークからいつもでこの説明を表示することができます。\n各アイコン上にカーソルをのせることで簡易的な機能説明が表示されます。", 'ref': 'center'},
  {'description': "まずは、温泉の湧きそうな場所に注目してみましょう。\n例えば、既に温泉のある場所の周辺(温泉街や、火山)は確率が高そうですね。", 'ref': 'center'},
  {'description': "次に、<img src='"+icons['thermal_middle']+"'>をクリックしてみましょう。\n地図が色鮮やかになりましたか？\n(もし何も表示されない場合は、衛星画像の月間利用量制限を超えているかもしれません、時間をあけての再挑戦をお願いします。)", 'ref': 'thermal_middle'},
  {'description': "赤い場所が高温、青い場所が低温を意味しています。\n全体的に赤色であれば<img src='"+icons['thermal_high']+"'>を、青色であれば<img src='"+icons['thermal_low']+"'>を押してみましょう。それぞれ青から赤で表示される温度域が異なります。", 'ref': 'thermal_middle'},
  {'description': "<img src='"+icons['photo']+"'>をクリックして、航空写真を表示しましょう。地表面温度は、地面が露出している部分(例えば都市部、駐車場、禿山など)が高温になりがちです。赤い表示の箇所がそのような環境でないか確認しましょう。", 'ref': 'photo'},
  {'description': "地図を切り替えているとどこに注目していたか、どこまでが赤い範囲だったか忘れてしまいますね？そこで、<img src='"+icons['pencil']+"'>を用いて、赤い部分を囲っておきましょう。", 'ref': 'pencil'},
  {'description': "仕上げに、<img src='"+icons['normal']+"'>で地理院地図を見てみましょう、水が湧けば捌け口があることでしょう、川があれば期待が高まります。\nもっと直接的に温泉や噴気孔の地図記号があるかもしれません。", 'ref': 'normal'},
  {'description': "<img src='"+icons['pin']+"'>を押して、地図上をクリックすることでその地点を登録できます。\n衛星画像は不変でも、完全な精度を誇るデータでもありません、間違えを恐れずにどんどん登録してみましょう。", 'ref': 'pin'},
  {'description': "最後に、現地の情報をお持ちの方がいれば、地図上登録済み温泉をクリックして、情報提供をお願いします。", 'ref': 'center'},
]