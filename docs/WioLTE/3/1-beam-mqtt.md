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
MIIEowIBAAKCAQEAurCuWJ96Pjn5Iy4nezDZsWsfn5oEAi+miHxrDQX4ligeW4gh
YXtvwlPf8vUxjkwkWgWNVlD2WRZbjhlSiwtzxGbBxtiGxvMGiAtdBNW4s5RzWn58
aWcXAOGAEtHSLDaxbFQheoyH0zYicYDZqpGprEIV5IU5zN8Y2kqf8sa81QjC0pr9
kM0bGM4uulJwTPiLmw93bg8w3Hg2i1w/2LLxuO/0whCQcgX0C2+H4nJVsYTWbbsW
xEHxy5jvCNOxnHHP5opjrj11F4M1mH4S9gJZ0LzMXozvOtIm9aL7sVPvw4o60GWY
C2cqFQoD00cGcNtU8+nHkLebR8PsFzyVTvo7kQIDAQABAoIBAGFPFpE7DwzASwv7
UrjzjYTcwW7/aHd7PuKFd4ciRaB+6NPs8PlOzcIM1f5dr6bsKUaC/liveriU3sQC
jvPK1Fza8sYitp2crxraUXHjtJJmHnpc05xdD7B12bv1ggdpurEsaQbnmSSOYwWm
k85Efpw7Fg43IxmWb+3YV+bDkEm5kgAmonVWcnqhlSN3yXT9JFDZVyf+u319hzgk
mpq6vdlEcLjFSXUmpqt5krocO+HqseJgYB9xrNSModX6uYgcn9jxqc9+N9rxbpsD
soabJgSGO0ys/97ItR9nilhtRo57XwYYRhq0UfBc6noQpW/qpuU9d+d07Qa9DIe9
nNhfYAECgYEA9G+Z3kFvsNZYDK2/nd9RyhxzdtJaO/4Ho/9ktjfq7ObPwLOMHa4G
uqeHQA2e6JhBaZYM5k0HFl5a81P0aRMtlJECor1GppEyzaSHh3tyVRoPMErvLzta
nKU++pOi4uv5zaZhdgr2gNSa+9Y3BvLkDH1YhNCpuvB+LYSyMzLG0eECgYEAw4W2
Zq85JRDKMGZoCdll0RjyRmI6RCfBO+6PrZrdqFfN32x6mWrJLYDsQD/o9uKJbAZt
TR/stMUutQ/oKPrFjRGINnDYDj8FJzruK3n7AAopPAKG/mF8bVsWWhYzRqsvM3pr
KSx8y/1LdSu+GxD4blq3aZAdjOspTVhPWt70/7ECgYBxsJ6ug10BsRBPBVlEgqQ2
DzmdIIWbtbG0E4uyPRvliA1FIb2f6Ft04YrEvhEVOgvioknprBYJz2UaHAhn/uWK
XlANhV+hBZPNliL7Xu10q6Q44AGTxFWG2k0KmzR9uyf7ANH/52Vz0m8rhx0c/EgZ
jwtm6u6m5kipvzhrG8jhwQKBgHV+qdDlJWr/vvD86TJaARR5cEYZizgfx8BTKOZD
dUZPlXjZAIenI0QEAHTPsxiBo+FVr2M0dxNelyXZbEMMB6ExUvCcOUm+V0Nu52cb
A1nPwV29iw/c12AD59e1FZU3E8NUoob4o/oVub2szq4HMbNnMmbuYsOnIYfINM+/
wezRAoGBAKpxO3t6l9rFtC+3A1iWC9IYMmqWXmq76cbGCj9iQSp34K7fJUyo6J0T
PGY9hmbEvzGLu1QK+x9MuaVWr92u3KUDpzwVsA6RqPn03mweY/xh4UzAZbpNby2e
2OxAERCQpnjpypKuOgoze+K4da9knfbJ57/w1yGO+V2Dxj5b057o
-----END RSA PRIVATE KEY-----
```

**証明書**;

```
-----BEGIN CERTIFICATE-----
MIIC+zCCAmSgAwIBAgIBADANBgkqhkiG9w0BAQsFADCBkDELMAkGA1UEBhMCR0Ix
FzAVBgNVBAgMDlVuaXRlZCBLaW5nZG9tMQ4wDAYDVQQHDAVEZXJieTESMBAGA1UE
CgwJTW9zcXVpdHRvMQswCQYDVQQLDAJDQTEWMBQGA1UEAwwNbW9zcXVpdHRvLm9y
ZzEfMB0GCSqGSIb3DQEJARYQcm9nZXJAYXRjaG9vLm9yZzAeFw0xODEyMDEwNzMw
MDBaFw0xOTAzMDEwNzMwMDBaMFYxCzAJBgNVBAYTAkpQMQ4wDAYDVQQIDAVUb2t5
bzEWMBQGA1UECgwNU09SQUNPTSwgSU5DLjEfMB0GA1UEAwwWdGVzdG1xdHQuc29y
YWNvbS5sb2NhbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALqwrlif
ej45+SMuJ3sw2bFrH5+aBAIvpoh8aw0F+JYoHluIIWF7b8JT3/L1MY5MJFoFjVZQ
9lkWW44ZUosLc8RmwcbYhsbzBogLXQTVuLOUc1p+fGlnFwDhgBLR0iw2sWxUIXqM
h9M2InGA2aqRqaxCFeSFOczfGNpKn/LGvNUIwtKa/ZDNGxjOLrpScEz4i5sPd24P
MNx4NotcP9iy8bjv9MIQkHIF9Atvh+JyVbGE1m27FsRB8cuY7wjTsZxxz+aKY649
dReDNZh+EvYCWdC8zF6M7zrSJvWi+7FT78OKOtBlmAtnKhUKA9NHBnDbVPPpx5C3
m0fD7Bc8lU76O5ECAwEAAaMaMBgwCQYDVR0TBAIwADALBgNVHQ8EBAMCBeAwDQYJ
KoZIhvcNAQELBQADgYEAP+jL1ad+R+RpAXUviWeCYqzF2WOU4As3dERPqFS8N4ym
lkS2q2/9vfF6zuUTIltEAKi7FtKXjWg4l3B/lL2IjaMhOvmtOlrwG+Fhu0TxIoKw
cnAurb66+aqMU0Id9dJbrd+Y+BfV3I1Dw3WWXr3Ufmt/Dl/yKgjY7mvQPDd9E2s=
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

<h2 id="pubsubclient_install">3. PubSubClient ライブラリのインストール</h2>

MQTT 通信を行うにあたり PubSubClient というライブラリを利用します  
※ 公式の PubSubClient では、パケットサイズが小さいため若干不都合が発生することが確認されています。そのため、ハンズオン側で準備した fork ライブラリを使用してください

### 3-1. fork されたライブラリをダウンロードする

https://github.com/SeeedJP/pubsubclient/releases のページから 2.6 の ZIP をダウンロードします

### 3-2. Arduino IDE を起動する

### 3-3. Arduino IDE の [スケッチ] > [ライブラリをインクルード] > [.ZIP 形式のライブラリをインストール...]

![wio-lte-handson / zip-lib](https://docs.google.com/drawings/d/e/2PACX-1vSyvtSl8JWQO_D5-pkwQsp0YVrrWOU76GlZohHURcIIEU-5W3PreVa9tCTUyYI94mId_y5zICWpC6xJ/pub?w=555&h=273)

先ほどダウンロードした `pubsubclient-2.6.zip` を探して「開く」をクリックすればインストール完了です

## 4. スケッチを作成する

### 4-1. Arduino IDE を起動する

### 4-2. メニューの [ツール] で [ボード: "Seeed Wio LTE Cat.1"] と表示されていることを確認する

なっていなければ一覧から "Seeed Wio LTE Cat.1" を選んでください

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

変更後の例 (この値をそのまま使わずに `ID` や `OUT_TOPIC` や `IN_TOPIC` の値はハンズオン運営から入手してください)

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

※ SORACOM カラーを送っている様子

<img src="https://docs.google.com/drawings/d/e/2PACX-1vTrXkJsl_QS3lOgWD7TCN7ayH6uyKGjPTxeobyZKP_hlEaPvZgNbnyLQlrTb1iwViStykwpILg-rR62/pub?w=936&amp;h=410" alt="step5 MQTT PubSub with Mosquitto / ws-result-w-led">

その他の色も試してみてください

## 7. Wio LTE の動作を止める

止める方法は Wio LTE の電源を OFF (= microUSBケーブルを抜く) してください

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

**最初の数回だけ Websockets Client 側で受信ができて、その後の受信が確認できない / Websockets Client 側からの Publish が Wio LTE に届かない**

* 対策: 下記手順を実施してみてください
    1. (Wio LTE の電源が入ったままで) SORACOM Webコンソール上で、当該の SIM のセッションを切断
    2. Wio LTE を再起動 (RST ボタンなど)

**送信しているように見えるが Websocket Client に全く送信されない**

* 原因: PubSubClient のバッファサイズが不足している場合があります
* 対策: `PubSubClient.h` の `MQTT_MAX_PACKET_SIZE` を `128` から大きい数字 (e.g. `512`) に変更して再コンパイルしてください (本手順で案内している fork されたライブラリでは本修正がされています)

