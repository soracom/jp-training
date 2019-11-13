- 事前準備を済ませておいてください

- 受講生PC/Mac : 
  - Tera Termやターミナルなど、SSHクライアントをインストールしておく
- AWS : 
  - IAMの操作が可能なIAMユーザーを用意しておく

- <a href="/jp-training/WioLTE/0/closing" target="_blank">0.おわりに (今後の費用、片付け方)</a>
    - [Appendix. ハンズオンで使用した環境の構築方法](/jp-training/WioLTE/0/appendix#aws-iot-core)

## ハンズオン手順

- [1. 事前準備 ～ SORACOM Air でインターネットに接続する](/jp-training/remote-ctl/0/prepare_short)
  - **`setup_air.sh` のダウンロードと実行済みです。**
- [2. SORACOM Napterを使用して、SSHリモートアクセス](/jp-training/remote-ctl/1/napter)
- 3〜7は順不同で取り組んでいただけます。
  - [3. デバイス稼働時間を SORACOM Harvest で可視化](/jp-training/raspi/3-harvest)
  - [4. クラウド連携 / SORACOM Funnel + AWS Kinesis Data Firehose 編](/jp-training/raspi/4-funnel)
  - [5. クラウド連携 / SORACOM Beam + AWS IoT Core 編](/jp-training/raspi/5-beam)
  - [6. クラウド連携 / SORACOM Funk + AWS Lambda 編](/jp-training/raspi/6-funk)
  - [7. SORACOM Air メタデータサービスを使用して、デバイス主導の遠隔制御](/jp-training/remote-ctl/3/metadata)

- [Raspberry Pi の電源 OFF の方法](/jp-training/remote-ctl/0/poweroff)
