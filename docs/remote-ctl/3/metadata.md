# SORACOM Air メタデータサービスを使用して、デバイス主導の遠隔制御

本章では SORACOM Air メタデータサービスを使用して、デバイス主導(基点)となる遠隔制御を行います。

## ハンズオンのゴール

Raspberry Pi 上で定期的に動く LED 点滅プログラムを設置します。  
点滅周期を SORACOM Air メタデータサービスに格納しておき、起動時に読み込むことで LED の点滅周期の変更をします。

## LED 点滅プログラムのインストール

Raspberry Pi にログインし、以下のコマンドを実行します。

```console
curl -O https://raw.githubusercontent.com/soracom/jp-training/master/docs/remote-ctl/3/rpi_led_interval.bash
```

### 参考: コマンドの実行結果

```console
pi@raspberrypi:~ $ curl -O https://raw.githubusercontent.com/soracom/jp-training/master/docs/remote-ctl/3/rpi_led_interval.bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   911  100   911    0     0   1236      0 --:--:-- --:--:-- --:--:--  1236```
```

## 動作テスト

```console
sudo bash rpi_led_interval.bash
```

緑色 LED が 1 秒毎に点滅することを確認します。  
`Ctrl + C` を押して、プログラムを終了してください。

### 参考: コマンドの実行結果

```console
pi@raspberrypi:~ $ sudo bash rpi_led_interval.bash
Use default value
on
off
on
off
on
off
```

## SORACOM Air メタデータサービスを設定する

先ほどインストールした `rpi_led_interval.bash` というプログラムは、 SORACOM Air SIM に設定できるメタデータを起動時に読み出すように実装されています。

具体的には `interval_sec` というキーに対する値を LED の点滅周期として利用するようになっています。

### SIM グループを作成する

[Menu] ＞ [SIM グループ] と進み、 SIM グループ一覧画面で [追加] をクリックします。(何もない場合は [SIM グループの作成] で進めていきます。)

その後、表示されたダイアログで以下のように設定します。

* グループ名: `metadata` (任意の名前でかまいません)

最後に [グループ作成] をクリックします。

![remote-ctl / 3 metadata / create-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vThakDBt_WP3WW8oVaF04i2wT1YZ0p6FtV0Y-d2t6qg4GoBWcIxUhbImh7uWi_vjTnJiVxapUG22MLM/pub?w=773&h=626)

### SIM グループの設定をする

SIM グループの画面から [SORACOM Air for Cellular 設定] をクリックすると、設定内容が開きます。  
その中からメタデータサービス設定を探し、スイッチを **ON** にした後、最後に [保存] をクリックします。

![remote-ctl / 3 metadata / conf-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vSEXWbbUFiy96X4FuVuMx4y4GUxp1-R47PqTPw34S_XZDR4pjfd6l4CToX_wkLqaP6Yx7PAVd9BofgP/pub?w=735&h=701)

### SIM を SIM グループに所属させる

[Menu] ＞ [SIM 管理] と進み、 SIM 一覧画面で操作対象の SIM を選択(チェックボックスをつけ) [操作] をクリックします。  
表示されたメニューの一覧から [所属グループ変更] をクリックします。

その後、表示されたダイアログで以下のように設定します。

* 新しい所属グループ: *metadata* (先ほど作成した SIM グループ名)

![remote-ctl / 3 metadata / join-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vQHMl58vzjFa6bgOnvTvoSba3Wpe06FfKN6A_UqV4natSF9gy3XuRWDFHkFznpfi2Qw6pfHoit1CxoC/pub?w=705&h=707)

最後に [グループ変更] をクリックします。すると、以下のように SIM に SIM グループが設定されているので、確認してください。

![remote-ctl / 3 metadata / joined-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vT6elgLG53I_jSatxyYd37nBlH3nRFle3vvqb4FsdQuKDpN-Gb1ODuBcYKv_sqFjRxonsOg8G_7ZgrT/pub?w=459&h=100)

ここまでの作業で SIM から `http://metadata.soracom.io/v1/subscriber` もしくは `http://metadata.soracom.io/v1/userdata` へのアクセスが許可されるようになりました。

### メタデータを設定する

SIM に対するメタデータを実際に設定します。

[Menu] ＞ [SIM 管理] と進み、 SIM 一覧画面で操作対象の SIM を選択(チェックボックスをつけ) [詳細] をクリックします。

その後、表示されたダイアログで [タグ] をクリックします。その後 [＋] をクリックした後のダイアログで以下のように設定sます。

* 名前: `interval_sec`
* 値: `2`

![remote-ctl / 3 metadata / set-metadata](https://docs.google.com/drawings/d/e/2PACX-1vSdd34Oit-ntJuTjuVvtDA_lCJ8ZxmGnIUl73BZfijne8KQJBYCifAfqLc_D4m357tqPhsvNDY2RWGi/pub?w=749&h=962)

最後に [保存] をクリックします。

## LED 点滅プログラムを再実行する

ここまでの作業で `rpi_led_interval.bash` が起動したときにメタデータが読み出せれば、その値を LED の点滅周期として利用できるようになったはずですので、確認してみましょう。

```console
sudo bash rpi_led_interval.bash
```

緑色 LED が **2 秒毎** に点滅することを確認します。  
`Ctrl + C` を押して、プログラムを終了してください。

### 参考: コマンドの実行結果

メタデータの値を採用した際にはプログラム実行時に `Use metadata value (x)` と表示されます。  
※ x には取得できた値が出力されます。

```console
pi@raspberrypi:~ $ sudo bash rpi_led_interval.bash
Use metadata value (2)
on
off
on
off
on
```

## interval_sec を変更してみる

`interval_sec` の値を 2 から他の値に変えてみてから、再度 `rpi_led_interval.bash` を実行しなおしてみて、プログラムを編集せずとも挙動を変えることができる事を確認してみてください。

## 以上で本章は終了です

達成状況を運営表へご記入ください。

* [目次ページへ戻る](../index)
