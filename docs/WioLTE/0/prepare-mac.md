本テキストは [Wio LTE](https://soracom.jp/products/module/wio_lte/) を開発する際に必要な環境を macOS 上に構築する手順です

## 準備するもの

* パソコン / 1台
    * インターネットに接続できる環境
    * USB Type-A ポートが最低1つ以上あり、利用可能なこと
        * 電力供給が1A以上であること (USB 3.0対応していれば概ね安心です)
    * OS: macOS (10.11 El Capitan 以上)
        * ※ソフトウェアをインストールするため、PCに対する管理者権限を持っている事 と ブラウザでのアクセス制限がかかっていない事

# 開発環境構築の手順

Wio LTE を使うためには、開発環境の準備を行います

* Homebrew
    * libusb
* Arduino IDE
    * Wio LTE を扱えるようにする定義のインストール
    * Wio LTE ライブラリのインストール

## 1. Homebrew

後述する libusb をインストールするために必要です

### 1-1. Terminal.app を起動する

Terminal.app 内で下記コマンドを実行します  
※途中でパスワード入力を求めらたら macOS ログイン時のパスワードを入力してください

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

最終的に下記のように表示されればインストール成功です

```
==> Next steps:
- Run `brew help` to get started
- Further documentation:
   https://docs.brew.sh```
```

## 2. libusb

Wio LTE を DFU(Device Firmware Upgrade) モード に切り替えてファイル書き込みを行う際に必要なドライバです

### 2-1. Terminal.app を起動する

Terminal.app 内で下記コマンドを実行します

```
brew install libusb
```

最終的に下記のように表示されればインストール成功です

```
==> Downloading https://homebrew.bintray.com/bottles/libusb-1.0.21.el_capitan.bo
######################################################################## 100.0%
==> Pouring libusb-1.0.21.el_capitan.bottle.tar.gz
:beer:  /usr/local/Cellar/libusb/1.0.21: 29 files, 510.5KB
```

## 3. Arduino IDE

Wio LTE の開発（ソースコード記述、コンパイル、バイナリファイル転送）には、Arduino IDEを利用します。 Arduino のサイトから [Arduino IDE をダウンロード](https://www.arduino.cc/en/main/software)し、表記に従ってインストールしてください

### 3-1. ダウンロード

![download-arduino](https://docs.google.com/drawings/d/e/2PACX-1vTOGgidIrsQ6NwO4fGlVHHaO_7kHsxBDDq-GzoFM-yZlvDHfjrSXvakwLhTZsYwyE6BTDcVDc4oJ01m/pub?w=841&h=544)

![arduino-ide-download-justdownload](https://docs.google.com/drawings/d/e/2PACX-1vSxk2FHGBqwe5MmiLxMCaJsXfruEOcZH8I_evvvE6jOiuXOKvs2o9Sj7WvG5i7n_-dK8nhZcpd6stgp/pub?w=745&h=472)

### 3-2. インストール

* ダウンロードした ZIP ファイルをダブルクリックして展開してください
* 展開後の **Arduino** アイコンを "アプリケーション" フォルダへ移動してください

※アプリケーションフォルダに移動した **Arduino** が「Arduino IDE」です。これをダブルクリックで Arduino IDE を起動することになります

## 4. ボード定義のインストール

Wio LTE を Arduino IDE で扱えるようにするための機能を追加します

### 4-1. Arduino IDE を起動する

アプリケーションフォルダ内の **Arduino** をダブルクリックします

### 4-2. メニューの [Arduino] > [Preferences...]  

![arduino-ide-preference-macos](https://docs.google.com/drawings/d/e/2PACX-1vREQ-eB07cNZXDjqQgnRR9rgKdp-PNEYL_partr41CApadlssk30V2Npu0bSBOMAX-qnT2fz0ULNwG8/pub?w=275&h=314)

下記URL (https:// から .json まで) を 設定タブ にある **追加のボードマネージャのURL:** へ入力して、保存をクリックします

```
https://www.seeed.co.jp/package_SeeedJP_index.json
```

![arduino-pref](https://docs.google.com/drawings/d/e/2PACX-1vRato9UW98VRjlt3A6oDULm9GTattfeIAdyBse9DnNduv1ZnoOBmJCBW_ZNB5aeGsv3qofMQZS7HcXj/pub?w=723&h=625)

### 4-3. メニューの [ツール] > [ボード] > [ボードマネージャ]

一覧の中から **SeeedJP STM32 Boards by Seeed K.K.** を選択しインストールをクリックします  
※ `wio lte` で検索すると見つけやすいです  
※ `(JP Mirror)` となっているボードは選択しないでください

![インストールの様子 wio-lte-handson / board-manager-wiolte](https://docs.google.com/drawings/d/e/2PACX-1vR9IdCB5yo0Zvks5QG9XEVR1MAWilwUoeKHu0ebC0xmjLaUpC7wgwNTuzBS3jH4ER6L2m3I6JVdhrDS/pub?w=781&h=436)  

## 5. Wio LTE ライブラリのインストール

実際のプログラム（Arduino では スケッチと称します）で Wio LTE が使えるようにするライブラリを追加します

### 5-1. Arduino IDE を起動する

### 5-2. Arduino IDE の [スケッチ] > [ライブラリをインクルード] > [ライブラリを管理…]

一覧の中から **Wio LTE for Arduino** を選択しインストールをクリックします  
※ `wio lte` で検索すると見つけやすいです  
※ バージョンの表示は `2.4.0` となっていますが、インストール時の最新バージョンを選択するようにしてください

![インストールの様子 wio-lte-handson / lib-wiolte](https://docs.google.com/drawings/d/e/2PACX-1vRaUkBbjhKKwgX3VBlW644SPUoWibASHvIro6Bxxk28XOjrZjiWX9Y5tGexIe96stSQlFepAUxJfMv2/pub?w=969&h=554)  

## 以上で環境構築は終了です

[元のページ](prepare#check)に戻り、インストール状態の確認を行って下さい。

## うまく動かなかったら（トラブルシュート）

古い Xcode がインストールされていると Homebrew のインストールに失敗します  
Xcode をアンインストールし、 `/Library/Developer/CommandLineTools` フォルダをリネームもしくは削除したうえで、再度 Homebrew をインストールしてください (Xcodeの再インストールは不要です)

**※アンインストール作業については特にご注意ください!!**

デフォルトSHELLが bash じゃないと homebrew のインストールコマンドで失敗します (評価をミスる)  
`curl ... | ruby` として流し込んでみてください
