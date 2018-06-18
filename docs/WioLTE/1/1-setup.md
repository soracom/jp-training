[LTEモデム搭載プロトタイプ向けデバイス 「Wio LTE」](https://soracom.jp/products/wio_lte/) を用いたハンズオンテキストです

## 準備するもの

* パソコン / 1台
    * ※タブレット等の下記に当てはまらないPCでの受講は自己責任としております
    * Wi-Fi 接続可能
    * USB Type-A ポートが最低1つ以上あり、利用可能なこと
        * 電力供給が1A以上であること (USB 3.0対応していれば概ね安心です)
        * USB Type-C のみの機種につきましては、Type-A への変換アダプタのご用意をお願いいたします
    * OS: macOS(10.11 El Capitan 以上) もしくは Windows(8.1 以上)
    * ブラウザ: Google Chrome
    * ※ソフトウェアをインストールするため、PCに対する管理者権限を持っている事 と ブラウザでのアクセス制限(HTTPプロキシ等)がかかっていない事
* 有効なSORACOMアカウント / 1つ
    * 持っていない場合: 有効なクレジットカード(1枚) と この場で確認可能なメールアドレス(1つ) を利用し [SORACOM アカウントの作成](https://dev.soracom.io/jp/start/console/#account) の手順に沿って作成します
* SORACOMアカウントに登録済みの SORACOM Air SIM (nanoサイズ) / 1つ
    * 未登録の場合: [Air SIM の登録](https://dev.soracom.io/jp/start/console/#registsim) の手順に沿って登録します
* Wio LTE (本体、 アンテナ2本、 電源兼シリアルコンソール用microUSBケーブル) / 1式
* Grove デジタル温湿度センサー (DHT11) / 1つ
* Grove コネクタケーブル / 1つ

## 受講における注意点    

* 本ハンズオンで利用するサービスには有料のものを含んでおります
* ハンズオンに伴い発生した費用（ハンズオン中、ハンズオン後問わず）は原則として受講者にご負担いただいております。係る費用について確認・ご理解いただいたうえでの受講をお願いしております
    *  [SORACOM Air 料金](https://soracom.jp/services/air/cellular/price/)、[SORACOM Harvest 料金](https://soracom.jp/services/harvest/price/)、[SORACOM Beam 料金](https://soracom.jp/services/beam/price/)、[SORACOM Funnel 料金](https://soracom.jp/services/funnel/price/)
* 本ドキュメントで発生した不具合等につきましては弊社は一切責任を負いません

# 開発環境の準備

Wio LTE を使うためには、開発環境の準備を行います  
OS 毎に準備がありますので、下記を参照の上開発環境を準備してください

* [Windows 編](../0/prepare-win.html)
* [macOS 編](../0/prepare-mac.html)

# 追加のインストール(Windowsのみ)

Windows 環境では、さらに以下のインストールが必要となります。

* Virtual COM Port ドライバ
* WinUSB ドライバ
* TeraTerm

これらのインストール方法については、[こちら](1-setup-windows.md)を見ながら、インストールを行って下さい。

# ハンズオン

## 《知識》Wio LTE ハードウェア解説

Wio LTE は Seeed Studio が開発・販売しているマイコンモジュールです  
Grove コネクタと STM32F4 マイコン、LTE Cat.1 モジュールが搭載されており、 Arduino IDE で素早くプロトタイピングができます

![Wio LTE](https://soracom.jp/img/products_wio_lte.png)

### USB 電源・アンテナ・ Grove コネクタピンの番号

![Wio LTE 本体](https://docs.google.com/drawings/d/e/2PACX-1vSgTN46GBaOzqnnmg6tzc7S6UOvzefQhewbGrrRYCrn4RKz1_MMO77zPoCFisCRjztfmHYuac9VIQmN/pub?w=639&h=299)

### Grove IoT スターターキット for SORACOM

「Grove IoT スターターキット for SORACOM」は、 Wio LTE 本体に加え、７つのセンサーと SORACOM Air SIM (日本向け) と SORACOM クーポンが一つにパッケージされたキットです

本ハンズオンでは **デジタル温湿度センサー** を利用します

![Grove IoT スターターキット for SORACOM](https://docs.google.com/drawings/d/e/2PACX-1vT7i6svO5xJj56o0x1aUaW3qhkb4aCWynxSzbwVG3boCqe-TQooCC-qAm0Nfa3QBIb9YIum1G7Zkw-Z/pub?w=640&h=347)

## 《知識》Wio LTE の電源ON/OFFの方法

Wio LTE には電源スイッチがありませんので、下記作業で ON / OFF してください

### 電源 ON

microUSB ケーブルを Wio LTE の microUSB ポートに接続すると自動的にONになります

![Wio LTE と PC を microUSBケーブルで取り付けたところ](https://docs.google.com/drawings/d/e/2PACX-1vSgLUCOrN928URIfbcNC0VR4xwSBOCYm8ngs0d2edkWyu4ZC7VNoXjALvKOXv121zk3RZB2vF9J40fB/pub?w=640&h=480)

### 電源 OFF

microUSB ケーブルを抜きます。いきなり抜いて OK です

※シャットダウン処理は存在しません

## 《知識》Wio LTE の "通常モード" と "DFUモード"

Wio LTE は２つのモードを持っています
**この操作は Wio LTE の開発で何度も行うことになりますので、必ず覚えてください**

* 書き込まれたプログラムを実行する「通常モード」
* プログラムを書き込むことができる「DFUモード」

![フロー](https://docs.google.com/drawings/d/e/2PACX-1vQAcnymqWTTneRwnc9EFz21YvrmfCsIuV33yfqf1ODC_LKQR-6762CJDMclRIWC8BfUeDDLpC6KKs-2/pub?w=581&h=253)

これらのモードの切り替えは Wio LTE 上の **RSTボタン** と **BOOTボタン** の組み合わせで行います  
各ボタンの位置は下記のとおりです（ Wio LTE の表裏にボタンがあるため、横からみた図で確認ください）

![Wio LTE を横からみた図](https://docs.google.com/drawings/d/e/2PACX-1vRnhRiZC7-jRCqLaxJO6E7Bmq0_8BxornXgP1y6UHdYXhr6iBm_RNoV148oSzJKeHBYXRjYai9msQoz/pub?w=480&h=249)

# <a name="LED">【作業】ステップ 1: LED点灯</a>

Wio LTE ライブラリに付属しているスケッチ例から、内蔵のLEDを点灯してみましょう

※Wio LTE 開発ツールの使い方を学びます

![ステップ1 ovewview](https://docs.google.com/drawings/d/e/2PACX-1vQuxiAIWQlqEF0aIgIZtYGemOl7BFPnqKTU3WxKbyk3F8PG0zkhYBWUrVUpJyq8LDqzQwAiBMFUxPKD/pub?w=371&h=247)

## 最初に. Wio LTE の電源を OFF にする

Wio LTE の microUSB ケーブルを抜き、電源を OFF にしてください

※いきなり抜いてOKです。また、すでに OFF になっている場合は次に進んでください

## 1. スケッチを作成する

### 1-1. Arduino IDE を起動する

* Windowsの場合: スタートメニュー等から **Arduino** を起動します
* macOSの場合: アプリケーションフォルダ等の中から **Arduino** を起動します

### 1-2. メニューの [ツール] > [ボード: "Arduino/Genuino UNO] で表示される一覧から **Wio Tracker LTE** を選択

![](https://docs.google.com/drawings/d/e/2PACX-1vQKCIKzOA6NSb0-3kNvL5i9lpZSNAS5OXklLbFITCP2vHvEjM2gL3qKdo8WzYZjifjajFe3YovtiUEI/pub?w=333&h=507)

### 1-3. メニューの [ファイル] > [スケッチ例] > [Wio LTE for Arduino] > [basic] > [LedSetRGB]

### 1-4. Wio LTE を PC を接続して DFUモード にする

### 1-5. 新しく開いたウィンドウの ![マイコンボードに書き込むアイコン](https://docs.google.com/drawings/d/e/2PACX-1vQiO83cFcX3LCXeioiTiaao57T4SGiIV6XZzcBP6poTwssCxmo7hLpoMh5qG3btyqgzs8Q-lAoE6Q0f/pub?w=100&h=100)(マイコンボードに書き込む) をクリック

### 1-6. Arduino IDE のウィンドウ下部に、下記のように表示されたら書き込み完了です  

```
DFU end
can't detach

   もしくは

Resetting USB to switch back to runtime mode
DFU end
```

### 1-7. Wio LTE を 通常モードにする (RSTボタンを押せば通常モードになります)

## 2. 確認

下図のように Wio LTE 内蔵のLEDがカラフルに光ります  

![Wio LTE / LedSetRGB](https://dev.soracom.io/img/gs_wio-lte/wio-lte_led.gif)

ここまでの手順の動画です (画面は Windows ですが、 macOS でも同様の手順です)

[![Wio LTE / LedSetRGB](http://img.youtube.com/vi/g9LiH_g-TuE/0.jpg)](http://www.youtube.com/watch?v=g9LiH_g-TuE)

## 以上で本章は終了です  
[1-2.デバイス稼働時間を SORACOM Harvest で可視化](2-uptime.html) に進んで下さい
