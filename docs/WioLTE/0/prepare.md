# 0. 事前準備

本章では、受講に先立って必要な開発環境のインストール作業について説明します。

詳細な手順は Windows / Mac それぞれの環境で異なりますが、おおまかに以下の作業が必要となります。

- 開発環境のインストール
  - Arduino IDE のインストール
  - WioLTE ボード定義のインストール
  - Arduino ライブラリのインストール
  - OS に応じた必要なソフトウェアのインストール
  - テストプログラムのビルド

ダウンロードするファイルサイズも大きいため、当日に行うとかなり時間がかかる可能性があります。 **必ず事前に済ませるようにして下さい。**

## 開発環境のインストール

<h3 id="install">インストール作業</h3>

以下のリンクから、開発環境のインストールを行って下さい。

- [開発環境のインストール(Windows)](prepare-win){:target="_blank"}
- [開発環境のインストール(Mac)](prepare-mac){:target="_blank"}

<h3 id="check">確認</h3>

#### チェックリスト

以下のリストですべてがインストールされているか確認してください。

**Windows の方**

* **Arduino IDE** のインストール
* ボード定義 **SeeedJP STM32 Boards by Seeed K.K.** のインストール
* ライブラリ **Wio LTE for Arduino** のインストール
* **Virtual COM Port ドライバ** のインストール
* **WinUSB ドライバ** のインストール

**macOS の方**

* **Arduino IDE** のインストール
* ボード定義 **SeeedJP STM32 Boards by Seeed K.K.** のインストール
* ライブラリ **Wio LTE for Arduino** のインストール
* **Homebrew** のインストール
* **libusb** のインストール

不足している場合は [インストール作業](#install) を参照しながら完了させてください。

#### 実際にスケッチを動作させてみる

Wio LTE の実機がある場合はセットアップが正しく行われているか確認することができます。サンプルのプログラムをコンパイルしてみて、正しくインストールが出来たかを確認しましょう。

※この時点で Wio LTE の実機が手元にない場合はハンズオン当日に確認することになります。

1. Arduino IDE で、ツール → ボード から、Seeed Wio LTE Cat.1 を選択
![ボードの選択](https://docs.google.com/drawings/d/e/2PACX-1vQKCIKzOA6NSb0-3kNvL5i9lpZSNAS5OXklLbFITCP2vHvEjM2gL3qKdo8WzYZjifjajFe3YovtiUEI/pub?w=333&h=507)

2. ファイル → スケッチ例 → Wio LTE for Arduino → basic → LedSetRGB を選択
![スケッチ例を開く](images/open_sketch.png)

3. ファイル のすぐ下にあるチェックアイコンをクリックし、しばらくして「コンパイルが完了しました。」と表示されれば、インストール状態は正常です。
![検証](images/verify.png)

> もしコンパイルに非常に長い時間がかかってしまう場合、PC のスペックが低い可能性があります。
> その場合時間内にハンズオンが完了出来ない可能性があるため、より性能の高い PC のご準備をご検討下さい。

## 以上で本章は終了です

達成状況を運営表へご記入ください。

* [目次ページへ戻る](../)
