Raspberry Pi + USBドングルの機材では「遠隔制御」、スターターキット(Wio LTE)の機材では「Wio LTE」の手順を進めてください。時間に対して分量が多いので、進められるところまで進められれば良いでしょう。

# Wio LTE

- 事前準備を済ませておいてください

- 受講生PC/Mac : <a href="0/prepare" target="_blank">0.事前準備</a>
- AWS : 
  - [AWS IoT Core の準備](/jp-training/WioLTE/2/1-soracom-funnel+aws-iot-core#setup-awsiotcore)
    - 「AWS セットアップ内容」のコマンドのうち環境構築部分を実行し、実行結果に表示されるAPIキーとシークレットキーを手順2-1で受講生に通知します。
  - AWS IoT Coreのエンドポイントを控えておきます。手順2-1で受講生に通知します。
    - [AWS Management ConsoleのAWS IoT設定画面](https://ap-northeast-1.console.aws.amazon.com/iot/home?region=ap-northeast-1#/settings) の「Endpoint」

## ハンズオン手順

- [1-1.セットアップ〜動作確認](/jp-training/WioLTE/1/1-setup)
- [1-2.デバイス稼働時間を SORACOM Harvest で可視化](/jp-training/WioLTE/1/2-uptime)
- [1-3.温湿度センサーのデータを SORACOM Harvest で可視化](/jp-training/WioLTE/1/3-sensor)
- [2-1.クラウド連携 / SORACOM Funnel + AWS IoT Core 編](/jp-training/WioLTE/2/1-soracom-funnel+aws-iot-core)
- <a href="0/closing" target="_blank">0.おわりに (今後の費用、片付け方)</a>
    - [Appendix. ハンズオンで使用した環境の構築方法](0/appendix#aws-iot-core)

# 遠隔制御

## ハンズオン手順

- [1. 事前準備 ～ SORACOM Air でインターネットに接続する](/jp-training/remote-ctl/0/prepare_short)
  - **`setup_air.sh` のダウンロードと実行済みです。**
- [2. SORACOM Napterを使用して、IPベースの遠隔操作](/jp-training/remote-ctl/1/napter)
- [2. SORACOM Inventory を使用して、アプリケーションベースの遠隔制御](/jp-training/remote-ctl/2/inventory)
  - **手順に必要なソフトウェアパッケージとプログラムはダウンロード済みです。**
- [3. SORACOM Air メタデータサービスを使用して、デバイス主導の遠隔制御](/jp-training/remote-ctl/3/metadata)

- [Raspberry Pi の電源 OFF の方法](/jp-training/remote-ctl/0/poweroff)
