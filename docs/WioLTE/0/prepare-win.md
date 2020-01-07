本テキストは [Wio LTE](https://soracom.jp/products/module/wio_lte/) を開発する際に必要な環境を Windows 上に構築する手順です

## 準備するもの

* パソコン / 1台
    * インターネットに接続できる環境
    * USB Type-A ポートが最低1つ以上あり、利用可能なこと
        * 電力供給が1A以上であること (USB 3.0対応していれば概ね安心です)
    * OS: Windows(8.1 もしくは 10)
        * ※ソフトウェアをインストールするため、PCに対する管理者権限を持っている事 と ブラウザでのアクセス制限がかかっていない事

# 開発環境構築の手順

Windows 上で Wio LTE を用いた開発を行うための環境準備を行います

* Arduino IDE
    * Wio LTE を扱えるようにする定義のインストール
    * Wio LTE ライブラリのインストール
* Virtual COM Port ドライバ
* WinUSB ドライバ

## 1. Arduino IDE

Wio LTE の開発（ソースコード記述、コンパイル、バイナリファイル転送）には、Arduino IDEを利用します。

### 1-1. Windows 10 の設定を確認する

Windows 10 の方は以下の手順を行ってください。それ以外のバージョンの方は "ダウンロード" へ進んでください。

[スタートメニュー] > [設定] > [アプリ] > [アプリと機能] > [アプリを入手する場所の選択] を開き、 **場所を選ばない** を選びます。（すでに選択されている場合は次に進みます）

![インストールの様子 wio-lte-handson / windows10-avoid-storeinstall](https://docs.google.com/drawings/d/e/2PACX-1vQGyXWteZi1AUiwGmRQPyWPfR3GIM9SjjYjWF0V2kbwo6SjkG4qPSPWsYbbsRr4pOn2z43BeTAYLomd/pub?w=928&h=374)

※ "Microsoft Store のみ" となっている場合、 Microsoft Store 版 Arduino IDE が強制的にインストールされ、本ハンズオンを進めることができません。

### 1-2. ダウンロード

Arduino のサイトから [Arduino IDE をダウンロード](https://www.arduino.cc/en/main/software){:target="_blank"} し、表記に従ってインストールしてください

#### ダウンロードの手順

![インストールの様子 wio-lte-handson / download-arduino](https://docs.google.com/drawings/d/e/2PACX-1vTOGgidIrsQ6NwO4fGlVHHaO_7kHsxBDDq-GzoFM-yZlvDHfjrSXvakwLhTZsYwyE6BTDcVDc4oJ01m/pub?w=841&h=544)

![インストールの様子 wio-lte-handson / arduino-ide-download-justdownload](https://docs.google.com/drawings/d/e/2PACX-1vSxk2FHGBqwe5MmiLxMCaJsXfruEOcZH8I_evvvE6jOiuXOKvs2o9Sj7WvG5i7n_-dK8nhZcpd6stgp/pub?w=745&h=472)

### 1-3. インストール

* ダウンロードした EXE ファイルをダブルクリックしてセットアップを開始してください

※スタートメニュー内の **Arduino** が「Arduino IDE」です。これをダブルクリックで Arduino IDE を起動することになります

## 2. ボード定義のインストール

Wio LTE を Arduino IDE で扱えるようにするための機能を追加します

### 2-1. Arduino IDE を起動する

スタートメニュー内の **Arduino** をダブルクリックします

### 2-2. Arduino IDE の [ファイル] > [環境設定]  

![インストールの様子 wio-lte-handson / arduino-ide-preference-win](https://docs.google.com/drawings/d/e/2PACX-1vRfOPHq6O844LQMs1CAdR-FpQ6-fKCaZux-OP42_GWksmxDcj6SFrcefLhuNiEsgPr9UPtn9EnTIAAK/pub?w=285&amp;h=387)

下記URL (https:// から .json まで) を 設定タブ にある **追加のボードマネージャのURL:** へ入力して、保存をクリックします

```
https://www.seeed.co.jp/package_SeeedJP_index.json
```

![インストールの様子 wio-lte-handson / arduino-pref](https://docs.google.com/drawings/d/e/2PACX-1vRato9UW98VRjlt3A6oDULm9GTattfeIAdyBse9DnNduv1ZnoOBmJCBW_ZNB5aeGsv3qofMQZS7HcXj/pub?w=723&h=625)

### 2-3. メニューの [ツール] > [ボード] > [ボードマネージャ]

一覧の中から **SeeedJP STM32 Boards by Seeed K.K.** を選択しインストールをクリックします  
※ `wio lte` で検索すると見つけやすいです  
※ `(JP Mirror)` となっているボードは選択しないでください
※ インターネットから必要なファイルをダウンロードしながらインストールされるため、ネットに接続した環境で行ってください
※ 約 350MB 分のダウンロードとファイルの展開が行われるため、15分～1時間くらいかかることがあります。受講当日に行うと時間が不足する可能性がありますので事前に済ませるようにお願いします

![インストールの様子 wio-lte-handson / board-manager-wiolte](https://docs.google.com/drawings/d/e/2PACX-1vR9IdCB5yo0Zvks5QG9XEVR1MAWilwUoeKHu0ebC0xmjLaUpC7wgwNTuzBS3jH4ER6L2m3I6JVdhrDS/pub?w=781&h=436)  

## 3. Wio LTE ライブラリのインストール

実際のプログラム（Arduino では スケッチと称します）で Wio LTE が使えるようにするライブラリを追加します

### 3-1. Arduino IDE を起動する

### 3-2. Arduino IDE の [スケッチ] > [ライブラリをインクルード] > [ライブラリを管理…]

一覧の中から **Wio LTE for Arduino** を選択しインストールをクリックします  
※ `wio lte` で検索すると見つけやすいです  
※ バージョンの表示は `2.4.0` となっていますが、インストール時の最新バージョンを選択するようにしてください
※ インターネットから必要なファイルをダウンロードしながらインストールされるため、ネットに接続した環境で行ってください

![インストールの様子 wio-lte-handson / lib-wiolte](https://docs.google.com/drawings/d/e/2PACX-1vRaUkBbjhKKwgX3VBlW644SPUoWibASHvIro6Bxxk28XOjrZjiWX9Y5tGexIe96stSQlFepAUxJfMv2/pub?w=969&h=554)  

## 4. Virtual COM Port ドライバ

Wio LTE のシリアルポートを PC で認識するためのドライバです。

### 4-1. [Virtual COM Portデバイスドライバーのインストール](https://seeedjp.github.io/Wiki/Wio_LTE_for_Arduino/InstallVCOMDriver-ja.html){:target="_blank"} から `stsw-stm32102.zip` をダウンロードします。

### 4-2. ダウンロードしてきた ZIP ファイルの中の `VCP_V1.4.0_Setup.exe` を実行します。

この時「インストーラーのような画面」が表示されますが、これは **インストーラーではありません** 。この後の手順を必ず実行してください。

### 4-3. [Virtual COM Portデバイスドライバーのインストール](https://seeedjp.github.io/Wiki/Wio_LTE_for_Arduino/InstallVCOMDriver-ja.html){:target="_blank"} のページに記載されている表を見ながら、 使用している OS に対応する **インストールファイル** を確認してください。

### 4-4. スタートボタンを右クリックして [ファイル名を指定して実行] の [名前] に 3 で得た **インストールファイル** を入力して [OK] を押します。

![インストールの様子 wio-lte-handson / exec-stm32-serialport-setup](https://docs.google.com/drawings/d/e/2PACX-1vQ4MRWBOb1-JorXUkDl8N1dh7rF78DfHSPpdERCFfjAwe3h-PNc3VYElAbwkEmgagv7vKLvRAqKTs_x/pub?w=396&h=205)

<h2 id="winusb">5. WinUSB ドライバ</h2>

Wio LTE にプログラムを書き込む際に必要なドライバです。

### 5-1. [Zadigサイト](http://zadig.akeo.ie/){:target="_blank"} の Download にある **Zadig 2.4** をクリックして `zadig-2.4.exe` をダウンロードします

![インストールの様子 wio-lte-handson / download-zadig](https://docs.google.com/drawings/d/e/2PACX-1vTX0TOFbG8GpppIHkN3u5gEjnHQOW-Uu26KFuK8sja4B6GzJslDGLmtdU620LYjW2jW3g8FfiGkigvY/pub?w=455&h=233)

※ 上記でダウンロードできない場合は [ここからダウンロード](https://1drv.ms/u/s!Auk44HCq4iKog4BP5WiPepqRJ9sLpg?e=o0h0J6){:target="_blank"} してください

### 5-2. zadig-2.4.exe を起動する

※ 最初に表示されるダイアログ(Zadig update policy)は [No] としておいてください

### 5-3. zadig-2.4.exe の [Options] > [List All Devices] を選択する

![インストールの様子 wio-lte-handson / zadig-list-all-devices](https://docs.google.com/drawings/d/e/2PACX-1vQ0BPpg4cOZXuuvSl2X7mN3Z86WjTb0LmZ-NCpgwhSmop_S8zCYyR-9RevO9OrQmAFsFA06NI1GSDeb/pub?w=573&h=253)

### 5-4. Wio LTE を DFUモード に切り替えます

**ここからは Wio LTE 本体が必要です。**  
無い場合はここで終了です。後日、Wio LTE 本体を入手した後に、ここから再開することになります。

#### 「DFUモード」への切り替え方

Wio LTE に microUSB を挿した状態(電源ONの状態) にしてから、下記操作を行います。

1. *BOOTボタン* を押し、 **押し続けてください**
2. *RSTボタン* を押し、離します
3. 押し続けていた *BOOTボタン* を離します

DFU モードへの移行方法  
※動画ではmicroUSB接続をしていませんが、実際は接続した状態で行ってください

![to-dfu.gif](https://drive.google.com/uc?export=view&id=1d6UmE2_SXy7bkwZ30NSpSIK1Px0ErU9U)

### 5-5. 一覧から **STM32 BOOTLOADER** を選んだ後、Driver欄の左を *STTub30* 、右を *WinUSB* に変更してから、Replace Driverをクリックします

`STM32 BOOTLOADER` が一覧に表示されない場合はDFU モードへの移行へ失敗しています。（Wio LTE 本体がない場合も同様に表示されません）  
「DFU モードへの切り替え方」を再度行ってください。（成功すれば一覧に表示されます）

![](https://github.com/SeeedJP/WioLTEforArduino/wiki/img/11.png)

Replace Driver が失敗する時は PC への管理者権限、インターネット接続を確認してください。  
※ `zadig-2.4.exe` は必要なファイルをインターネットから入手することがあります。アンチウィルスソフトによっては、不定のソフトウェアからの通信をブロックするものがあるため、通信設定を管理者に確認するようにしてください。

## 以上で、事前準備は終了です

[元のページ](prepare#check)に戻り、インストール状態の確認を行って下さい。
