# [湯tellite](https://noyu-hub.herokuapp.com/)
工事中...

衛星画像を用いて野湯探索を補助するサービスです。
<img width="1512" alt="スクリーンショット 2022-04-06 15 24 53" src="https://user-images.githubusercontent.com/94281527/161909161-f8a9e901-e32a-48a0-b50b-3770522ab2f9.png">
衛星画像を利用するという手法については、以下のサイト・文献の影響を受けています。
- [前人未到温泉](https://tori-kara.hatenablog.com/)
- [衛星画像で読み解く　日本の温泉82](https://www.nippyo.co.jp/shop/book/7835.html)

## Versions
- Ruby v2.7.4
- Rails v6.1.4.6
- Node v16.13.1

## Setup
```
1. git clone
```
```
2. bundle install
```
```
3. npm install
```
```
4. .env sampleの設定を.env.developmentに修正、変数については次の見出しを参照
```

## .envの変数について
- baseURL: apiのリクエスト先(標準のdevelopment環境であればhttp://localhost:3000/api)
- GOOGLE_DRIVE: google api ServiceAccountのjson
- GOOGLE_DRIVE_ID: ファイルを保管したいドライブ(内のフォルダ)のID
- THERMAL_xxx: Sentinel Hub APIのINSTANCE ID

## SentinelHub
衛星画像の表示にはSentinel Hubを利用しています。
INSTANCE IDの取得は[FAQ:](https://www.sentinel-hub.com/faq/#where-get-instance-id)を参考にしてください。
また、[Custom scripts](https://www.sentinel-hub.com/develop/custom-scripts/)の設定が必要となります。次に例を載せておきます。

CustomScriptの例：VUE_APP_THERMAL270
```
//VERSION=3
let minVal = 270;
let maxVal = 280;

let viz = ColorGradientVisualizer.createBlueRed(minVal, maxVal);

function evaluatePixel(samples) {
    let val = samples.B10;
    val = viz.process(val);
    val.push(samples.dataMask);
    return val;
}

function setup() {
  return {
    input: [{
      bands: [
        "B10",
        "dataMask"
      ]
    }],
    output: {
      bands: 4
    }
  }
}
```

## 利用技術
- Frontend
  - Vue3
  - Openlayers
- Backend
  - Rails 6
- Infra
  - Heroku
  - GoogleDriveApi
