<h1 id="funnel-awsiotcore">【作業】ステップ 2-1: クラウド連携 / SORACOM Funnel + AWS IoT Core 編</h1>

本格的なデータ収集 IoT システムの構築としてクラウド連携を学びます。  
ここでは AWS IoT Core を活用した構成です。

## クラウドを学ぶ

### AWS IoT Core とは

IoT デバイス向けのメッセージ処理基盤です。  
フルマネージド・サービスであり、構築や運用の手間は AWS がすべて行ってくれます。

1 台のデバイスから利用することができ、また、万を超えるデバイスからのメッセージを受け付けることができます。課金も完全従量制になっています。  
またルールに応じて AWS の各サービスに接続できます。

### AWS Lambda とは

Python や Node.js で書かれたプログラムコードを保存しておくと、特定の条件(トリガー)でプログラムを実行してくれる仕組みです。  
例えば Amazon S3 にオブジェクトが作られた時や、 CloudWatch のイベントに連動させることが可能であり、 AWS IoT Core にも対応しています。  
フルマネージド・サービスであり、プログラムを実行するための環境構築や運用の手間は AWS がすべて行ってくれます。

### 本稿の構成

今回は Wio LTE からのデータを 「クラウド・アダプタ サービス」 SORACOM Funnel で中継し、AWS IoT Core に送ります。

AWS IoT Core に送信したデータは、最初は `catch_all/` というトピック(メールボックスのようなものです)に送信します。トピックのデータ着信をトリガーに `awsiotcore-post_to_slack-max_catch_all` という AWS Lambda 関数が起動します。  
この AWS Lambda 関数は `#max_catch_all` というテスト用に用意した Slack チャンネルに送られるようにプログラムされているので、 Wio LTE のデータは最終的に Slack に送信されるようになります。

また、後半では SORACOM Funnel の設定を変更して AWS IoT Core に送信するトピックを `filter/#` に変更します。AWS IoT Core 上でデータの判定を行ったうえで、条件に一致した時のみ AWS Lambda 関数 `awsiotcore-post_to_slack-max_filter` の起動するようにしています。

<img src="https://docs.google.com/drawings/d/e/2PACX-1vS1zLBGoASVzgjQjc2jlX-K0DKBfAuJZ-AMnqpYhGPZPkYkEox6MwX1v5Aze1qdU3hQSkqln8Gd45G3/pub?w=1121&h=623" alt="step4a Cloud / architecture1">

## 最初に. Wio LTE の電源を OFF にする

**ここから作業になります**

Wio LTE の microUSB ケーブルを抜き、電源を OFF にしてください

※いきなり抜いてOKです。また、すでに OFF になっている場合は次に進んでください

## 1. SORACOM へ認証情報を保管する

### 1-1. [SORACOM ユーザーコンソール](https://console.soracom.io/) で [右上のユーザー名] > [セキュリティ] をクリック

![soracom-menu-security](https://docs.google.com/drawings/d/e/2PACX-1vRjYW4eP-Cv1GTPmgGD01OEGiszvYmy1gmbsAQx50O6knq0UEPBozSQ8W3ezngFS6Z7B-8ArZkIXSWW/pub?w=344&h=334)

### 1-2. [認証情報ストア] > [認証情報を登録] をクリック

![soracom-cred-store](https://docs.google.com/drawings/d/e/2PACX-1vRoPNOwuGigBjl6MNfqQpXZL1MFmgPeUuwFLNF3TTRDZMQJf1G-HdwukH5otE7tdHy0YM9MWXmLac6z/pub?w=624&h=309)

### 1-3. 認証情報を登録する画面では下記の通り入力して [保存] をクリック

* 認証情報 ID: **進捗表から入手 (cred-name1)**
* 概要: `AWS IoT Core DataAccess`
* 種別: *AWS 認証情報* (これを選択すると、下記を入力するテキストボックスが増えます)
* AWS Access Key ID: **進捗表から入手 (aws-accesskey-id)**
* AWS Secret Access Key ID: **進捗表から入手 (aws-secret-accesskey-id)**

![soracom-cred-save](https://docs.google.com/drawings/d/e/2PACX-1vR6S9T-9TZbcdB8XwcUrBE7MQCyIsT-zOA2LQGspbv5r72CxT_qc1pyIdgmIXqVU79qOEKfOzuA8vXZ/pub?w=644&h=642)

※進捗表から入手する情報は、本来ご自身でご用意いただくことになります。実際の準備方法は [AWS IoT Core の準備](#setup-awsiotcore) をご覧ください

## 2. SORACOM Funnel の設定をする

### 2-1. SORACOM ユーザーコンソールで 左上 [Menu] > [SIM 管理] をクリック

※ 画面が切り替わらない場合は、左上の SORACOM ロゴをクリックしてください。

![2020ui/go-subscribers](https://docs.google.com/drawings/d/e/2PACX-1vTBanBl1fCksfHzKv4oWGIFHMC1wqPht7FOVK41P1x5eDNVvR9p0wL7KknihZ_oWZrV-AlPsOQHm58P/pub?w=522&h=432)

### 2-2. SIM 管理画面で、先ほど作成した SIM グループ名をクリック

![2020ui/go-sim-group-config](https://docs.google.com/drawings/d/e/2PACX-1vTxef9ZRuhhjbTDPhrTsRYKq2q-ezDbYpjTJ0uOPkplUNlKF7q5yP575l2l7Jfe0NPddkG5mIENyZFn/pub?w=498&h=100)

### 2-3. SIM グループ設定画面で [SORACOM Funnel 設定] をクリック

![2020ui/open-soracom-funnel-config](https://docs.google.com/drawings/d/e/2PACX-1vT7cDXI5n7eIJyDq3_5dCfxN7qL1PpucaxmG3yBFh-8oTz1JW-1panuahINkmfbj7_tD0JH8J2oYbIA/pub?w=773&h=375)

### 2-4. SORACOM Funnel の設定でスイッチを "ON" にしてから下記の通り入力して [保存] をクリック

* 転送先サービス: *AWS IoT* (これを選択すると、下記を入力するテキストボックスが増えます)
* 転送先URL: **進捗表から入手 (endpoint-url)**
* 認証情報: (先ほど作成した認証情報 進捗表の **cred-name1** を選ぶ)
* 送信データ形式: *JSON*

![soracom-funnel](https://docs.google.com/drawings/d/e/2PACX-1vQ1u87_1m7Mlk-t9G33ho7s8f_4-F8pIGjksjJxBFRhgYYVwJiBWAOVRr0_XWv5ehjU_4hqDvH7kXI_/pub?w=926&h=435)

以上で SORACOM ユーザーコンソール上での作業は終了です。

## 3. スケッチの確認と Wio LTE の電源を ON にして通常モードで動かす

Wio LTE に電源を入れ、動かしてください。

この時、Wio LTE には [1-3](../1/3-sensor#sketch) で作成されたスケッチが書き込まれている必要があります。そうでなければ [1-3](../1/3-sensor#sketch) を参考に、スケッチを再度書き込んでください。

## 4. 確認

AWS IoT Core 上でのデータ着信は、運営側で行います。受講者番号を運営にお伝えください。

※ 標準では送信間隔が60秒です。早めたい場合は [1-2 のやってみよう](../1/2-uptime#try)を参考に、 `INTERVAL` を例えば `5000` (= 5秒) に変更して、Wio LTE に書込んでみてください。

※ 運営の方へ: [データ着信の確認方法](#dashboard) に沿って確認してください。

## ※ うまく動かなかったら（トラブルシュート）

まず SORACOM Harvest を確認してみてください。  
**SORACOM Harvest にデータが表示されている**: データ送信自体は成功しています。 SORACOM Funnel の設定不備の可能性があるため、以下のトラブルシュートを確認してください。  
**SORACOM Harvest でデータが確認できない**: Wio LTE の接続を確認してください。

また、 SORACOM Harvest 以外にトラブルシュートで利用可能なツールは「Arduino IDE のシリアルモニター」「SORACOM ユーザーコンソール上の SIM のログ」です。

**データは送られているが AWS IoT Core 上で確認できない**

* 原因: SORACOM Funnel が ON なグループに SIM が所属していない
* 対策: SIM を SIM グループへ所属させるようにしてください

## 5.  送信先を変更し、クラウド上での条件付けを行う

温度が 28℃ を超えたら Slack にデータが送信されるようにしてみます。

### 5-1. 「4 確認」 まで終了していることを確認する

### 5-2. SORACOM Funnel 設定

#### 5-2-1. 先ほど設定した SORACOM Funnel のグループを開きます

#### 5-2-2. SORACOM Funnel の設定を下記の通りに入力（変更）し、保存してください

* 転送先 URL: **進捗表から入手 (filter-endpoint-url)**

### 5-3. 確認

温湿度センサーに息を吹きかける等で温度が 28℃を超えるようにしてください。

AWS IoT Core 上でのデータ着信は、運営側で行います。受講者番号を運営にお伝えください。

## 以上で本章は終了です

達成状況を運営表へご記入ください。

* [3-1.IoTデバイス 双方向通信 / SORACOM Beam + MQTT Pub/Sub 編](../3/1-beam-mqtt) に進んで下さい
* [目次ページへ戻る](../index)

<h2 id="setup-awsiotcore">AWS IoT Core の準備</h2>

ここからは本日使用した AWS IoT Core の環境を自分で作りたい場合の手順です。

### SORACOM Funnel を利用する際の AWS IoT Core の設定

SORACOM Funnel から AWS IoT Core を利用するための準備は AWS IAM の設定 (専用の仮想ユーザーの作成) で完了します。  
AWS IoT Core 上でモノやポリシーの他、X.509 証明書 の作成/設定は不要です。

### AWS セットアップ内容

* IAM
    * IAM で専用ユーザ作成 (e.g. `awsiot-dataaccess-for-handson`)
    * *awsiot-dataaccess-for-handson* の Access Key ID 発行
    * *awsiot-dataaccess-for-handson* へ *AWSIoTDataAccess* ポリシー割り当て

上記の設定を aws-cli で行う場合の手順

```bash
## 環境構築
$ aws iam create-user --user-name awsiotcore-dataaccess-for-funnel-handson
$ aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AWSIoTDataAccess --user-name awsiotcore-dataaccess-for-funnel-handson
$ aws iam create-access-key --user-name awsiotcore-dataaccess-for-funnel-handson

## 環境終了
$ aws iam list-access-keys --user-name awsiotcore-dataaccess-for-funnel-handson
$ aws iam delete-access-key --user-name awsiotcore-dataaccess-for-funnel-handson --access-key-id $OLD_ACCESS_KEY_ID
$ aws iam detach-user-policy --policy-arn arn:aws:iam::aws:policy/AWSIoTDataAccess --user-name awsiotcore-dataaccess-for-funnel-handson
$ aws iam delete-user --user-name awsiotcore-dataaccess-for-funnel-handson
```

### AWS IoT Core 上のルールについて

AWS IoT Core のルールは 2 つ設定されています。

１つ目は監視対象のトピックに着信したメッセージは全て指定されたアクション (Lambda 関数の実行) をするようにしています。

* 監視対象: `catch_all/#` ( `#` はワイルドカード)
* 条件: (なし = 全てのデータでアクションを実行)
* アクション: `awsiotcore-post_to_slack-max_catch_all` Lambda 関数を実行する

２つめは監視対象のトピックに着信したメッセージが条件に一致した時に、アクションが実行されるようになっています。

* 監視対象: `filter/#` ( `#` はワイルドカード)
* 条件: `payloads.temp` が `28` を上回る時 (JSON のオブジェクト指定形式で宣言可能)
* アクション: `awsiotcore-post_to_slack-max_filter` Lambda 関数を実行する

<img src="https://docs.google.com/drawings/d/e/2PACX-1vRq1AuLujKUW3BwUtRGBF8EorM0sS_oGm6prTB45rKUAAgf2c3hE5gHZI8eTb1g3PwjvQgSP9KINPWZ/pub?w=488&amp;h=329" alt="step4a Cloud / awsiotcore-rule">

### awsiotcore-post_to_slack-max_* Lambda 関数について

基になる Lambda 関数は [post_to_slack_on_aws-lambda.py](https://gist.github.com/ma2shita/a10e062bc1b30a80bf2ee0db2fe79873) で公開しています。  
この関数一つで `SLACK_CHANNEL` に基づき Slack チャンネルに送信できるようになっています。

重要な部分は以下の通りです。この Lambda 関数は AWS IoT Core のルールから、メッセージが着信した毎に実行されます。

```python
def lambda_handler(event, context):
    slack_message = {
        'channel': SLACK_CHANNEL,
        'text': str(event['payloads'])
    }
    req = Request(HOOK_URL, json.dumps(slack_message))
```

* `event` に AWS IoT Core (= SORACOM Funnel) から渡されたデータが入った状態で実行されます
* `Request` を利用して `HOOK_URL` へ HTTP POST します
* `SLACK_CHANNEL` で指定された Slack チャンネルに送信します

<h2 id="unified-endpoint">Unified Endpoint について</h2>

本ハンズオンでは Unified Endpoint という機能を使い、 SORACOM Harvest と SORACOM Funnel へ **同時に** データを送信しています。使い方としては `unified.soracom.io` にデータを送信するだけで、SORACOM Beam/Funnel/Harvest へのデータ送信が制御できるようになります。

従来は SORACOM Harvest への送信は `harvest.soracom.io` 、そして SORACOM Funnel への送信は `funnel.soracom.io` と、デバイス上での送信先切り替えが必要でしたが、Unified Endpoint により SORACOM プラットフォーム上で変更できるようになりました。

詳細は[ブログ](https://blog.soracom.jp/blog/2019/02/14/unified-endpoint/)をご覧ください。
