# 3-1: SORACOM Beam を用いた MQTT Pub/Sub 双方向通信

本格的な IoT システムの構築として、データ収集だけでなく、クラウド側からのデータをデバイス側で受信し処理する仕組みを学びます。

今回はオープンソースの MQTT ブローカー(サーバ) である [Eclipse Mosquitto](https://mosquitto.org/) を利用します。  
※ **注意:** MQTT 試験用の公開サーバを利用します。誰でも読み書きが可能であるため、実システムでの利用はおやめください

<img src="https://docs.google.com/drawings/d/e/2PACX-1vSsShyoehwdAURPbQN6THxUFDdSMBXsAgS2egkZYV2SgI_GdHj8WaxmYMeHyXiWx2l609nfuY-GnUMJ/pub?w=922&amp;h=328" alt="全体構成 / MQTT PubSub with Mosquitto / overview">

## 最初に. Wio LTE の電源を OFF にする

Wio LTE の microUSB ケーブルを抜き、電源を OFF にしてください

※いきなり抜いてOKです。また、すでに OFF になっている場合は次に進んでください

## 1. SORACOM へ認証情報を保管する

### 1-1. [SORACOM Webコンソール](https://console.soracom.io/) で 左上[Menu] > [セキュリティ]

![soracom-menu](https://docs.google.com/drawings/d/e/2PACX-1vRhgmsjqpncv2HQ0jAZwiYf0knTfvmCMl6x_flrdeGQV4N60trp8M981gCAfitVSmXU4tqAYm6MmyRb/pub?w=331&h=410)
![soracom-menu-security](https://docs.google.com/drawings/d/e/2PACX-1vRjYW4eP-Cv1GTPmgGD01OEGiszvYmy1gmbsAQx50O6knq0UEPBozSQ8W3ezngFS6Z7B-8ArZkIXSWW/pub?w=344&h=334)

### 1-2. [認証情報ストア] > [認証情報を登録] で 認証情報入力画面を開きます

![soracom-cred-store](https://docs.google.com/drawings/d/e/2PACX-1vRoPNOwuGigBjl6MNfqQpXZL1MFmgPeUuwFLNF3TTRDZMQJf1G-HdwukH5otE7tdHy0YM9MWXmLac6z/pub?w=624&h=309)

### 1-3. 認証情報を登録する画面では下記の通り入力し、保存してください

* 認証情報ID: `mosquitto-cred`
* 概要: `test.mosquitto.org 接続用証明書`
* 種別: *X.509 証明書* (これを選択すると、下記を入力するテキストボックスが増えます)

**秘密鍵**;

```
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAvCqmO1+ADKcxRs+AldaUDxX9GPdUPoIDz61s8y9jqKImY4Qv
EY4e927HAPiQb2rLZlSIHTEpEHXduOCBdqayafHmQW9VCRm9wQbffw6oP3cZhsfr
nKGiE81Ejnru7dEdrxgm9DfwHJRj9l1lw5ENF5ojn0Gmgqx4fW1W6OMbVJmvceTH
fabkybKAPd1SMglY12PEn+l7rTq7U2YzhEcI2p8C5w7YjtOU/1sd/BbQsnzwlQ0w
MJP1ci2Ou/Q8Z+BLiObNHqgVh6EAgbn/S4M7l+4wCfcAvd+zrBZ2EKOL8W6MVjKi
UPeEphLg4G7n1baj707NuggQ40zg3sOl8/xkbwIDAQABAoIBAQCKQGvSw+A5a75w
4JUBgp9WVjmX1mE3bB+Qv0OFihQXGsxJ4h0TMPDfq6zbscWtlzHLBeDcUfpx9afq
5kk4/FGqNemPulUoUplw8bPUjthfiQpgVRNwCfIjynXMmdZjNXox4/T7Cv6IgR7R
LN5QSorsBHyXzoyhBkehIGzyv6qdBOudz+6E371zL+Mccjo6bXn27PgybYnq1OG/
kCyi7ksOGGt468ZCOcSMK7hlCsmBCa3LiXF435fU4jnC8x5u67iCrPIatM82rCrH
SdxvkuCH6aBDmjC8OQ95cndxTfN7X1CjBRKhh02gnNclZiPNWYAKwbDpuF5VvAW8
Rvxwta1BAoGBAODh3Kus7QtcpxSR4QUZrnwfMsWh9uHxg/Fr3G3mDKHEdhN8hjCI
wy3MkTwp3Zu+g/sdJtwct4PzMxwfMY823FHJUOyWsO79lMTsc/JG8zFeJqFXtp8p
9EIlXzA83nwgbvWhPR+kdNzs3pB4nm7qOQA+3z9Ez70/566PizG6061tAoGBANY0
L67Spi/rokpjhnO7Ya+9Ys5A57BxgIk7cYyGDezIpe2qSxMLdyq6l3/+WtCZiFci
96ej/w+FY8Obtre6go3EqQiZHJGH/P+jHUkQuv8nDdG9zqCpQt6bgPRmpYUntMvR
IJua5FAminwzmXjb2nVDoTbdzKKsOrss/+zYePvLAoGBANpPqbAnsf9jtPetHqua
4N6yUtG1iDyT/6jxMw6lVAH+/Tmxm3umaQQfIacsZWx6qRmwlTb90dIQ2L8mMTB8
66miLCNhruZz2mbJvU2oPxLf+dSLmEgvrGZCbYQgs0QBIHboTrRXLPQEJ5RM5FF8
pFVus79yB9ILJdk6lMB0RGaJAoGAfu05fAxScX7dEdtbpmRYhDxiufj30TPQiIDy
zeP5iF91Axmvlr9qg6VBdJSR153Cjm+n9GxXDSlrblNst/4KslrgFrozlYDRR+Gt
zsfdJqhLpgck00q41xOqHChe2EIo/cUT32Cu/Vd5JBOnU1hjYK0McGiJg7Musg7+
L6guOHUCgYAHrGzZgUaRZDSBXQECihtGI5imWWSqJZs7VtT11sDsBIB1fKb0Yuv6
PF/O7Ojnri6eQ3/Ki3nBgBXXFIwFd6YwPvJ2ZrWQlD0O0vatRI/UJ1bWLGvjhL84
LOOGVJ38amZag5hvFbfHEHhLoi6VsyW69ch6QIAfZeRfryeOKvgq1A==
-----END RSA PRIVATE KEY-----
```

**証明書**;

```
-----BEGIN CERTIFICATE-----
MIIC7zCCAligAwIBAgIBADANBgkqhkiG9w0BAQsFADCBkDELMAkGA1UEBhMCR0Ix
FzAVBgNVBAgMDlVuaXRlZCBLaW5nZG9tMQ4wDAYDVQQHDAVEZXJieTESMBAGA1UE
CgwJTW9zcXVpdHRvMQswCQYDVQQLDAJDQTEWMBQGA1UEAwwNbW9zcXVpdHRvLm9y
ZzEfMB0GCSqGSIb3DQEJARYQcm9nZXJAYXRjaG9vLm9yZzAeFw0xODA4MTIxNTIx
MTFaFw0xODExMTAxNTIxMTFaMEoxCzAJBgNVBAYTAkpQMQ4wDAYDVQQIDAVUb2t5
bzEWMBQGA1UECgwNU09SQUNPTSwgSU5DLjETMBEGA1UEAwwKc29yYWNvbS5pbzCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALwqpjtfgAynMUbPgJXWlA8V
/Rj3VD6CA8+tbPMvY6iiJmOELxGOHvduxwD4kG9qy2ZUiB0xKRB13bjggXamsmnx
5kFvVQkZvcEG338OqD93GYbH65yhohPNRI567u3RHa8YJvQ38ByUY/ZdZcORDRea
I59BpoKseH1tVujjG1SZr3Hkx32m5MmygD3dUjIJWNdjxJ/pe606u1NmM4RHCNqf
AucO2I7TlP9bHfwW0LJ88JUNMDCT9XItjrv0PGfgS4jmzR6oFYehAIG5/0uDO5fu
MAn3AL3fs6wWdhCji/FujFYyolD3hKYS4OBu59W2o+9OzboIEONM4N7DpfP8ZG8C
AwEAAaMaMBgwCQYDVR0TBAIwADALBgNVHQ8EBAMCBeAwDQYJKoZIhvcNAQELBQAD
gYEAKlnfzDxcC37KT7iXO2xTjUYfwUyn6PJF4qAWx46KjzZ5RbWiV74bXrgYMT01
Gcm6Nmjp9b0+tZ8jhN4JnJQcflcB7Wtc3697gnqd6IbmbC9GPipNPHF9CGfPSO6V
N6hRBMwzBIJhu+bdZ4f7rDYINWBxq3ThJhSKuF/PA+pmC08=
-----END CERTIFICATE-----
```

**CA 証明局**;

```
-----BEGIN CERTIFICATE-----
MIIC8DCCAlmgAwIBAgIJAOD63PlXjJi8MA0GCSqGSIb3DQEBBQUAMIGQMQswCQYD
VQQGEwJHQjEXMBUGA1UECAwOVW5pdGVkIEtpbmdkb20xDjAMBgNVBAcMBURlcmJ5
MRIwEAYDVQQKDAlNb3NxdWl0dG8xCzAJBgNVBAsMAkNBMRYwFAYDVQQDDA1tb3Nx
dWl0dG8ub3JnMR8wHQYJKoZIhvcNAQkBFhByb2dlckBhdGNob28ub3JnMB4XDTEy
MDYyOTIyMTE1OVoXDTIyMDYyNzIyMTE1OVowgZAxCzAJBgNVBAYTAkdCMRcwFQYD
VQQIDA5Vbml0ZWQgS2luZ2RvbTEOMAwGA1UEBwwFRGVyYnkxEjAQBgNVBAoMCU1v
c3F1aXR0bzELMAkGA1UECwwCQ0ExFjAUBgNVBAMMDW1vc3F1aXR0by5vcmcxHzAd
BgkqhkiG9w0BCQEWEHJvZ2VyQGF0Y2hvby5vcmcwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMYkLmX7SqOT/jJCZoQ1NWdCrr/pq47m3xxyXcI+FLEmwbE3R9vM
rE6sRbP2S89pfrCt7iuITXPKycpUcIU0mtcT1OqxGBV2lb6RaOT2gC5pxyGaFJ+h
A+GIbdYKO3JprPxSBoRponZJvDGEZuM3N7p3S/lRoi7G5wG5mvUmaE5RAgMBAAGj
UDBOMB0GA1UdDgQWBBTad2QneVztIPQzRRGj6ZHKqJTv5jAfBgNVHSMEGDAWgBTa
d2QneVztIPQzRRGj6ZHKqJTv5jAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBBQUA
A4GBAAqw1rK4NlRUCUBLhEFUQasjP7xfFqlVbE2cRy0Rs4o3KS0JwzQVBwG85xge
REyPOFdGdhBY2P1FNRy0MDr6xr+D2ZOwxs63dG1nnAnWZg7qwoLgpZ4fESPD3PkA
1ZgKJc2zbSQ9fCPxt2W3mdVav66c6fsb7els2W2Iz7gERJSX
-----END CERTIFICATE-----
```

<img src="https://docs.google.com/drawings/d/e/2PACX-1vSWmqDGkfYmO_RRSHjYlVkQw3TS3YuKb-nMRlS-Lmzi12xqxRH0VFhjq_U62bfZy6XoMoaZSlRAP4vJ/pub?w=960&amp;h=720" alt="step5 MQTT PubSub with Mosquitto / mosquitto-cred">

## 2. SORACOM Beam 設定

### 2-1. [SORACOM Web コンソール](https://console.soracom.io/) で 左上[Menu] > [SIM グループ]

[追加] で、SIMグループを作成します (グループ名 `beam` もしくは任意でかまいません)

### 2-2. 先ほど作成した SIMグループ をクリックし、 SORACOM Beam の設定を開きます

### 2-3. SORACOM Beam の「＋」をクリックし、一覧の中から **MQTT エントリポイント** をクリック

![beam-menu](https://docs.google.com/drawings/d/e/2PACX-1vTomsQdSLg-QaoYG591c1-NJYobwgXI6YqppP8h16NnxBLi8sd-QXFJvrrKrKCz6JW4d0oVp-UXCIdT/pub?w=435&h=407)

### 2-4. SORACOM Beam の設定では、下記の通り入力し、保存してください

* 設定名: `to-mosquitto`
* 種別: *Other MQTT Broker*
* プロトコル: *MQTTS*
* ホスト名: `test.mosquitto.org`
* ポート番号: `8884`
* ユーザ名 と パスワード: (空のままで OK です)
* 証明書: *ON*
* 認証情報: *mosquitto-cred* (手順 1 で作成した証明書を選択)
* IMSI 付与: *ON*

<img src="https://docs.google.com/drawings/d/e/2PACX-1vTUJxU-cH-qwXlXBkkztIwLjUauUYbpD0W0t_mQ9pGEv8yFr6zjAyz_FUnVVAV8jQL76I2es5GjUs3l/pub?w=389&amp;h=769" alt="step5 MQTT PubSub with Mosquitto / beam-setting">

### 2-5. 左上[Menu] > [SIM 管理]

* Wio LTE に取り付けている SIM を選択 > [操作] > [所属グループ変更]
* 先ほど作成した SIMグループ に所属させる

## 3. PubSubClient ライブラリのインストール

MQTT 通信を行うにあたり PubSubClient というライブラリを利用します

### 3-1. Arduino IDE を起動する

### 3-2. Arduino IDE の [スケッチ] > [ライブラリをインクルード] > [ライブラリを管理…]

一覧の中から **PubSubClient** を選択しインストールをクリックします  

※ `mqtt pubsub` で検索すると見つけやすいです

## 4. スケッチを作成する

### 4-1. Arduino IDE を起動する

### 4-2. メニューの [ツール] で [ボード: "Wio Tracker LTE"] と表示されていることを確認する

なっていなければ一覧から "Wio Tracker LTE" を選んでください

### 4-3. Arduino IDE の [ファイル] > [スケッチ例] > [Wio LTE for Arduino] > [mqtt] > [mqtt-client]

### 4-4. スケッチを下記の通りに変更します (変更例は後述)

* 10行目: `hostname` を `beam.soracom.io` に変更
* 13行目: `WioLTE` を **ハンズオン運営から入手した値 (mqtt-iid)** に変更
* 14行目: `outTopic` を **ハンズオン運営から入手した値 (mqtt-pub-topic)** に変更
* 15行目: `inTopic` を **ハンズオン運営から入手した値 (mqtt-sub-topic)** に変更
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

変更後 ( `ID` や `OUT_TOPIC` や `IN_TOPIC` の値はハンズオン運営から入手してください)

```
#define MQTT_SERVER_HOST  "beam.soracom.io"
#define MQTT_SERVER_PORT  (1883)

#define ID                "sr-h0813-02"
#define OUT_TOPIC         "sroot/h0813/02/cloud"
#define IN_TOPIC          "sroot/h0813/02/device"

#define INTERVAL          (5000)
```

### 4-5. Wio LTE を PC を接続して DFUモード にする

### 4-6. 新しく開いたウィンドウの ![マイコンボードに書き込むアイコン](https://docs.google.com/drawings/d/e/2PACX-1vQiO83cFcX3LCXeioiTiaao57T4SGiIV6XZzcBP6poTwssCxmo7hLpoMh5qG3btyqgzs8Q-lAoE6Q0f/pub?w=100&h=100)(マイコンボードに書き込む) をクリック

### 4-7. 書き込みが完了したら、Wio LTE を 通常モードにする (RSTボタンを押せば通常モードになります)

通常モードで起動次第 SORACOM Beam へデータを送信し始めます (電源投入から送信開始までは15~20秒程度かかります)

## 5. 確認

### 5-1. [MQTT WebSocket Client](http://www.hivemq.com/demos/websocket-client/) を新しいタブで開きます

下記の値を入力して [Connect] をクリックしてください

* Host: `test.mosquitto.org`
* Port: `8080`

※その他は変更する必要はありません

<img src="https://docs.google.com/drawings/d/e/2PACX-1vSydBvuum2Ii-r7uTSpTnMTFHfp_ZFhjxZRIR-wR3srV7c1NXNV8CD3qsE_exFSqLH6hzg-s2atdpzr/pub?w=774&amp;h=254" alt="step5 MQTT PubSub with Mosquitto / ws-client">

### 5-2. Subscribe と Publish の設定

#### Subscribe (Wio LTE → クラウド)

* **Add New Topic Subscription** をクリック
* 表示されたダイアログで **Topic** に **ハンズオン運営から入手した値 (ws-sub-topic)** を入力  
例: `sroot/h0813/02/#`
* [Subscribe] をクリック

<img src="https://docs.google.com/drawings/d/e/2PACX-1vROJ5CYn-9OEUfa2KPKp1TxA-ykFYENhF9Z3vce1TT2EBffBslbhpMeB_rjx5TDFLKHaH3hhR4SI1uM/pub?w=925&amp;h=335" alt="step5 MQTT PubSub with Mosquitto / ws-sub">

Messages に Wio LTE からのデータが表示され始めます。
（表示されている様子は後述します）

#### Publish (クラウド → Wio LTE)

* **Topic** に **ハンズオン運営から入手した値 (ws-pub-topic)** を入力  
例: `sroot/h0813/02/device`
* **Message** に任意の文字を入力する
* [Publish] をクリック

Wio LTE 側のシリアルモニターに Message で入力した文字が受信できていることが確認できます (同時に monitor の Subscribe の方にも表示されます)

<img src="https://docs.google.com/drawings/d/e/2PACX-1vT3FgIejhGH_o_7n_sKL_yJHPKCoqRxCcJyR9fSgzE9Itfq12QwxpMRdOrc3x9rFwnzOgxTGITAEjCX/pub?w=702&amp;h=542" alt="step5 MQTT PubSub with Mosquitto / ws-result">

## 6. やってみよう

MQTT Subscribe メッセージを受信すると、23 行目の `void callback()` という関数が実行されます。
ここを修正することで、クラウドからのコマンドを処理することができるようになります。

今回は「 `#xxxxxx` という文字列を受信したら、 LED の発光色として使う」としてみましょう

変更前;

```c
void callback(char* topic, byte* payload, unsigned int length) {
  SerialUSB.print("Subscribe:");
  for (int i = 0; i < length; i++) SerialUSB.print((char)payload[i]);
  SerialUSB.println("");
}
```

変更後;

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

※ SORACOM カラーを送っている様子

<img src="https://docs.google.com/drawings/d/e/2PACX-1vTrXkJsl_QS3lOgWD7TCN7ayH6uyKGjPTxeobyZKP_hlEaPvZgNbnyLQlrTb1iwViStykwpILg-rR62/pub?w=936&amp;h=410" alt="step5 MQTT PubSub with Mosquitto / ws-result-w-led">

その他の色も試してみてください

## 7. Wio LTE の動作を止める

止める方法は Wio LTE の電源を OFF (= microUSBケーブルを抜く) してください

## うまく動かなかったら（トラブルシュート）

**「マイコンボードに書き込む」を実行した結果、ウィンドウに下記のように表示された**

```
 #include <PubSubClient.h>  // https://github.com/knolleary/pubsubclient
                                                                        ^
compilation terminated.

exit status 1
ボードWio Tracker LTEに対するコンパイル時にエラーが発生しました。
```

* 原因: *PubSubClient* ライブラリが不足しています
* 対策: ステップ5 の本文を読み *PubSubClient* をインストールした後、再度書き込みを行ってください

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

**最初の数回だけ Websockets Client 側で受信ができて、その後の受信が確認できない / Websockets Client 側からの Publish が Wio LTE に届かない**

* 対策: 下記手順を実施してみてください
    1. (Wio LTE の電源が入ったままで) SORACOM Webコンソール上で、当該の SIM のセッションを切断
    2. Wio LTE を再起動 (RST ボタンなど)

**送信しているように見えるが Websocket Client に全く送信されない**

* 原因: PubSubClient のバッファサイズが不足している場合があります
* 対策: `PubSubClient.h` の `MQTT_MAX_PACKET_SIZE` を `128` から大きい数字 (e.g. `512`) に変更して再コンパイルしてください
