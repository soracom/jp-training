本テキストは [Wio LTE](https://soracom.jp/products/wio_lte/) を開発する際に必要な環境を Windows 上に構築する手順です

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
* TeraTerm

## 4. Arduino IDE

Wio LTE の開発（ソースコード記述、コンパイル、バイナリファイル転送）には、Arduino IDEを利用します。 Arduino のサイトから [Arduino IDE をダウンロード](https://www.arduino.cc/en/main/software)し、表記に従ってインストールしてください

### 4-1. ダウンロード

![download-arduino](https://docs.google.com/drawings/d/e/2PACX-1vTOGgidIrsQ6NwO4fGlVHHaO_7kHsxBDDq-GzoFM-yZlvDHfjrSXvakwLhTZsYwyE6BTDcVDc4oJ01m/pub?w=841&h=544)

![arduino-ide-download-justdownload](https://docs.google.com/drawings/d/e/2PACX-1vSxk2FHGBqwe5MmiLxMCaJsXfruEOcZH8I_evvvE6jOiuXOKvs2o9Sj7WvG5i7n_-dK8nhZcpd6stgp/pub?w=745&h=472)

### 4-2. インストール

* ダウンロードした EXE ファイルをダブルクリックしてセットアップを開始してください

※スタートメニュー内の **Arduino** が「Arduino IDE」です。これをダブルクリックで Arduino IDE を起動することになります

## 5. ボード定義のインストール

Wio LTE を Arduino IDE で扱えるようにするための機能を追加します

### 5-1. Arduino IDE を起動する

スタートメニュー内の **Arduino** をダブルクリックします

### 5-2. Arduino IDE の [ファイル] > [環境設定]  

<img src="https://docs.google.com/drawings/d/e/2PACX-1vRfOPHq6O844LQMs1CAdR-FpQ6-fKCaZux-OP42_GWksmxDcj6SFrcefLhuNiEsgPr9UPtn9EnTIAAK/pub?w=285&amp;h=387">

下記URL (https:// から .json まで) を 設定タブ にある **追加のボードマネージャのURL:** へ入力して、保存をクリックします

```
https://raw.githubusercontent.com/Seeed-Studio/Seeed_Platform/master/package_seeeduino_boards_index.json
```

![追加の様子](https://docs.google.com/drawings/d/e/2PACX-1vRato9UW98VRjlt3A6oDULm9GTattfeIAdyBse9DnNduv1ZnoOBmJCBW_ZNB5aeGsv3qofMQZS7HcXj/pub?w=723&h=625)

### 5-3. メニューの [ツール] > [ボード] > [ボードマネージャ]

一覧の中から **Seeed STM32F4 Boards by Seeed Studio** を選択しインストールをクリックします  
※ `seeed stm32` で検索すると見つけやすいです

![インストールの様子](https://github.com/SeeedJP/WioLTEforArduino/wiki/img-ja/2.png)  

## 6. Wio LTE ライブラリのインストール

実際のプログラム（Arduino では スケッチと称します）で Wio LTE が使えるようにするライブラリを追加します

### 6-1. Arduino IDE を起動する

### 6-2. Arduino IDE の [スケッチ] > [ライブラリをインクルード] > [ライブラリを管理…]

一覧の中から **Wio LTE for Arduino** を選択しインストールをクリックします  
※ `wio lte` で検索すると見つけやすいです

## 1. TeraTerm

Wio LTE からのシリアルコンソールを読み書きするためのソフトウェアです  
※Wio LTE 開発の際、Arduino IDE 標準搭載のシリアルモニターは動作が不安定になることがあるため、TeraTermを利用するようにしてください

検索エンジンで TeraTerm を探し、ダウンロードとインストールを行ってください

## 以上で環境構築は終了です  

[Wio LTE ハンズオン](https://github.com/soracom/handson/wiki/Wio-LTE-%E3%83%8F%E3%83%B3%E3%82%BA%E3%82%AA%E3%83%B3)にお進みください
