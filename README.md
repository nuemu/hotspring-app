# 湯tellite

サービスURL:https://noyu-hub.herokuapp.com/

## このアプリについて
**開発経緯**

情報化の時代であっても、ニッチな趣味は、情報のコミュニティ依存度が高くなり、新規参入コストが高くながちです。
野湯もまた例に漏れず、有名所の情報が主なもので、温泉天国にも関わらず新規参入者は温泉に達することができない状況が生じています。
安全面や(地域社会含めた)環境保全を思えば、情報の不平等性は決して悪いことではないので、単なるメディアの提供でこの課題を解決してはいけないように思います。
そこで、自らの手で野湯を探すという、トレジャーハント趣味を許容する余裕ある方のために、このサービスは開発されました。

**手法**

このサービスで採用したのは、衛星画像を利用するという手法です。基本は次の書籍を参考にしています。
- 書籍：[衛星画像で読み解く　日本の温泉82](https://www.nippyo.co.jp/shop/book/7835.html)

特に、サーマル画像に絞って野湯探索を実際に試されている方がブログを公開しており、当サービスもその手法を踏襲しています。
- ブログ：[前人未到温泉](https://tori-kara.hatenablog.com/)

このサービスが野湯に興味を持つ方の参考になれば幸いです。

## 機能
**野湯探索機能**
- サーマル
<img width="1512" alt="スクリーンショット 2022-04-06 15 24 53" src="https://user-images.githubusercontent.com/94281527/161909161-f8a9e901-e32a-48a0-b50b-3770522ab2f9.png">

- 航空写真
<img width="1512" alt="スクリーンショット 2022-04-06 16 14 11" src="https://user-images.githubusercontent.com/94281527/161917018-2fc9cbd2-84f7-438b-94c6-0224865cad7d.png">

を切り替えながら、気になる地点を登録して、探索の価値がありそうな地点を絞り込むのが主機能です。

**詳細情報ページ**

各野湯について個別に情報を投稿できる詳細ページも実装されています。コメント及びURLの投稿が可能です。ログイン時には温泉の状態(温泉無し・入湯不可・入湯可能)を投稿することが可能で、内部的には多数決で状態を決定しています。
<img width="1512" alt="スクリーンショット 2022-04-06 16 12 30" src="https://user-images.githubusercontent.com/94281527/161917083-8db47b29-af0a-41da-9070-c249f204aaf5.png">

**お気に入り機能**

ログインユーザーは、単一のお気に入りリストを作成できます。
ただし、お気に入り地点のみの地図表示、共有する機構はありません。
そのような機能はGoogleMapと連携すべきだと思うので機能削除含めて方針を思案中です。

**管理画面**

管理画面は作成中です。様子を見ながら編集固定機能をつける予定です。

## 工夫した点
### 技術選定
**Vueの利用**

地図表示をするアプリで、詳細ページなどに遷移した後、戻ってくると初期表示に戻されて苛立つ物を時々見かけます。
このアプリは地図をメインとしているので、そのような問題が起きないように、コンポーネントを保存できるkeep-aliveを利用しようとVueを採用しました。
(実際のところ、ページ遷移自体がほとんどなくなりましたが...)

### 実装
**地図のlayerをrequire.contex**

衛星画像の種類を増やすことを想定して
`app/javascript/ol/layers/layer_loader.js`では、
```
const files = require.context('.', false, /(.*)layer\.js$/)
```
のようにwebpack(er)の機能を用いて、一括ロードを図っています。

**記事のOGP表示**

ogpを他サイトから取得するために、fetchAPIは、CORSの制約が原因で用いられないので、サーバー経由で情報取得するようにしました。
フロントからのリクエストに対して、`app/controllers/api/articles_controller.rb`で
```
require 'net/http'

def show
  html = Net::HTTP.get(URI.parse(params[:url]))
  render json: html
end
```
となっています。ogpはそこまで更新頻度が高い情報ではないと思うので、保存しても問題ないと思いますが、現状はリアルタイムで取得するようになっています。

**アイコンクリック時の挙動**

詳細ページのリンクを`/hotspring/:hotspring_id`にするのは、リンクの意味がよくわからなくなるので避けたく、(温泉の名前がuniqueかも定かでないため、)座標を用いることにしました。
マップ上のアイコンをクリックした際、そのアイコンの座標を用いて、`hotspring#show`にデータをリクエストする仕様になっていますが、
```
find_by(lat: params[:lat], lon: params[:lon])
```
とすると、読み込めないページが生じたので、調査したところ、登録されている座標とリクエストされる座標の間に誤差が生じているのが判明しました。
誤差の原因はOpenlayersの仕様にあると思うが、これは目下調査中ですが、幸いなことに、座標のずれは(経験上)軽微なので、hotspring modelに
```
def self.find_between(lat, lon)
  gap = 0.000000000005
  find_by(latitude: (lat - gap)..(lat + gap), longtitude: (lon - gap)..(lon + gap))
end
```
というメソッドを定義して回避するようにしました。

## 今後の予定
- Backendリファクタリング(特にGoogleDrive周りがFat Controller化している。修正後rubocopを通す予定。)
- hotspringの距離によるvalidation
- Frontendリファクタリング(とりあえずESLintのerrorを回避しただけで、warningには対応できていない。また無駄なdivなどが溢れかえっているので整備。)
- 独自ドメイン(yutellite.comを確保済み)

## 利用技術
- Frontend
  - Vue3 (Vuex/Vee-validate)
  - Openlayers
  - Bootstrap
  - AdminLTE
- Backend
  - Rails 6
  - Gem
    1. Sorcery
    2. jwt
    3. jsonapi-serializer
    4. google-auth/google-apis-drive_v3
- Infra
  - Heroku
  - GoogleDrive
- 他
  - RSpec
  - ESLint
  - Rubocop

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
