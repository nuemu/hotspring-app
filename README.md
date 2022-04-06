# 湯tellite
工事中
## サービス概要
衛星画像(現状はサーマルのみ)を用いて野湯探索を補助するサービスです。

## Versions
Ruby v2.7.4
Rails v6.1.4.6
Node v16.13.1

## Setup
```
1. git clone
```

```
2. npm install
```

```
3. .env sampleの設定を.env.developmentに修正
- baseURL: apiのリクエスト先(標準のdevelopment環境であればhttp://localhost:3000/api)
- THERMAL_xxx: [SentinelHub Dashboard Configuration Utility](https://www.sentinel-hub.com/develop/custom-scripts/)のid(CustomScriptに関しては以下の例を参照)
- GOOGLE_DRIVE: google apiのServiceAccountのjson
- GOOGLE_DRIVE_ID: ファイルを保管したいドライブ(内のフォルダ)のID
```

## SentinelHub CustomScriptの例（VUE_APP_THERMAL270）
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