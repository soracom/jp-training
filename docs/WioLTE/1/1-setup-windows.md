本テキストは [Wio LTE](https://soracom.jp/products/module/wio_lte/) を使用するために必要なソフトウェアを Windows にインストール手順を説明します。

## 準備するもの

* パソコン / 1台
    * インターネットに接続できる環境
    * USB Type-A ポートが最低1つ以上あり、利用可能なこと
        * 電力供給が1A以上であること (USB 3.0対応していれば概ね安心です)
    * OS: Windows(8.1 もしくは 10)
        * ※ソフトウェアをインストールするため、PCに対する管理者権限を持っている事 と ブラウザでのアクセス制限がかかっていない事
* Wio LTE (本体、 電源兼シリアルコンソール用microUSBケーブル) / 1式

# Wio LTE 基礎

## 《知識》Wio LTE の電源ON/OFFの方法

Wio LTE には電源スイッチがありませんので、下記作業で ON / OFF してください

### 電源 ON

microUSB ケーブルを Wio LTE の microUSB ポートに接続すると自動的にONになります

![Wio LTE と PC を microUSBケーブルで取り付けたところ](https://docs.google.com/drawings/d/e/2PACX-1vSgLUCOrN928URIfbcNC0VR4xwSBOCYm8ngs0d2edkWyu4ZC7VNoXjALvKOXv121zk3RZB2vF9J40fB/pub?w=640&h=480)

### 電源 OFF

microUSB ケーブルを抜きます。いきなり抜いて OK です

※シャットダウン処理は存在しません

## 【作業】Wio LTE の "通常モード" と "DFUモード"

Wio LTE は２つのモードを持っています  
**この操作は Wio LTE の開発で何度も行うことになりますので、必ず覚えてください**

* 書き込まれたプログラムを実行する「通常モード」
* プログラムを書き込むことができる「DFUモード」 (DFU = Device Firmware Upgrade)

![フロー](https://docs.google.com/drawings/d/e/2PACX-1vQAcnymqWTTneRwnc9EFz21YvrmfCsIuV33yfqf1ODC_LKQR-6762CJDMclRIWC8BfUeDDLpC6KKs-2/pub?w=581&h=253)


これらのモードの切り替えは Wio LTE 上の **RSTボタン** と **BOOTボタン** の組み合わせで行います  
各ボタンの位置は下記のとおりです（ Wio LTE の表裏にボタンがあるため、横からみた図で確認ください）

![Wio LTE を横からみた図](https://docs.google.com/drawings/d/e/2PACX-1vRnhRiZC7-jRCqLaxJO6E7Bmq0_8BxornXgP1y6UHdYXhr6iBm_RNoV148oSzJKeHBYXRjYai9msQoz/pub?w=480&h=249)

### 「通常モード」での動作のさせ方

microUSBをPC等に接続して電源が供給されると Wio LTE は 通常モード で起動します  
もしくは、起動中の Wio LTE の *RSTボタン* を押すと 通常モード に移行します

RSTボタンを利用した通常モードへの移行

![to-normal.gif](https://drive.google.com/uc?export=view&id=1UiIRR8Uhzt-WJSkGvj2ja9RQ3_7--YnS)

※動画ではmicroUSB接続をしていませんが、実際は接続した状態で行ってください

#### 確認方法

後述する「Virtual COM Port ドライバ」がインストールされていれば、デバイスマネージャの *ユニバーサル シリアル バス デバイス* (Windows 7 の場合は *Universal Serial Bus Devices*) の一覧に **STMicroelectronics Virtual COM Port** が表示されていれば、通常モードで動作しています

「不明なデバイス」等になっている場合は、このページの後半で解説している「Virtual COM Port ドライバ」をインストールしてください

![Windows 通常モードの時のデバイスマネージャの表示](https://dev.soracom.io/img/gs_wio-lte/basic-normal-win.png)

### 「DFUモード」での動作のさせ方

「通常モード」の Wio LTE に対して、下記操作を行います

1. *BOOTボタン* を押し、 **押し続けてください**
2. *RSTボタン* を押し、離します
3. 押し続けていた *BOOTボタン* を離します

DFUモードへの移行方法  
※動画ではmicroUSB接続をしていませんが、実際は接続した状態で行ってください

![to-dfu.gif](https://drive.google.com/uc?export=view&id=1d6UmE2_SXy7bkwZ30NSpSIK1Px0ErU9U)

#### 確認

デバイスマネージャの *ユニバーサル シリアル バス デバイス* (Windows 7 の場合は *Universal Serial Bus Devices*) の一覧に **STM32 BOOTLOADER** が表示されていれば、DFUモードで動作しています

![Windows DFUモードの時のデバイスマネージャの表示](https://dev.soracom.io/img/gs_wio-lte/basic-dfu-win.png)

# 追加ソフトウェアのインストールの手順

Wio LTE を使うためには、開発環境の準備を行います

* Virtual COM Port ドライバ
* WinUSB ドライバ
* TeraTerm

## 1. Virtual COM Port ドライバ

Wio LTE を通常モードで動作させた際に、Wio LTE にシリアルポートでアクセスするためのドライバです

Virtual COM Port ドライバは [Github: SeeedJP/WioLTEforArduino - InstallVCOMDriver-ja](https://github.com/SeeedJP/WioLTEforArduino/wiki/InstallVCOMDriver-ja) の手順に従ってファイルの入手とインストールを行ってください

### 確認方法

Wio LTE を PC と接続してみてください  
その際デバイスマネージャ上で **STMicroelectronics Virtual COM Port** と表示されるようになれば、インストールに成功しています

![Windows 通常モードの時のデバイスマネージャの表示](https://dev.soracom.io/img/gs_wio-lte/basic-normal-win.png)

## 2. WinUSB ドライバ

Wio LTE を DFU モード に切り替えてファイル書き込みを行う際に必要なドライバです

### 2-1. [Zadigサイト](http://zadig.akeo.ie/) の Download にある **Zadig 2.4** をクリックして、zadig-2.4.exeをダウンロードします

### 2-2. Wio LTE を DFUモード に切り替えます

DFUモードへの切り替え方は、このページの前半で確認してください

### 2-3. zadig-2.4.exe を起動する

### 2-4. zadig-2.4.exe の [Options] > [List All Devices]

### 2-5. **STM32 BOOTLOADER** を選んだ後、Driver欄の左を *STTub30* 、右を *WinUSB* に変更してから、Replace Driverをクリックします  

![](https://github.com/SeeedJP/WioLTEforArduino/wiki/img/11.png)

### 2-6. デバイスマネージャの *ユニバーサル シリアル バス デバイス* (Windows 7 の場合は *Universal Serial Bus Devices*) の一覧に **STM32 BOOTLOADER** が表示されていれば成功です

![Windows DFUモードの時のデバイスマネージャの表示](https://dev.soracom.io/img/gs_wio-lte/basic-dfu-win.png)

## 3. TeraTerm

Wio LTE からのシリアルコンソールを読み書きするためのソフトウェアです  
※Wio LTE 開発の際、Arduino IDE 標準搭載のシリアルモニターは動作が不安定になることがあるため、TeraTermを利用するようにしてください

検索エンジンで TeraTerm を探し、ダウンロードとインストールを行ってください

## 以上でインストール作業は完了です。

[元のページ](1-setup#LED)に戻って続けてください。
