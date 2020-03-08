# 0. おわりに

おつかれさまでした  
Wio LTE ハンズオンは以上で終了です。最後に注意点の確認をお願いいたします

## 《知識》今後の費用について

### SORACOM IoT SIM

SORACOM IoT SIM (plan-D) は **実際の通信の有無に限らず** 基本料金が発生します

![soracom-air-fee](https://docs.google.com/drawings/d/e/2PACX-1vTyDaN2Byyqo_yBajXD8ozVEvXkQUqdcNWkfKc-H0EKWzUEKXwfMh4Sy7d1Bh80ZzVQ9FXCZwT02bTN/pub?w=928&h=523)

詳細は [ご利用料金 - 特定地域向け IoT SIM](https://soracom.jp/services/air/cellular/price_specific_area_sim/) をご覧ください

### SORACOM Harvest

本ハンズオンで使用した SORACOM Harvest は、**実際の通信の有無に限らず** SORACOM Harvest が利用可能状態の SIM の枚数に応じて日当たりのオプション料金が発生します  
詳細は [SORACOM Harvest のご利用料金](https://soracom.jp/services/harvest/price/) をご覧ください

### SORACOM Beam および SORACOM Funnel

本ハンズオンで使用した SORACOM Beam および SORACOM Funnel は、発生したリクエストに応じた課金がされるサービスです  
詳細は [SORACOM Beam のご利用料金](https://soracom.jp/services/beam/price/) ならびに [SORACOM Funnel のご利用料金](https://soracom.jp/services/funnel/price/) をご覧ください

### クーポンの登録方法

[Grove IoT スターターキット for SORACOM](https://soracom.jp/products/kit/grovestarter_kit_lte/)等に同梱されているクーポンの利用方法は、[クーポンコードの使い方](https://soracom.zendesk.com/hc/ja/articles/218121348-%E3%82%AF%E3%83%BC%E3%83%9D%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9%E3%82%92%E6%95%99%E3%81%88%E3%81%A6%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84)をご覧ください

※その他[クーポンに関する注意事項](https://soracom.zendesk.com/hc/ja/articles/115002423011-%E3%82%AF%E3%83%BC%E3%83%9D%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E9%81%A9%E7%94%A8%E3%81%97%E3%81%A6%E3%81%84%E3%81%A6%E3%82%82%E6%96%99%E9%87%91%E3%81%8C%E8%AB%8B%E6%B1%82%E3%81%99%E3%82%8B%E3%81%AE%E3%81%AF%E3%81%AA%E3%81%9C%E3%81%A7%E3%81%99%E3%81%8B-)もご参照ください

### 長期利用割引

ご契約期間をお約束いただくことで、基本料金が割引になる仕組みをご検討ください

[長期利用割引 - 特定地域向け IoT SIM](https://soracom.jp/services/air/cellular/discount_price/)

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

![put-away](https://docs.google.com/drawings/d/e/2PACX-1vTptJ283N0Fq2wdr-cvGAljZDDZASVW3kxT1SYx-_JzZO81-Uelms8VUpTY_GHoYTqa9lpy89x4TFSb/pub?w=460&h=516)

* アンテナは取り外して Wio LTE 本体が格納されていた白いトレーのミゾに入れてください
* microUSB ケーブルは白いトレーを取り外した中に入れてください

## 【作業】SIM からグループを解除する

### 1-1. SORACOM ユーザーコンソールで 左上 [Menu] > [SIM 管理] をクリック

※ 画面が切り替わらない場合は、左上の SORACOM ロゴをクリックしてください。

![2020ui/go-subscribers](https://docs.google.com/drawings/d/e/2PACX-1vTBanBl1fCksfHzKv4oWGIFHMC1wqPht7FOVK41P1x5eDNVvR9p0wL7KknihZ_oWZrV-AlPsOQHm58P/pub?w=522&h=432)

### 1-2. Wio LTE に取り付けている SIM(sim-name1 を参照) を選択 > [操作] > [所属グループ変更] をクリック

![2020ui/go-change-group](https://docs.google.com/drawings/d/e/2PACX-1vT6I2WTkoE6_J2J4IBIrbAw4TSgcVcptmQWkE8KsUvc3bGZXdIfWnWLVN148gEvlyhN0XGr0yt0firC/pub?w=364&h=290)

### 4-3. [新しい所属グループ] > "グループ解除" を選択して、変更後のグループが "(なし)" になっていることを確認して [グループ変更] をクリック

![2020ui/unjoin-on-change-group-dialog](https://docs.google.com/drawings/d/e/2PACX-1vT6fskJ8TtXfaNtXwrNiZPNi0WDu44KoxLd6OzOmkantzXQex43Hp1HrXwrwCPr-ub5-5I7c19q3L6L/pub?w=629&h=318)

解除されると SIM 一覧で "グループ" が空欄となります

![sim-list-empty-group](https://docs.google.com/drawings/d/e/2PACX-1vSTSwapE1H6qSFTYj04Jzq5WDzsCHmfDUBxei1F0LD3xadH7yuV13L-TawmIbUdI6sNlzS_AH0coAiB/pub?w=554&h=100)

以上で終了です。

### 本コンテンツについて

本コンテンツの著作は株式会社ソラコムに帰属します。再利用についてはソラコムへお問合せください。
