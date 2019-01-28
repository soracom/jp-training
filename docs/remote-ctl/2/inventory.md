# SORACOM Inventory を使用して、アプリケーションベースの遠隔制御

本章では SORACOM Inventory を使用して SORACOM コンソール上からデバイスの遠隔制御を行います。

## ハンズオンのゴール

Raspberry Pi へ SORACOM Inventory エージェント(ソフトウェア)をインストールし、 SORACOM コンソール上から Raspberry Pi の再起動を行います。

## SORACOM Inventory エージェント (Java 版) のインストール

**ここからの作業は一度 USB ドングル型モデムを抜き、LTE 通信をしない状態にしてから行ってください**  
通信量が多くなり、費用がかさむためです。

Raspberry Pi にログインし、以下のコマンドを実行します。

```console
cd ~
sudo apt install -y openjdk-9-jre-headless
curl -L -O https://github.com/soracom/soracom-inventory-agent-for-java/releases/download/0.0.6/soracom-inventory-agent-example-0.0.6.zip
unzip -o soracom-inventory-agent-example-0.0.6.zip
```

### 参考: コマンドの実行結果

```console
$ cd ~
$ sudo apt install -y openjdk-9-jre-headless
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  ca-certificates-java java-common libavahi-client3 libcups2 liblcms2-2 libnspr4 libnss3 libxi6 libxrender1
  libxtst6 x11-common
Suggested packages:
-- 略 --
update-alternatives: using /usr/lib/jvm/java-9-openjdk-armhf/bin/tnameserv to provide /usr/bin/tnameserv (tnames
erv) in auto mode
update-alternatives: using /usr/lib/jvm/java-9-openjdk-armhf/lib/jexec to provide /usr/bin/jexec (jexec) in auto
 mode
Processing triggers for libc-bin (2.24-11+deb9u3) ...
Processing triggers for systemd (232-25+deb9u6) ...
pi@raspberrypi:~ $ curl -L -O https://github.com/soracom/soracom-inventory-agent-for-java/releases/download/0.0.6/soracom-inventory-agent-example-0.0.6.zip
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   631    0   631    0     0    539      0 --:--:--  0:00:01 --:--:--   539
100 1654k  100 1654k    0     0   169k      0  0:00:09  0:00:09 --:--:--  226k
pi@raspberrypi:~ $ unzip -o soracom-inventory-agent-example-0.0.6.zip
Archive:  soracom-inventory-agent-example-0.0.6.zip
  inflating: soracom-inventory-agent-example-0.0.6/lib/soracom-inventory-agent-for-java-example-0.0.6.jar
  inflating: soracom-inventory-agent-example-0.0.6/lib/soracom-inventory-agent-for-java-core-0.0.6.jar
-- 略 --
  inflating: soracom-inventory-agent-example-0.0.6/bin/script/DeviceObject-Reboot.sh
  inflating: soracom-inventory-agent-example-0.0.6/bin/script/SoftwareComponent-Activate.sh```
```

## SORACOM Inventory エージェント (Java 版) の実行

ここから先は USB ドングル型モデムを挿してから行ってください。(SORACOM Air 経由での通信が必要です)

```
cd ~/soracom-inventory-agent-example-0.0.6/bin/
sudo ./soracom-inventory-agent-example-start
```

### 参考: コマンドの実行結果

```console
pi@raspberrypi:~ $ cd ~/soracom-inventory-agent-example-0.0.6/bin/
pi@raspberrypi:~/soracom-inventory-agent-example-0.0.6/bin $ sudo ./soracom-inventory-agent-example-start
-- 略 --
2019-01-28 06:29:00,494 INFO InventoryAgentInitializer - set bootstrap security object.
2019-01-28 06:29:00,505 INFO InventoryAgentInitializer - set instance to initializer.objectId:30000 instance num:1
2019-01-28 06:29:00,507 INFO InventoryAgentInitializer - set instance to initializer.objectId:3 instance num:1
2019-01-28 06:29:00,509 INFO InventoryAgentInitializer - set instance to initializer.objectId:6 instance num:1
2019-01-28 06:29:00,510 INFO InventoryAgentInitializer - set instance to initializer.objectId:14 instance num:1
-- 略 --
ACK_RANDOM_FACTOR=1.5, and ACK_TIMEOUT_SCALE=2.0
2019-01-28 06:29:01,750 INFO LeshanClient - Starting Leshan client ...
2019-01-28 06:29:01,751 INFO CoapServer - Starting server
-- 略 --
2019-01-28 06:29:02,445 INFO RegistrationEngine - Bootstrap started
-- 略 --
2019-01-28 06:29:03,704 INFO JCEFileCredentialStore - save credential to /home/pi/.soracom-inventory-jce
-- 略 --
2019-01-28 06:29:04,936 INFO BootstrapObserver - Registration success: deviceId:d-vmb24jvjdkpmmk2ppru8 ...
-- 略 --
2019-01-28 06:29:04,981 INFO InventoryResourceObservationTimerTask - start observation. observationStartDelaySeconds:10 observationIntervalSeconds:60
2019-01-28 06:29:05,159 INFO ExampleSoftwareComponentObject - latitude=2.1
2019-01-28 06:29:05,161 INFO ExampleSoftwareComponentObject - longitude=1.1
2019-01-28 06:29:14,979 INFO InventoryResourceObservationTimerTask - fire resource change for observation.
```

## SORACOM Iventory でデバイス状況を確認する

[Menu] ＞ [デバイス管理] と進み、 デバイス一覧画面で操作対象のデバイスを選択(チェックボックスをつけ) [詳細] をクリックします。  
先ほど起動した Raspberry Pi の状態が SORACOM Inventory エージェントを通じて SORACOM に送信されています。

![remote-ctl / 2 inventory / go-inventory](https://docs.google.com/drawings/d/e/2PACX-1vSN0ES_1u_BqEiFEwLaoYEoA5dJoMccgdvLLu2exoOONx_jisFyz7g9v0LwATOcCI8dZ1NZbCa_YrmV/pub?w=962&h=519)

### デバイス状況の詳細を確認したり、再起動を指示する

### 情報の更新

例えば `Current Time` は Raspberry Pi の現在時刻を表示しています。  
リロードボタンを押したタイミングで SORACOM 側から Agent に向けて情報更新要求が送信され、結果が SORACOM 上に返ってきます。

![remote-ctl / 2 inventory / update-value](https://docs.google.com/drawings/d/e/2PACX-1vSwVGPT5-1-F7dgQ_tmyDey8LrqXP2bfIrhKg26bw1sFSmn_AsBzIJeQqKoJpJWSF1trkgAIEYjqBP0/pub?w=934&h=100)

### Reboot 指示を出す

詳細画面から `Reboot` の実行をクリックすると、ダイアログが表示されます。  

![remote-ctl / 2 inventory / reboot-command](https://docs.google.com/drawings/d/e/2PACX-1vSDI9TcnQbusnFn_xvyL-aCLYU6pr1ETzno3468t9_6jysM6BzTdb8_JbwLi1EenXIsBAgeuEgWhDXc/pub?w=935&h=342)

Raspberry Pi のコンソールには、以下のような表示が出て SSH の接続が切れます。(再起動がかかったため)

```console
2019-01-28 07:52:00,444 INFO ExampleSoftwareComponentObject - executeReboot command=DeviceObject-Reboot.sh param=
```

この間に SORACOM Inventory のデバイス詳細画面を再読み込み(リロード)すると **オフライン** と表示されます。

![remote-ctl / 2 inventory / offline](https://docs.google.com/drawings/d/e/2PACX-1vSlg-WRIMi-_vrcl31UYkfCcNnfDJ8PYumv1KMt3zWljvTJZOz2nfIfhzOLpm7ouAOzKTZPsWqYbPja/pub?w=596&h=438)

### 再度エージェントを実行してみる

エージェント自体は OS 起動時に自動起動するようには構成されていません。そのため、再度手動で起動します。

```
cd ~/soracom-inventory-agent-example-0.0.6/bin/
sudo ./soracom-inventory-agent-example-start
```

この後 SORACOM Inventory のデバイス詳細画面を再読み込み(リロード)すると **オンライン** と表示されます。

## SORACOM Inventory デバイスの削除

SORACOM Inventory はアクティブデバイスに課金されるサービスであるため、不要なデバイスは削除することを強くお勧めします。

デバイスの詳細画面から [高度な設定] をクリックし、[このデバイスを削除する] をクリックします。ダイアログが表示されますが、そこで [削除] するとデバイス削除は完了です。

![remote-ctl / 2 inventory / remove-device](https://docs.google.com/drawings/d/e/2PACX-1vRoGpjmre2BMk8dY2cosgvY-7uaqPGMAcdvWWoteB0PuGaq5WdouF4ruheCkNV_EiKHWVA_P_x1zZGC/pub?w=714&h=580)

### エージェントを停止する

`Ctrl + C` でエージェントを停止します。  
この時点でエージェントを起動すると **新たなデバイスとして認識され、費用が発生しますので注意してください**

## 以上で本章は終了です

達成状況を運営表へご記入ください。

* [目次ページへ戻る](../index)
