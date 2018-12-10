# 2-1: クラウド連携 / SORACOM Funnel + AWS IoT Core 編

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

AWS IoT Core に送信したデータは、最初は `catch_all/` というトピック(メールボックスのようなものです)に送信します。トピックのデータ着信をトリガーに `post-to-slack-max_catch_all` という AWS Lambda 関数が起動します。  
この AWS Lambda 関数は `#max_catch_all` というテスト用に用意した Slack チャンネルに送られるようにプログラムされているので、 Wio LTE のデータは最終的に Slack に送信されるようになります。

また、後半では SORACOM Funnel の設定を変更して AWS IoT Core に送信するトピックを `filter/#` に変更します。AWS IoT Core 上でデータの判定を行ったうえで、AWS Lambda 関数の起動を決定するようにします。

<img src="https://docs.google.com/drawings/d/e/2PACX-1vR6wusGtYwMFtOCZ-MAUjBkU-WGYbqaQF8oDVhnMBfJpTytZlmzZSYDJVF4mEghzhApkxJ2sry5z5cI/pub?w=929&amp;h=520" alt="step4a Cloud / architecture">

## 最初に. Wio LTE の電源を OFF にする

**ここから作業になります**

Wio LTE の microUSB ケーブルを抜き、電源を OFF にしてください

※いきなり抜いてOKです。また、すでに OFF になっている場合は次に進んでください

## 1. SORACOM へ認証情報を保管する

### 1-1. [SORACOM Webコンソール](https://console.soracom.io/) で 左上[Menu] > [セキュリティ]

![soracom-menu](https://docs.google.com/drawings/d/e/2PACX-1vRhgmsjqpncv2HQ0jAZwiYf0knTfvmCMl6x_flrdeGQV4N60trp8M981gCAfitVSmXU4tqAYm6MmyRb/pub?w=331&h=410)
![soracom-menu-security](https://docs.google.com/drawings/d/e/2PACX-1vRjYW4eP-Cv1GTPmgGD01OEGiszvYmy1gmbsAQx50O6knq0UEPBozSQ8W3ezngFS6Z7B-8ArZkIXSWW/pub?w=344&h=334)

### 1-2. [認証情報ストア] > [認証情報を登録] で 認証情報入力画面を開きます

![soracom-cred-store](https://docs.google.com/drawings/d/e/2PACX-1vRoPNOwuGigBjl6MNfqQpXZL1MFmgPeUuwFLNF3TTRDZMQJf1G-HdwukH5otE7tdHy0YM9MWXmLac6z/pub?w=624&h=309)

### 1-3. 認証情報を登録する画面では下記の通り入力し、保存してください

* 認証情報ID: `awsiotcore-dataaccess`
* 概要: `AWS IoT Core DataAccess`
* 種別: *AWS 認証情報* (これを選択すると、下記IDを入力するテキストボックスが増えます)
* AWS Access Key ID: **ハンズオン運営から入手 (aws-accesskey-id)**
* AWS Secret Access Key ID: **ハンズオン運営から入手 (aws-secret-accesskey-id)**

![soracom-cred-save](https://docs.google.com/drawings/d/e/2PACX-1vR6S9T-9TZbcdB8XwcUrBE7MQCyIsT-zOA2LQGspbv5r72CxT_qc1pyIdgmIXqVU79qOEKfOzuA8vXZ/pub?w=644&h=642)

※ハンズオン運営から入手する情報は、本来ご自身でご用意いただくことになります。実際の準備方法は [AWS IoT Core の準備](#setup-awsiotcore) をご覧ください

## 2. SORACOM Funnel 設定

### 2-1. [SORACOM Webコンソール](https://console.soracom.io/) で 左上[Menu] > [SIM グループ]

[追加] で、SIMグループを作成します (グループ名は `funnel` もしくは任意でかまいません)

### 2-2. 先ほど作成した SIM グループ をクリックし、 SORACOM Funnel の設定を開きます

### 2-3. SORACOM Funnel の設定では、下記の通り入力し、保存してください

* 転送先サービス: *AWS IoT*
* 転送先URL: **ハンズオン運営から入手 (endpoint-url)**
* 認証情報: *awsiotcore-dataaccess (AWS IoT Core DataAccess)* (先ほど作成した認証情報を選ぶ)
* 送信データ形式: *JSON*

![soracom-funnel](https://docs.google.com/drawings/d/e/2PACX-1vQ1u87_1m7Mlk-t9G33ho7s8f_4-F8pIGjksjJxBFRhgYYVwJiBWAOVRr0_XWv5ehjU_4hqDvH7kXI_/pub?w=926&h=435)

### 2-4. 左上[Menu] > [SIM 管理]

* Wio LTE に取り付けている SIM を選択 > [操作] > [所属グループ変更]
* 先ほど作成した SIMグループ に所属させる

## 3. スケッチを作成する

### 3-1. Arduino IDE を起動する

### 3-2. メニューの [ツール] で [ボード: "Seeed Wio LTE Cat.1"] と表示されていることを確認する

なっていなければ一覧から "Seeed Wio LTE Cat.1" を選んでください

### 3-3. Arduino IDE の [ファイル] > [スケッチ例] > [Wio LTE for Arduino] > [soracom] > [soracom-harvest]

※上記の通り新規に始めてもかまいませんが、1-3 の続きから始めても構いません

### 3-4. スケッチの 8 行目の行頭 `//` を取り除きます (アンコメント)

8 行目が下記の通りになっていることを確認してください。なっていない場合は先頭の `//` を取り除いて、下記と同じようにしてください

```c++
#define SENSOR_PIN    (WIOLTE_D38)
```

### 3-5. スケッチの69行目の `harvest.soracom.io` と `8514` の2か所を `funnel.soracom.io` と `23080` へ変更します

変更前

```c++
  connectId = Wio.SocketOpen("harvest.soracom.io", 8514, WIOLTE_UDP);
```

変更後

```c++
  connectId = Wio.SocketOpen("funnel.soracom.io", 23080, WIOLTE_UDP);
```

### 3-6. Wio LTE と PC を接続して DFUモード にする

### 3-7. 新しく開いたウィンドウの ![マイコンボードに書き込むアイコン](https://docs.google.com/drawings/d/e/2PACX-1vQiO83cFcX3LCXeioiTiaao57T4SGiIV6XZzcBP6poTwssCxmo7hLpoMh5qG3btyqgzs8Q-lAoE6Q0f/pub?w=100&h=100)(マイコンボードに書き込む) をクリック

### 3-8. 書き込みが完了したら、Wio LTE を 通常モードにする (RSTボタンを押せば通常モードになります)

通常モードで起動次第 SORACOM Funnel へデータを送信し始めます (電源投入から送信開始までは15~20秒程度かかります)

※標準では送信間隔が60秒です。早めたい場合は [1-2 のやってみよう](../1/2-uptime.html#6-やってみよう送信間隔の変更)を参考に `INTERVAL` を `5000` などに変えてください

## 4. 確認

AWS IoT Core 上でのデータ着信は、運営側で行います。  
Wio LTE に挿した SIM の IMSI を運営に伝えてください。 IMSI は SORACOM Web コンソールで確認することができます。

## ※ うまく動かなかったら（トラブルシュート）

利用可能なツールは「シリアルモニター」「SORACOM Webコンソール上のSIMのログ」です。  
※運営側は CloudWatch や AWS IoT Core ダッシュボードも利用できます

**(シリアルモニターを見ると) 1回しかデータを送っていない**

* 原因: SORACOM Funnel へのホスト名やポート番号が違う
    * 対策: スケッチ69行目の SORACOM Funnel へのホスト名やポート番号を確認し、再度マイコンへ書き込んでください

**データは送られているが AWS IoT Core 上で確認できない**

* 原因: SORACOM Funnel が ON なグループに SIM が所属していない
    * 対策: SIM を SIM グループへ所属させるようにしてください

## 5.  送信先を変更し、クラウド上での条件付けを行う

### 5-1. 「4 確認」 まで終了していることを確認する

### 5-2. SORACOM Funnel 設定

#### 5-2-1. [SORACOM Web コンソール](https://console.soracom.io) で 左上[Menu] > [SIM グループ]

#### 5-2-2. 先ほど作成し設定した SORACOM Funnel のグループを開きます

#### 5-2-3. SORACOM Funnel の設定を下記の通りに入力（変更）し、保存してください

* 転送先 URL: **ハンズオン運営から入手 (filter-endpoint-url)**

### 5-3. 確認

AWS IoT Core 上でのデータ着信は、運営側で行います。
Wio LTE に挿した SIM の IMSI を運営に伝えてください。 IMSI は SORACOM Web コンソールで確認することができます。

**作業は以上で終了です。**

<h2 id="setup-awsiotcore">AWS IoT Core の準備</h2>

SORACOM Funnel から AWS IoT Core を利用するための準備は AWS IAM の設定で完了します。
AWS IoT Core 上で "モノ" や "ポリシー" の作成や設定は不要です。

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

AWS IoT Core のルールは以下のように設定されています。

監視対象のトピックに着信したメッセージが条件に一致した時に、アクションが実行されるようになっています。

* 監視対象: `filter/#` ( `#` はワイルドカード)
* 条件: `payloads.temp` が `30` を上回る時 (JSON のオブジェクト指定形式で宣言可能)
* アクション: `post-to-slack-max_filter` Lambda 関数を実行する

<img src="https://docs.google.com/drawings/d/e/2PACX-1vRq1AuLujKUW3BwUtRGBF8EorM0sS_oGm6prTB45rKUAAgf2c3hE5gHZI8eTb1g3PwjvQgSP9KINPWZ/pub?w=488&amp;h=329" alt="step4a Cloud / awsiotcore-rule">

### post-to-slack-max_filter Lambda 関数について

AWS Lambda 関数は [post-to-slack_on_aws-lambda.py](https://gist.github.com/ma2shita/a10e062bc1b30a80bf2ee0db2fe79873) で公開しています。

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
