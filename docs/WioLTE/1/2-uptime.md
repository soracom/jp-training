# 1-2: デバイス稼働時間を SORACOM Harvest で可視化

Wio LTE の稼働時間を SORACOM Harvest で可視化してみましょう

※Wio LTE 単体の構成でモバイル通信の活用を学びます

![ステップ2 ovewview](https://docs.google.com/drawings/d/e/2PACX-1vQYbHwh3ec7Bfl7o8Hj3a6FvmnHJWfbeahOi0wsUn_BzhhC_-mX-sHmEV85-vFEdd5m6HQRAvh_lyrW/pub?w=371&h=247)

## 最初に. Wio LTE の電源を OFF にする

Wio LTE の microUSB ケーブルを抜き、電源を OFF にしてください

※いきなり抜いてOKです。また、すでに OFF になっている場合は次に進んでください

## 1. Wio LTE にアンテナを取り付ける

**※Wio LTE から microUSB ケーブルを抜いた状態にしてください**

Wio LTE に 添付されているアンテナ2本を取り付けます (**※アンテナは必ず2本取り付けてください**)

![Wio LTE にアンテナを取り付けたところ](https://docs.google.com/drawings/d/e/2PACX-1vQeeuUwMU4t2mjArmyPGsciGmXCYxl8gXPt_gTFiCh-iMOnv-c0s22otGPmvG7-PsMDX34Pe0d3afqC/pub?w=640&h=480)

## 2. Wio LTE に SIM を取り付ける

Wio LTE に SIM (nanoサイズ) を取り付けます

<img src="https://docs.google.com/drawings/d/e/2PACX-1vQ_jUPQyYsHnk0v5yFZpdbJ6n7l2U6Pf1SexxpQ1DyvrxYVbiDTmfT2GjyUmZpR7Dc2dtZneXpkFqZz/pub?w=550&amp;h=255">

<img src="https://docs.google.com/drawings/d/e/2PACX-1vT_Z9NNb95SOxW0O0V65dH5icGjbBpvTH5TWyhGYR8LdxmVg0II1eRuJA33zOBlPy4ntbptjJTYVKra/pub?w=473&amp;h=351" alt="wio-lte-handson / sim-ok">

### SIM の失敗例

以下のように、SIM 取り付けの「窓」に SIM が見えている場合は **取り付けに失敗** しています。引き抜いてから再度取り付けてください。

また、奥まで入れてしまった場合は、ピンのようなもので少しずつ押し出すか、ハンズオンの場合はスタッフをお呼びください。

<img src="https://docs.google.com/drawings/d/e/2PACX-1vQOQL4VS42nf7pb8EOwekrJ_gTEmNMeRPIQA42QmD_hjtdrb3ATMlG5np2HN9gwLOnrbVHnZkZ8l8-v/pub?w=412&amp;h=313" alt="wio-lte-handson / sim-ng">

### SIM の取り出し

SIM の取り出し方も一緒に紹介いたします

<img src="https://docs.google.com/drawings/d/e/2PACX-1vSHV26TeW7Z3rEbr-OOVQ-6GyI8GijLNChn5ayEspNVPZqmbZTj3pkDdBCZhLEetrMqLdDuXm-GpQk9/pub?w=683&amp;h=322">

<img src="https://docs.google.com/drawings/d/e/2PACX-1vRn4PgJFdW-IV-Fr4JTq7dj6wz4KBSyG3pM6W4Wxdbtt-FunzEy4aSK1_QpssqfoATEWfP_9IJL8vtV/pub?w=508&amp;h=370">

**抜く際フックを引っ張りすぎると金具が取れてしまうため、図示されている程度まで引っ張り出したらSIMを取り出し、金具を元に戻してください**

## 3. SORACOM Harvest の設定をする

**※ SORACOM のアカウントをお持ちでない方:** [SORACOM アカウントの作成](https://dev.soracom.io/jp/start/console/#account) の手順に沿って作成してください   
（有効なクレジットカード(1枚) と この場で確認可能なメールアドレス(1つ)が必要です）

**※ SORACOM アカウントを持っているが SIM を登録していない場合:** [Air SIM の登録](https://dev.soracom.io/jp/start/console/#registsim) の手順に沿って登録してください

### 3-1. [SORACOM Webコンソール](https://console.soracom.io/) で 左上[Menu] > [SIM グループ]

![soracom-menu](https://docs.google.com/drawings/d/e/2PACX-1vRhgmsjqpncv2HQ0jAZwiYf0knTfvmCMl6x_flrdeGQV4N60trp8M981gCAfitVSmXU4tqAYm6MmyRb/pub?w=331&h=410)
![soracom-menu-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vTqI-f2K8n-TuUvVEGPnmDcFxG2f87so3Qfe5K11sn0pXG8Q4v2lJX0UT9tjlH7sDQRb1FC7aFfckjb/pub?w=353&h=290)

### 3-2. [追加] で、SIMグループを作成します (グループ名は進捗表の **sim-group-name1** を利用してください)

![soracom-menu-sim-group-create](https://docs.google.com/drawings/d/e/2PACX-1vQ-wJ7Ixk-BQDtxXweBkhl-deBJzh3behOo_rQNNxm3gO73sKHEV_RvqO7cWrSKJT0AZltPaF_K0qPf/pub?w=381&h=315)

![soracom-menu-sim-group-create-dialog](https://docs.google.com/drawings/d/e/2PACX-1vRjDUj0AzCWEBNyy9GTqWf6jPANTk4WIEZcarMaYd9GhbM-_2AhBru9WglGRplqo0jUroC9rIq82G8h/pub?w=631&h=306)

### 3-3. 先ほど作成した SIMグループ をクリックし、 SORACOM Harvest の設定を ON にして保存をクリック

![soracom-menu-sim-group-list](https://docs.google.com/drawings/d/e/2PACX-1vTpWazZ3_xwnViyK1XJXVo3Aa8BeqhLsdeE4v1SHsUNUhKQw-mS15ZovR4kEzNfhJZw2PYdGEcLB9Fr/pub?w=316&h=334)

![soracom-harvest-on](https://docs.google.com/drawings/d/e/2PACX-1vRjSkL7huwCXXSSknkDnuVbPqYSo9a-rJ0PInLFa-mmgBx1fhhHdVu339RbtSuAuhY2bcFlyMxsGWs1/pub?w=504&h=685)

### 3-4. [SORACOM Webコンソール](https://console.soracom.io/) で 左上[Menu] > [SIM 管理]

![soracom-menu](https://docs.google.com/drawings/d/e/2PACX-1vRhgmsjqpncv2HQ0jAZwiYf0knTfvmCMl6x_flrdeGQV4N60trp8M981gCAfitVSmXU4tqAYm6MmyRb/pub?w=331&h=410)
![soracom-sim-mgr](https://docs.google.com/drawings/d/e/2PACX-1vTUi6LN6Hsctv4KdaZj8uOUFg_ZyROx73f1TzFq41KIlRzjUmE_bc2NR5UnS8cn15TD_S2s8FA-DHzA/pub?w=353&h=290)

### 3-5. Wio LTE に取り付けている SIM を選択 > [操作] > [所属グループ変更]

![soracom-select-sim](https://docs.google.com/drawings/d/e/2PACX-1vQpULGXvkk5htY266aDd2iWJueVphdm8DFRVy_BF5JnWnZfBBLF19U42ni5lU6VxN5ucmwqKHx4ACjg/pub?w=526&h=489)

### 3-6. 先ほど作成した SIMグループ に所属させる

![sim-group-select](https://docs.google.com/drawings/d/e/2PACX-1vR1DJQnKw0NVvv83qxiTiDkh0AYfF6u8g3En7EDQtt2M2OjCRzl_tmlB-02cyiLBHLwWHjpOshFKTAA/pub?w=643&h=334)

以上で SORACOM Web コンソール上での作業は終了です

下記のように Wio LTE に取り付けている SIM の "グループ" が、先ほど作った SIM グループ名になっていれば成功です

![sim-list](https://docs.google.com/drawings/d/e/2PACX-1vSjr7j-ld8piy6POBYX1r8Ib2nW1DLjwanI1bqDXS0VsWh6SFK8RXvfDop5X0hzg2Auq2aSvdH8eDPm/pub?w=520&h=464)

## 4. スケッチを作成する

### 4-1. Arduino IDE を起動する

### 4-2. メニューの [ツール] で [ボード: "Seeed Wio LTE Cat.1"] と表示されていることを確認する

なっていなければ一覧から "Seeed Wio LTE Cat.1" を選んでください

### 4-3. Arduino IDE の [ファイル] > [スケッチ例] > [Wio LTE for Arduino] > [soracom] > [soracom-unified]

新しいウィンドウが開きます

※スケッチ例に `soracom-unified` が表示されない場合は、ライブラリを最新にする必要があります。Arduino IDE のライブラリマネージャーからインストール済みのライブラリの更新を行ってください。

### 4-4. Wio LTE と PC を接続して DFUモード にする

### 4-5. 新しく開いたウィンドウの ![マイコンボードに書き込むアイコン](https://docs.google.com/drawings/d/e/2PACX-1vQiO83cFcX3LCXeioiTiaao57T4SGiIV6XZzcBP6poTwssCxmo7hLpoMh5qG3btyqgzs8Q-lAoE6Q0f/pub?w=100&h=100)(マイコンボードに書き込む) をクリック

### 4-6. 書き込みが完了したら、Wio LTE を 通常モードにする (RSTボタンを押せば通常モードになります)

通常モードで起動次第 SORACOM Harvest へデータを送信し始めます (電源投入から送信開始までは20~25秒程度かかります)

## 5. 確認

### 5-1. [SORACOM Webコンソール](https://console.soracom.io/) で 左上[Menu] > [SIM 管理]

![soracom-menu](https://docs.google.com/drawings/d/e/2PACX-1vRhgmsjqpncv2HQ0jAZwiYf0knTfvmCMl6x_flrdeGQV4N60trp8M981gCAfitVSmXU4tqAYm6MmyRb/pub?w=331&h=410)
![soracom-sim-mgr](https://docs.google.com/drawings/d/e/2PACX-1vTUi6LN6Hsctv4KdaZj8uOUFg_ZyROx73f1TzFq41KIlRzjUmE_bc2NR5UnS8cn15TD_S2s8FA-DHzA/pub?w=353&h=290)

### 5-2. Wio LTE に取り付けている SIM を SORACOM Webコンソール上で選択し [操作] > [データを確認]

![harvest-view](https://docs.google.com/drawings/d/e/2PACX-1vRGN09AF9n0GafAg8Ut9s8QYAmEd4h5Oj4fTYUQjqKEFXCj_aIRjyS3u5zpim0eqtnnh-csIl6sAHaU/pub?w=526&h=489)

下図のように SORACOM Harvest 上で稼働時間が表示されるようになります  
※自動更新を ON にすると、画面の再描画が自動的に行われます  
※グラフ種類を折れ線グラフや棒グラフに変更することができます

![SORACOM Harvest で表示している様子](https://dev.soracom.io/img/gs_wio-lte/soracom-harvest-rendering.png)

<h2 id="try">6. やってみよう(送信間隔の変更)</h2>

スケッチを編集して稼働時間の送信間隔を変えてみましょう

スケッチ4行目の `INTERVAL` が周期を指定しています。ミリ秒(ms)単位になっており、 60000 (= 60秒) から変更し、マイコンボードに書き込んでみましょう

```
#define INTERVAL  (60000)
```

↓

```
#define INTERVAL  (5000)
```

## 7. Wio LTE の動作を止める

止める方法は Wio LTE の電源を OFF (= microUSBケーブルを抜く) してください

## 以上で本章は終了です

達成状況を運営表へご記入ください。

* [1-3.温湿度センサーのデータを SORACOM Harvest で可視化](3-sensor) に進んで下さい
* [目次ページへ戻る](../index)

## うまく動かなかったら（トラブルシュート）

データが表示されない場合は、下記を確認してください

* Wio LTE へアンテナが正しく取り付けられているか？
* SIM が正しく挿入されているか？
* SIM が SORACOM に登録されているか？
* SORACOM Harvest が ON になっている SIM グループに SIM が所属しているか？

以上を確認しても、まだ尚データ送信されない場合は RST ボタンを押して Wio LTE の再起動を行ってみてください

また、Arduino IDE のシリアルモニターで接続やデータ送信状況が確認できます

※注意: Windows の Arduino IDE のシリアルモニタは、 Wio LTE 開発においては動作が不安定になることがあるため、Windows の方は TeraTerm を使用してください
