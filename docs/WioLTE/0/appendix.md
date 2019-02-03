# Appendix(付録): ハンズオンで使用した環境の構築方法

<h2 id="aws-iot-core">AWS IoT Core</h2>

* IAM
    * IAM で専用ユーザ作成 (e.g. `awsiot-dataaccess-for-funnel-handson`)
    * *awsiot-dataaccess-for-funnel-handson* へ *AWSIoTDataAccess* ポリシー割り当て
    * *awsiot-dataaccess-for-funnel-handson* の Access Key ID 発行

※ "モノ" や "AWS IoT Core 上のポリシー" の作成や設定は不要です

### 上記を aws-cli で行う方法

作成;

```
aws iam create-user --user-name awsiot-dataaccess-for-funnel-handson
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AWSIoTDataAccess --user-name awsiot-dataaccess-for-funnel-handson
aws iam create-access-key --user-name awsiot-dataaccess-for-funnel-handson
```

削除;

```
aws iam list-access-keys --user-name awsiot-dataaccess-for-funnel-handson
aws iam delete-access-key --user-name awsiot-dataaccess-for-funnel-handson --access-key-id $OLD_ACCESS_KEY_ID
aws iam detach-user-policy --policy-arn arn:aws:iam::aws:policy/AWSIoTDataAccess --user-name awsiot-dataaccess-for-funnel-handson
aws iam delete-user --user-name awsiot-dataaccess-for-funnel-handson
```

# 運営の方へ

以下を準備の上、運営側シートへ書き込んでください

* ハンズオンID (e.g. `h0813` など)
* IAM Access Key ID
* IAM Secret Access Key ID

## ステップ 4 における AWS IoT Core へのデータ着信確認

いづれかの方法を使ってください

* AWS IoT Core 管理画面のテストツール
* [AWS IoT Monitor](https://ma2shita.s3.amazonaws.com/awsiot.html) (AWS Cognito の設定が別途必要です)

### トラブルシュート

* IAM 確認
    * IAM アカウントに紐づいている Access Key ID
    * IAM アカウントへの割り当てポリシー ( AWSIoTDataAccess ポリシーが必要 )
* AWS IoT Core 確認
    * カスタムエンドポイント (リージョン違い等)
    * Subscribe しているトピック名
* [AWS IoT Monitor](https://ma2shita.s3.amazonaws.com/awsiot.html) を使っての確認の場合
    * Cognito と AWS IoT のリージョン
    * ID プールの ID
    * 認証されていないロールへの割り当てポリシー ( `AWSIoTDataAccess` ポリシーが必要 )
    * Subscribe しているトピック名
