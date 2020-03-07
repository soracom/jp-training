<h1 id="uptime">【作業】1-2: デバイス稼働時間を SORACOM Harvest で可視化</h1>

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

## 3. SORACOM IoT SIM を SORACOM ユーザーコンソールに登録する

**※ SORACOM のアカウントをお持ちでない方:** [SORACOM アカウントの作成](https://dev.soracom.io/jp/start/console/#account) の手順に沿って作成してください   
（有効なクレジットカード(1枚) と この場で確認可能なメールアドレス(1つ)が必要です）

**※ すでに SIM が登録済みの方:** 利用する SIM(sim-name1 を参照)が登録されているかを確認してください    
登録されている場合は、 "4 SORACOM Harvest の設定をする" に進んでください   
登録されていない場合は、運営にお声がけください  

### 3-1. [SORACOM ユーザーコンソール](https://console.soracom.io/){:target="_blank"} にログインする

### 3-2. [SIM 登録] をクリック

![sim-register-button](https://docs.google.com/drawings/d/e/2PACX-1vQlsXN8RA0XyZ_DlohtCiA8_6_j1IJANSe_Tx_loU_EaBn9CjC6YBcVtnpLf92F1x0BsMQijvFskOtf/pub?w=434&h=408)

※ [SIM 登録] が表示されていない場合は、[Menu] > [SIM 管理] をクリックしてください。

### 3-3. SIM 登録に必要な情報を入力する画面では下記の通り入力し [登録] をクリック

* IMSI: SIM カード裏面の **IMSI** と記載されている右側 15 桁の番号です
* パスコード: SIM カード裏面の **PASSCODE** と記載されている右側 5 桁の番号です。
* 名前: **進捗表から入手 (sim-name1)**
* グループ: <何も設定しないでください>
* 技術基準適合証明等について確認しました: **チェックを付ける**

![sim-register-form](https://docs.google.com/drawings/d/e/2PACX-1vRefT1skPGVPhIUBM4BDSU5CAsh_JT3QtltfozlUO6wNj2YMmkhCA5BhHlzLxk9p-e-2f-XrbVRkwXi/pub?w=559&h=775)

※ SIM カードの裏面のサンプル

![sim-card](https://docs.google.com/drawings/d/e/2PACX-1vSB1d6f9SFu0AALOl32ry0lLpb9bO3tJfmWoiS_QPsJ0Dbjc6V9VfE-fOiPkKXuUkI4hcXlirTvn6Zw/pub?w=451&h=287)

登録に成功すると「SIM の登録が成功しました」というダイアログが出るので [終了して元の画面に戻る] をクリックします。

![sim-register-success](https://docs.google.com/drawings/d/e/2PACX-1vT8s2Laen43TSrPAv_NO1ErPLEh1Gl-MSedFi74AVn65PJufdXNqpcWwZKRzyElizMVbQLe__iC3st-/pub?w=641&h=245)

## 4. SORACOM Harvest の設定をする

### 4-1. SORACOM ユーザーコンソールで 左上 [Menu] > [SIM 管理] をクリック

※ 画面が切り替わらない場合は、左上の SORACOM ロゴをクリックしてください。

![2020ui/go-subscribers](https://docs.google.com/drawings/d/e/2PACX-1vTBanBl1fCksfHzKv4oWGIFHMC1wqPht7FOVK41P1x5eDNVvR9p0wL7KknihZ_oWZrV-AlPsOQHm58P/pub?w=522&h=432)

### 4-2. Wio LTE に取り付けている SIM(sim-name1 を参照) を選択 > [操作] > [所属グループ変更] をクリック

![2020ui/go-change-group](https://docs.google.com/drawings/d/e/2PACX-1vT6I2WTkoE6_J2J4IBIrbAw4TSgcVcptmQWkE8KsUvc3bGZXdIfWnWLVN148gEvlyhN0XGr0yt0firC/pub?w=364&h=290)

### 4-3. [新しい所属グループ] > [新しいグループを作成...] をクリック

![2020ui/new-group-on-change-group-dialog](https://docs.google.com/drawings/d/e/2PACX-1vS8QdSqoUUN2M5xy4uYEmvCycgFD4WjP73iD6BHzWn_FQ6ebbbk-nKef_9NdQdU3ifLPdZSRwYc7bjr/pub?w=442&h=358)

#### 4-4. グループ名を入力して [グループ作成] をクリック

* グループ名: **進捗表から入手 (sim-group-name1)**

![2020ui/set-new-group-name/sim-group-name1](https://docs.google.com/drawings/d/e/2PACX-1vQUpB8qLOk5kfqzl9xkCO0c-LLZdxTe6EN88TO6WTy5lMWsDPSZIqfWLSUA4La4JTs7Lijzk2rM9I46/pub?w=475&h=272)

#### 4-5. 変更後のグループが先ほど作成した **sim-group-name1** になっていることを確認して [グループ変更] をクリック

![2020ui/do-change-group](https://docs.google.com/drawings/d/e/2PACX-1vSqolUxOD7iC3ztSxtOUcw4V6fYz61hFBPCSZ2IOCot0VdwvTI6owqWQ_qEP4WrnJk1sg0AbIix5Poo/pub?w=776&h=393)

ここまでの作業の結果、SIM に SIM グループが設定されます。

![2020ui/check-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vQYm7QZVFjbgohMSLaSg9Jn9vVvzAi2-8NZz0T1e4umQ048ZISEi5IPipvwoeFOCo-maJSjafKRgHLi/pub?w=498&h=100
)

### 4-6. SIM 管理画面で、先ほど作成した "SIM グループ名" をクリック

![2020ui/go-sim-group-config](https://docs.google.com/drawings/d/e/2PACX-1vTxef9ZRuhhjbTDPhrTsRYKq2q-ezDbYpjTJ0uOPkplUNlKF7q5yP575l2l7Jfe0NPddkG5mIENyZFn/pub?w=498&h=100)

### 4-7. SIM グループ設定画面で [SORACOM Harvest 設定] > スイッチを "ON" にして [保存] をクリック

![2020ui/soracom-harvest-on](https://docs.google.com/drawings/d/e/2PACX-1vRjSkL7huwCXXSSknkDnuVbPqYSo9a-rJ0PInLFa-mmgBx1fhhHdVu339RbtSuAuhY2bcFlyMxsGWs1/pub?w=504&h=685)

以上で SORACOM ユーザーコンソール上での作業は終了です。

## 5. スケッチを作成する

### 5-1. Arduino IDE を起動する

### 5-2. メニューの [ツール] で [ボード: "Seeed Wio LTE Cat.1"] と表示されていることを確認する

なっていなければ一覧から "Seeed Wio LTE Cat.1" を選んでください

### 5-3. Arduino IDE の [ファイル] > [スケッチ例] > [Wio LTE for Arduino] > [soracom] > [soracom-unified]

新しいウィンドウが開きます

※スケッチ例に `soracom-unified` が表示されない場合は、ライブラリを最新にする必要があります。Arduino IDE のライブラリマネージャーからインストール済みのライブラリの更新を行ってください。

### 5-4. Wio LTE と PC を接続して DFUモード にする

### 5-5. 新しく開いたウィンドウの ![マイコンボードに書き込むアイコン](https://docs.google.com/drawings/d/e/2PACX-1vQiO83cFcX3LCXeioiTiaao57T4SGiIV6XZzcBP6poTwssCxmo7hLpoMh5qG3btyqgzs8Q-lAoE6Q0f/pub?w=100&h=100)(マイコンボードに書き込む) をクリック

### 5-6. 書き込みが完了したら、Wio LTE を 通常モードにする (RSTボタンを押せば通常モードになります)

通常モードで起動次第 SORACOM Harvest へデータを送信し始めます (電源投入から送信開始までは20~25秒程度かかります)

## 6. 確認

### 6-1. SORACOM ユーザーコンソールで 左上 [Menu] > [SIM 管理] をクリック

※ 画面が切り替わらない場合は、左上の SORACOM ロゴをクリックしてください。

![2020ui/go-subscribers](https://docs.google.com/drawings/d/e/2PACX-1vTBanBl1fCksfHzKv4oWGIFHMC1wqPht7FOVK41P1x5eDNVvR9p0wL7KknihZ_oWZrV-AlPsOQHm58P/pub?w=522&h=432)

### 6-2. Wio LTE に取り付けている SIM を SORACOM ユーザーコンソール上で選択し [操作] > [データを確認] をクリック

![go-data-viewing](https://docs.google.com/drawings/d/e/2PACX-1vShkLChMsTxM5Mx9n2BLL5yQ7fgNIF-LP_dtUJgoFNtm-TZF-LCEJ8XfYDPgHQwAEGOEt6XUECiPLQD/pub?w=359&h=354)

下図のように SORACOM Harvest 上で稼働時間が表示されるようになります  
※自動更新を ON にすると、画面の再描画が自動的に行われます  
※グラフ種類を折れ線グラフや棒グラフに変更することができます

![SORACOM Harvest で表示している様子](https://dev.soracom.io/img/gs_wio-lte/soracom-harvest-rendering.png)

<h2 id="try">7. やってみよう(送信間隔の変更)</h2>

スケッチを編集して稼働時間の送信間隔を変えてみましょう

スケッチ4行目の `INTERVAL` が周期を指定しています。ミリ秒(ms)単位になっており、 60000 (= 60秒) から変更し、マイコンボードに書き込んでみましょう

```
#define INTERVAL  (60000)
```

↓

```
#define INTERVAL  (5000)
```

## 8. Wio LTE の動作を止める

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
