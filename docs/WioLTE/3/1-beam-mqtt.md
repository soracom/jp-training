# 3-1: SORACOM Beam を用いた MQTT Pub/Sub 双方向通信

本格的な IoT システムの構築として、データ収集だけでなく、クラウド側からのデータをデバイス側で受信し処理する仕組みを学びます。

MQTT ブローカー (サーバ) には [Amazon MQ](https://aws.amazon.com/jp/amazon-mq/) を利用します。
※ Amazon MQ は運営側で準備済みです。

<img src="https://docs.google.com/drawings/d/e/2PACX-1vSsShyoehwdAURPbQN6THxUFDdSMBXsAgS2egkZYV2SgI_GdHj8WaxmYMeHyXiWx2l609nfuY-GnUMJ/pub?w=922&amp;h=328" alt="全体構成 / MQTT PubSub with Mosquitto / overview">

## 最初に. Wio LTE の電源を OFF にする

Wio LTE の microUSB ケーブルを抜き、電源を OFF にしてください

※いきなり抜いてOKです。また、すでに OFF になっている場合は次に進んでください

## 1. SORACOM Beam 設定

### 1-1. [SORACOM Web コンソール](https://console.soracom.io/) で 左上[Menu] > [SIM グループ]

[追加] で、SIMグループを作成します (グループ名は進捗表の **sim-group-name2** を利用してください)

### 1-2. 先ほど作成した SIMグループ をクリックし、 SORACOM Beam の設定を開きます

### 1-3. SORACOM Beam の「＋」をクリックし、一覧の中から **MQTT エントリポイント** をクリック

![beam-menu](https://docs.google.com/drawings/d/e/2PACX-1vTomsQdSLg-QaoYG591c1-NJYobwgXI6YqppP8h16NnxBLi8sd-QXFJvrrKrKCz6JW4d0oVp-UXCIdT/pub?w=435&h=407)

### 1-4. SORACOM Beam の設定では、下記の通り入力し、保存してください

* 設定名: `to-amazon-mq`
* 種別: *Standard MQTT Broker*
* プロトコル: *MQTTS* (変更し忘れが多いので注意)
* ホスト名: **進捗表から入手した値 (amazonmq-host)**
* ポート番号: **進捗表から入手した値 (amazonmq-port)**
* ユーザ名: **進捗表から入手した値 (amazonmq-username)**
* パスワード: **進捗表から入手した値 (amazonmq-password)**
* IMSI 付与: *ON*

<img src="https://docs.google.com/drawings/d/e/2PACX-1vRSDWtOWelYGw9paqusSx3AEfC4nQPGzJ_xjZD8pb7bT3e1aaWtDYNt5iDi8rRGzVmxfq8FjjH5QXnu/pub?w=471&h=879" alt="step5 MQTT PubSub with Mosquitto / beam-setting">

### 1-5. 左上[Menu] > [SIM 管理]

* Wio LTE に取り付けている SIM (sim-name を参照) を選択 > [操作] > [所属グループ変更]
* 先ほど作成した SIMグループ に所属させる

<h2 id="pubsubclient_install">3. PubSubClient ライブラリのインストール</h2>

MQTT 通信を行うにあたり PubSubClient というライブラリを利用します  
※ 公式の PubSubClient では、パケットサイズが小さいため若干不都合が発生することが確認されています。そのため、ハンズオン側で準備した fork ライブラリを使用してください

### 2-1. 追加のライブラリをダウンロードする

[SeeedJP/pubsubclient](https://github.com/SeeedJP/pubsubclient/releases) のページから **2.6 の ZIP** をダウンロードします

### 2-2. Arduino IDE を起動する

### 2-3. Arduino IDE の [スケッチ] > [ライブラリをインクルード] > [.ZIP 形式のライブラリをインストール...]

![wio-lte-handson / zip-lib](https://docs.google.com/drawings/d/e/2PACX-1vSyvtSl8JWQO_D5-pkwQsp0YVrrWOU76GlZohHURcIIEU-5W3PreVa9tCTUyYI94mId_y5zICWpC6xJ/pub?w=555&h=273)

先ほどダウンロードした `pubsubclient-2.6.zip` を探して「開く」をクリックすればインストール完了です

## 3. スケッチを作成する

### 3-1. Arduino IDE を起動する

### 3-2. メニューの [ツール] で [ボード: "Seeed Wio LTE Cat.1"] と表示されていることを確認する

なっていなければ一覧から "Seeed Wio LTE Cat.1" を選んでください

### 3-3. Arduino IDE の [ファイル] > [スケッチ例] > [Wio LTE for Arduino] > [mqtt] > [mqtt-client]

### 3-4. スケッチを下記の通りに変更します (変更例は後述)

* 10行目: `hostname` を `beam.soracom.io` に変更
* 13行目: `WioLTE` を **進捗表から入手した値 (mqtt-iid)** に変更
* 14行目: `outTopic` を **進捗表から入手した値 (mqtt-pub-topic)** に変更
* 15行目: `inTopic` を **進捗表から入手した値 (mqtt-sub-topic)** に変更
* 17行目: `60000` を `5000` に変更

**スケッチの変更例**

変更前 (10行目 ～ 17行目までを一括で表示)

```
#define MQTT_SERVER_HOST  "hostname"
#define MQTT_SERVER_PORT  (1883)

#define ID                "WioLTE"
#define OUT_TOPIC         "outTopic"
#define IN_TOPIC          "inTopic"

#define INTERVAL          (60000)
```

変更後の例  
(この値をそのまま使わずに `ID` や `OUT_TOPIC` や `IN_TOPIC` の値は進捗表から入手してください)

```
#define MQTT_SERVER_HOST  "beam.soracom.io"
#define MQTT_SERVER_PORT  (1883)

#define ID                "sr-h0813-02"
#define OUT_TOPIC         "sroot/h0813/02/cloud"
#define IN_TOPIC          "sroot/h0813/02/device"

#define INTERVAL          (5000)
```

### 3-5. Wio LTE を PC を接続して DFUモード にする

### 3-6. 新しく開いたウィンドウの ![マイコンボードに書き込むアイコン](https://docs.google.com/drawings/d/e/2PACX-1vQiO83cFcX3LCXeioiTiaao57T4SGiIV6XZzcBP6poTwssCxmo7hLpoMh5qG3btyqgzs8Q-lAoE6Q0f/pub?w=100&h=100)(マイコンボードに書き込む) をクリック

### 3-7. 書き込みが完了したら、Wio LTE を 通常モードにする (RSTボタンを押せば通常モードになります)

通常モードで起動次第 SORACOM Beam へデータを送信し始めます (電源投入から送信開始までは15~20秒程度かかります)

## 4. 確認

### 4-1. [MQTT over WebSocket monitor](http://ma2shita.s3.amazonaws.com/mqtt-monitor/wss.html) を新しいタブで開きます

下記の値を入力して [Connect] をクリックしてください

* WebSocket server address: **進捗表から入手した値 (ws-host)**

※その他は変更する必要はありません

<img src="https://docs.google.com/drawings/d/e/2PACX-1vSFxfEQ_5O7kShpoynfj8MTBTNrqoWVGpBRCVJpLDPTrGkmTeR3KPR0EAp-TZumZ6pSrsBrkoZi5FhC/pub?w=659&h=433" alt="step5 MQTT PubSub with Mosquitto / wss-client">

### 4-2. Subscribe と Publish の設定

#### Subscribe (Wio LTE → クラウド)

* ブラウザ上の [SUBSCRIBE] タブをクリック
* 表示されたダイアログで **Topic** に **進捗表から入手した値 (ws-sub-topic)** を入力  
例: `sroot/h0813/02/#`
* [ADD SUBSCRIBE] をクリック

その後、 Arduino IDE > [ツール] > [シリアルモニタ] で表示されるウィンドウには Wio LTE の稼働状況が表示されます。  
ブラウザ上の "Monitoring" に Wio LTE から Publish されたデータが表示され始めます。

<img src="https://docs.google.com/drawings/d/e/2PACX-1vQsc6capNMYLbbUduifhMyZiyT2GTm1NE79BHqBqSIh3gYN7w38r0Hb2Wdym_LkDTF6Nnn-d5IwshUm/pub?w=891&h=714" alt="step5 MQTT PubSub with Mosquitto / mqtt-sub">

#### Publish (クラウド → Wio LTE)

* ブラウザ上の [PUBLISH] タブをクリック
* **Topic** に **進捗表から入手した値 (ws-pub-topic)** を入力  
例: `sroot/h0813/02/device`
* **Content** に任意の文字 (例: `Hello from Cloud via SORACOM Beam!!`) を入力する
* [Publish] をクリック

Content で入力した文字がシリアルモニタ(= Wio LTE に送信された)に表示されていることが確認できます。

<img src="https://docs.google.com/drawings/d/e/2PACX-1vT2KoOzkGfflDShd412jVb1fm7qPUDg6u9prKrx4p636rE3behb8geswVNQweenKaXxfX1nNSAyU2kU/pub?w=892&h=502" alt="step5 MQTT PubSub with Mosquitto / mqtt-pub">

## 5. やってみよう

Wio LTE が MQTT Subscribe メッセージを受信すると、23 行目の `void callback()` という関数が実行されます。
ここを修正することで、クラウドからのコマンドを処理することができるようになります。

今回は「 `#xxxxxx` という文字列を Wio LTE が受信したら、 LED の発光色として使う」としてみましょう

変更前 (23 行目付近);

```c
void callback(char* topic, byte* payload, unsigned int length) {
  SerialUSB.print("Subscribe:");
  for (int i = 0; i < length; i++) SerialUSB.print((char)payload[i]);
  SerialUSB.println("");
}
```

変更後 (23 行目付近);

```c
void callback(char* topic, byte* payload, unsigned int length) {
  char c[length];
  for (int i = 0; i < length; i++) c[i] =  (char) payload[i];
  SerialUSB.print("Subscribe:");
  SerialUSB.println(c);
  unsigned long r = 0;
  unsigned long g = 0;
  unsigned long b = 0;
  if ('#' == c[0] && length == 7) {
    char rx[2] = {c[1], c[2]};
    r = strtoul(rx, NULL, 16);
    char gx[2] = {c[3], c[4]};
    g = strtoul(gx, NULL, 16);
    char bx[2] = {c[5], c[6]};
    b = strtoul(bx, NULL, 16);
  }
  Wio.LedSetRGB(r, g, b);
}
```

試験用カラーコード

* 赤 : `#300000`
* 緑 : `#002000`
* 青 : `#000018`
* SORACOM カラー : `#001410`
* オレンジ : `#481400`
* 消灯 : `#000000`

Wio LTE 上の LED の色を制御できること確認してみてください。

## 6. Wio LTE の動作を止める

止める方法は Wio LTE の電源を OFF (= microUSBケーブルを抜く) してください

## 以上で本章は終了です

達成状況を進捗表へご記入ください。

* [目次ページへ戻る](../)

## Amazon MQ 構築方法

Amazon MQ の構築方法は [Qiita: Amazon MQにmosquitto(MQTT)とMQTT over Websocketで接続してみる](https://qiita.com/ma2shita/items/bfdd99a5b99c6baaba82#amazon-mq-%E3%81%AE%E3%83%96%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%BC%E4%BD%9C%E6%88%90) をご覧ください。

## うまく動かなかったら（トラブルシュート）

**「マイコンボードに書き込む」を実行した結果、ウィンドウに下記のように表示された**

```
 #include <PubSubClient.h>  // https://github.com/SeeedJP/pubsubclient
                                                                        ^
compilation terminated.

exit status 1
ボードSeeed Wio LTE Cat.1に対するコンパイル時にエラーが発生しました。
```

* 原因: *PubSubClient* ライブラリが不足しています
* 対策: [PubSubClient のインストール](#pubsublib)を行った後、再度書き込みを行ってください

**「マイコンボードに書き込む」を実行した結果、ウィンドウに下記のように表示された**

```
      yield();

            ^

exit status 1
ボードSeeed Wio LTE Cat.1に対するコンパイル時にエラーが発生しました。
```

* 原因: 公式が配布している *PubSubClient* ライブラリを使っています
* 対策: すでにインストールされてしまった PubSubClient を削除した後、[PubSubClient のインストール](#pubsublib)を行ってから再度書き込みを行ってください
    * 削除の方法は Arduino スケッチ保存フォルダ内の `libraries` フォルダ内の `PubSubClient` フォルダを削除します。（作業は慎重に行ってください）

**(シリアルモニターで) `### Connecting to "soracom.io".` で止まってしまう**

```
--- START ---------------------------------------------------
### I/O Initialize.
### Power supply ON.
### Turn on or reset.
### Connecting to "soracom.io".
```

* 原因: 電波状況などによりモバイル通信に失敗している
* 対策: RST ボタンを押して Wio LTE を再度起動しなおしてください

**(シリアルモニターで) `### ERROR! ###` と表示されてしまう**

```
--- START ---------------------------------------------------
### I/O Initialize.
### Power supply ON.
### Turn on or reset.
### Connecting to "soracom.io".
### Connecting to MQTT server "beam.soracom.io"
### ERROR! ###
Publish:{"uptime":23}
```

* 原因: SORACOM Beam の設定に不備があります
* 対策: よくある原因は以下の通りです。確認してみてください

1. SORACOM Beam の設定で MQTTS にするところを MQTT のままにしている → Beam の設定を見直してみてください
2. 認証情報に埋めるべき文字列が間違っている → 認証情報を新たに作り、Beam の設定で新しい方を指定してみてください
3. SORACOM Beam が有効になっている SIM グループに SIM を所属させることを忘れている → SIM の設定から SIM グループに所属しているか確認してみてください

**最初の数回だけ WebSocket Client 側で受信ができて、その後の受信が確認できない / WebSocket Client 側からの Publish が Wio LTE に届かない**

* 対策: 下記手順を実施してみてください
    1. (Wio LTE の電源が入ったままで) SORACOM Webコンソール上で、当該の SIM のセッションを切断
    2. Wio LTE を再起動 (RST ボタンなど)

**送信しているように見えるが WebSocket Client に全く送信されない**

* 原因: PubSubClient のバッファサイズが不足している場合があります
* 対策: `PubSubClient.h` の `MQTT_MAX_PACKET_SIZE` を `128` から大きい数字 (e.g. `512`) に変更して再コンパイルしてください (本手順で案内している fork されたライブラリでは本修正がされています)
