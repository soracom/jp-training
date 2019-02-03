# 0. おわりに

おつかれさまでした  
Wio LTE ハンズオンは以上で終了です。最後に注意点の確認をお願いいたします

## 《知識》今後の費用について

SORACOM Air SIM は**実際の通信の有無に限らず**日当たりの基本料金が発生いたします    
詳細は [ご利用料金 - 日本向け Air SIM](https://soracom.jp/services/air/price/) をご覧ください

### SORACOM Harvest

本ハンズオンで使用した SORACOM Harvest は、**実際の通信の有無に限らず** SORACOM Harvest が利用可能状態の SIM の枚数に応じて日当たりのオプション料金が発生します  
詳細は [SORACOM Harvest のご利用料金](https://soracom.jp/services/harvest/price/) をご覧ください

### SORACOM Beam および SORACOM Funnel

本ハンズオンで使用した SORACOM Beam および SORACOM Funnel は、発生したリクエストに応じた課金がされるサービスです  
詳細は [SORACOM Beam のご利用料金](https://soracom.jp/services/beam/price/) ならびに [SORACOM Funnel のご利用料金](https://soracom.jp/services/funnel/price/) をご覧ください

### クーポンの登録方法

[クーポンコードの使い方](https://soracom.zendesk.com/hc/ja/articles/218121348-%E3%82%AF%E3%83%BC%E3%83%9D%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9%E3%82%92%E6%95%99%E3%81%88%E3%81%A6%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84)をご覧ください

※その他[クーポンに関する注意事項](https://soracom.zendesk.com/hc/ja/articles/115002423011-%E3%82%AF%E3%83%BC%E3%83%9D%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E9%81%A9%E7%94%A8%E3%81%97%E3%81%A6%E3%81%84%E3%81%A6%E3%82%82%E6%96%99%E9%87%91%E3%81%8C%E8%AB%8B%E6%B1%82%E3%81%99%E3%82%8B%E3%81%AE%E3%81%AF%E3%81%AA%E3%81%9C%E3%81%A7%E3%81%99%E3%81%8B-)もご参照ください

### 長期利用割引

Air SIM のご契約期間をお約束いただくことで、基本料金が割引になる仕組みをご検討ください

* [長期利用割引 - 日本向け Air SIM](https://soracom.jp/services/air/cellular/discount_price/)
* [長期利用割引に関する手続きやFAQ](https://blog.soracom.jp/blog/2017/05/23/long-term-discount/)

### MQTT ブローカーについて

今回利用した Mosquitto の MQTT ブローカーは、試験用の公開サーバです。誰でも読み書きが可能であるため、実システムでの利用はおやめください。

代替するプロダクトは以下の通りです

* オンプレ型
    * [Mosquitto](https://mosquitto.org/)
* フルマネージド型
    * [Amazon MQ](https://aws.amazon.com/jp/amazon-mq/)
    * [AWS IoT Core](https://aws.amazon.com/jp/iot-core/)
    * [Azure IoT Hub](https://azure.microsoft.com/ja-jp/services/iot-hub/)
    * [Google Cloud IoT Core](https://cloud.google.com/iot-core/)
    * [PubNub](https://www.pubnub.com/)

※ すべてが MQTT の機能をサポートしているわけでは無いので要件に応じてご選択ください。

## 【作業】Wio LTE を片付ける

### Wio LTE の初期化

Wio LTE を初期化しておくことで、次回起動時に不用意な通信などを防ぐことができます

作業としては「空っぽのスケッチ」を書き込むことで、初期化できます

1. Arduino IDE を起動する
2. メニューの [ツール] で [ボード: "Seeed Wio LTE Cat.1"] と表示されていることを確認する
    * なっていなければ一覧から "Seeed Wio LTE Cat.1" を選んでください
3. Arduino IDE の [ファイル] > [新規ファイル]
4. Wio LTE を PC を接続して DFUモード にする
5. 新しく開いたウィンドウの ![マイコンボードに書き込むアイコン](https://docs.google.com/drawings/d/e/2PACX-1vQiO83cFcX3LCXeioiTiaao57T4SGiIV6XZzcBP6poTwssCxmo7hLpoMh5qG3btyqgzs8Q-lAoE6Q0f/pub?w=100&h=100)(マイコンボードに書き込む) をクリック
6. 書き込みが完了したら、Wio LTE を 通常モードにする (RSTボタンを押せば通常モードになります)

### SIM の取り出し

<img src="https://docs.google.com/drawings/d/e/2PACX-1vSHV26TeW7Z3rEbr-OOVQ-6GyI8GijLNChn5ayEspNVPZqmbZTj3pkDdBCZhLEetrMqLdDuXm-GpQk9/pub?w=683&amp;h=322">

<img src="https://docs.google.com/drawings/d/e/2PACX-1vRn4PgJFdW-IV-Fr4JTq7dj6wz4KBSyG3pM6W4Wxdbtt-FunzEy4aSK1_QpssqfoATEWfP_9IJL8vtV/pub?w=508&amp;h=370">

**抜く際フックを引っ張りすぎると金具が取れてしまうため、図示されている程度まで引っ張り出したらSIMを取り出し、金具を元に戻してください**

### 箱へ戻す

手渡された時同様に箱へ格納してください

* アンテナは取り外して Wio LTE 本体が格納されていた白いトレーのミゾに入れてください
* microUSB ケーブルは白いトレーを取り外した中に入れてください

### 本コンテンツについて

本コンテンツの著作は株式会社ソラコムに帰属します。再利用についてはソラコムへお問合せください。
