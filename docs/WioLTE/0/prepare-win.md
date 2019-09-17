本テキストは [Wio LTE](https://soracom.jp/products/module/wio_lte/) を開発する際に必要な環境を Windows 上に構築する手順です

## 準備するもの

* パソコン / 1台
    * インターネットに接続できる環境
    * USB Type-A ポートが最低1つ以上あり、利用可能なこと
        * 電力供給が1A以上であること (USB 3.0対応していれば概ね安心です)
    * OS: Windows(8.1 もしくは 10)
        * ※ソフトウェアをインストールするため、PCに対する管理者権限を持っている事 と ブラウザでのアクセス制限がかかっていない事

# 開発環境構築の手順

Wio LTE を使うためには、開発環境の準備を行います

* Arduino IDE
    * Wio LTE を扱えるようにする定義のインストール
    * Wio LTE ライブラリのインストール

## 1. Arduino IDE

Wio LTE の開発（ソースコード記述、コンパイル、バイナリファイル転送）には、Arduino IDEを利用します。 Arduino のサイトから [Arduino IDE をダウンロード](https://www.arduino.cc/en/main/software)し、表記に従ってインストールしてください

### 1-1. ダウンロード

![download-arduino](https://docs.google.com/drawings/d/e/2PACX-1vTOGgidIrsQ6NwO4fGlVHHaO_7kHsxBDDq-GzoFM-yZlvDHfjrSXvakwLhTZsYwyE6BTDcVDc4oJ01m/pub?w=841&h=544)

![arduino-ide-download-justdownload](https://docs.google.com/drawings/d/e/2PACX-1vSxk2FHGBqwe5MmiLxMCaJsXfruEOcZH8I_evvvE6jOiuXOKvs2o9Sj7WvG5i7n_-dK8nhZcpd6stgp/pub?w=745&h=472)

### 1-2. インストール

* ダウンロードした EXE ファイルをダブルクリックしてセットアップを開始してください

※スタートメニュー内の **Arduino** が「Arduino IDE」です。これをダブルクリックで Arduino IDE を起動することになります

## 2. ボード定義のインストール

Wio LTE を Arduino IDE で扱えるようにするための機能を追加します

### 2-1. Arduino IDE を起動する

スタートメニュー内の **Arduino** をダブルクリックします

### 2-2. Arduino IDE の [ファイル] > [環境設定]  

![arduino-ide-preference-win](https://docs.google.com/drawings/d/e/2PACX-1vRfOPHq6O844LQMs1CAdR-FpQ6-fKCaZux-OP42_GWksmxDcj6SFrcefLhuNiEsgPr9UPtn9EnTIAAK/pub?w=285&amp;h=387)

下記URL (https:// から .json まで) を 設定タブ にある **追加のボードマネージャのURL:** へ入力して、保存をクリックします

```
https://www.seeed.co.jp/package_SeeedJP_index.json
```

![arduino-pref](https://docs.google.com/drawings/d/e/2PACX-1vRato9UW98VRjlt3A6oDULm9GTattfeIAdyBse9DnNduv1ZnoOBmJCBW_ZNB5aeGsv3qofMQZS7HcXj/pub?w=723&h=625)

### 2-3. メニューの [ツール] > [ボード] > [ボードマネージャ]

一覧の中から **SeeedJP STM32 Boards by Seeed K.K.** を選択しインストールをクリックします  
※ `wio lte` で検索すると見つけやすいです  
※ `(JP Mirror)` となっているボードは選択しないでください

![インストールの様子 wio-lte-handson / board-manager-wiolte](https://docs.google.com/drawings/d/e/2PACX-1vR9IdCB5yo0Zvks5QG9XEVR1MAWilwUoeKHu0ebC0xmjLaUpC7wgwNTuzBS3jH4ER6L2m3I6JVdhrDS/pub?w=781&h=436)  

## 3. Wio LTE ライブラリのインストール

実際のプログラム（Arduino では スケッチと称します）で Wio LTE が使えるようにするライブラリを追加します

### 3-1. Arduino IDE を起動する

### 3-2. Arduino IDE の [スケッチ] > [ライブラリをインクルード] > [ライブラリを管理…]

一覧の中から **Wio LTE for Arduino** を選択しインストールをクリックします  
※ `wio lte` で検索すると見つけやすいです  
※ バージョンの表示は `2.4.0` となっていますが、インストール時の最新バージョンを選択するようにしてください

![インストールの様子 wio-lte-handson / lib-wiolte](https://docs.google.com/drawings/d/e/2PACX-1vRaUkBbjhKKwgX3VBlW644SPUoWibASHvIro6Bxxk28XOjrZjiWX9Y5tGexIe96stSQlFepAUxJfMv2/pub?w=969&h=554)  

## 以上で、事前準備は終了です

Wio LTE の実機をお持ちの方は、[Windows 向けの追加セットアップ](../1/1-setup-windows)を行い、引き続き[元のページ](prepare#check)から作業を続けてください。

実機をお持ちでない方はここで終了となります。当日に追加セットアップを行います。
