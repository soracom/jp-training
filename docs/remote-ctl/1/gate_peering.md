# SORACOM Gate (Public Gate) を使用して、 IP ベースの遠隔操作

本章では SORACOM Gate を使用して SORACOM Air SIM 間による遠隔操作を行います。

## ハンズオンのゴール

遠隔操作用の PC から、 Raspberry Pi に SSH でログインし、Raspberry Pi 内の設定を変更します。

## SORACOM Air SIM を VPG に所属させる

本ハンズオンにおいては VPG は作成せず、既に ソラコムで準備してある "Public Gate" という VPG を使用します。  
Public Gate の機能や個別に VPG を作成した場合との違いについては [SORACOM Gate の Public Gate 機能でデバイス間通信を試す](https://dev.soracom.io/jp/docs/public_gate/) で確認してください。

### SIM グループを作成する

[Menu] ＞ [SIM グループ] と進み、 SIM グループ一覧画面で [追加] をクリックします。(何もない場合は [SIM グループの作成] で進めていきます。)

その後、表示されたダイアログで以下のように設定します。

* グループ名: `public-gate` (任意の名前でかまいません)

最後に [グループ作成] をクリックします。

![remote-ctl / 1 gate_peering / create-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vTTeloEzakEE7Am8xiBHWITOhbsiyXZKYIGavbCWepQCHfaRkd1K8nr3HSWU3g0VowUwUyJg8wDfkNw/pub?w=773&h=626)

### SIM グループの設定をする

SIM グループの画面から [SORACOM Air for Cellular 設定] をクリックすると、設定内容が開きます。  
その中から VPG 設定を探し、スイッチを **ON** にした後、以下のように設定します。

* VPG: *Shared VPG for Public Gate (PublicGate)*

最後に [保存] をクリックし、その後、料金に関するダイアログが表示されるので [OK] をクリックします。

![remote-ctl / 1 gate_peering / conf-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vR20DutPGhAKc8SntvtUUrWvJwl0Cqn6dJ4lmiwVGsTX7Jx0HaG4WgLivefPQjnS4duWMm_IvlON51J/pub?w=735&h=701)

### SIM を SIM グループに所属させる

[Menu] ＞ [SIM 管理] と進み、 SIM 一覧画面で操作対象の SIM を選択(チェックボックスをつけ) [操作] をクリックします。  
表示されたメニューの一覧から [所属グループ変更] をクリックします。

その後、表示されたダイアログで以下のように設定します。

* 新しい所属グループ: *public-gate* (先ほど作成した SIM グループ名)

![remote-ctl / 1 gate_peering / join-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vRM_StcBUTeZTtWXu0-rMDlEG3RH4tdasM3GsLd7-lciHdqwvcUrf9x2fOZbAcCMx7icboIK_7Z1jQR/pub?w=705&h=707)

最後に [グループ変更] をクリックします。すると、以下のように SIM に SIM グループが設定されているので、確認してください。

![remote-ctl / 1 gate_peering / joined-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vR3xK5ftsP2HFBaaiR34hukrviCt0N18S6roU6tEH-sQfNs4DCBXvJwDuN92htVjMH2zkhXMUvZ0zNE/pub?w=459&h=100)

### SIM のセッションを切断(して、再接続)する

VPG に関する操作を行った場合は SIM のセッションを開きなおす(再接続)する必要があります。  
そこで SORACOM ユーザコンソール上からセッション切断を行い、 Raspberry Pi の再接続機能でセッションを再度接続するようにします。

[Menu] ＞ [SIM 管理] と進み、 SIM 一覧画面で操作対象の SIM を選択(チェックボックスをつけ) [操作] をクリックします。  
表示されたメニューの一覧から [セッション切断] をクリックします。

その後、表示されたダイアログで [セッション切断] をクリックします。

![remote-ctl / 1 gate_peering / disconnect-session](https://docs.google.com/drawings/d/e/2PACX-1vRZcY_CgLQDQZi3x__rc25yU8V0V0YnZ3k6S-nINi1gb9yaljhTNXE0dsq_mYMXqguuncWap_UaJqyS/pub?w=705&h=707)

以上で SORACOM Air SIM を VPG に所属させる作業は終了です。

#### コラム: セッションの切断と再接続について

「セッション」は、いわゆる回線の接続状態です。基本的にはオンライン(接続中)、オフライン(切断済)のいづれかとなります。  
セッションそのものについては [FAQ / 「セッション状態」「セッション履歴」とは何ですか？](https://soracom.zendesk.com/hc/ja/articles/223663487--%E3%82%BB%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3%E7%8A%B6%E6%85%8B-%E3%82%BB%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3%E5%B1%A5%E6%AD%B4-%E3%81%A8%E3%81%AF%E4%BD%95%E3%81%A7%E3%81%99%E3%81%8B-) をご覧ください。

セッションを能動的に切断する方法としては、スマートフォンや PC であれば「フライトモード」といった電波を発しない状態への切り替えや、モデムの電源のON/OFFといった方法がありますが、本ハンズオンで行ったように SORACOM ユーザコンソールを使用すれば、管理画面上からも切断が可能です。

セッションを切断した場合の再接続についてはデバイス側の実装に依存します。そのため、常時通信を行いたい、もしくは双方向通信のように通信待ち受けをしたい場合は、特に再接続処理を盛り込むようにしてください。

本ハンズオンで使用している Linux 上の実装である ppp は再接続処理が実装されているため、SORACOM ユーザコンソール上から切断しても、自動的にセッションがオンラインになるようになっています。

## IP アドレスを入手する

Raspberry Pi に挿している USB ドングル型モデムに割り当てられた IP アドレスを確認します。

[Menu] ＞ [SIM 管理] と進み、 SIM 一覧画面で操作対象の SIM を選択(チェックボックスをつけ) [詳細] をクリックします。

その後、表示されたダイアログの **IP アドレス** に表示された値をメモしてください。(後ほど、ログインの時に使用します。)

![remote-ctl / 1 gate_peering / lookup-ipaddress](https://docs.google.com/drawings/d/e/2PACX-1vRM6b6iIbyeq6j2e-lS_ZLUKrOnOF3wJ9Byw7tBDa86Ylco4CDv5UTFS9ujID3Yz98Rypy8pdA-7-pm/pub?w=745&h=717)

### コラム: そのほかの確認方法

SIM 一覧の画面で「歯車アイコン」をクリックする事で、一覧で表示できる列を制御することができます。  
例えば "IP アドレス" を選択することで、一覧に表示させることができるので便利です。

![remote-ctl / 1 gate_peering / colums-operation](https://docs.google.com/drawings/d/e/2PACX-1vRQOGdGRn7l6bsJRODrhNxh4qKNeFwvJKulVHAwt0SFZsJm9Jn6e5OXqJZ-AfT6J51A8EFFG3TGnnFO/pub?w=945&h=640)

## 遠隔操作用の PC からログインする

同じ VPG に所属している他の端末 (PC 等) から、Raspberry Pi に SSH でログインしてみましょう。  
**メモした IP アドレスが必要となります。**

### SSH でログインして Raspberry Pi の LED を制御する

SORACOM Air SIM 経由で SSH ログインをし、ログイン先 Raspberry Pi の LED を制御してみましょう。

他の端末から、自分の Raspberry Pi にログインします。  
※ 以下は macOS の場合です。Windows の場合は TeraTerm 等を利用してください

```console
ssh pi@10.XXX.XXX.XXX (メモをしてきた Raspberry Pi の IP アドレス)
```

ログインができたら、以下のコマンドでログイン先の Raspberry Pi の赤色 LED を点滅させます。

```console
echo heartbeat | sudo tee /sys/class/leds/led0/trigger
```

ログイン先の Raspberry Pi の 赤色 LED の点滅が始まったことを確認してください。  
点滅を停止する時は以下のコマンドになります。

```
echo none | sudo tee /sys/class/leds/led0/trigger
```

このように、グローバル IP アドレスが無くとも SORACOM Air SIM 間で IP による遠隔操作が可能となったことが確認できたかと思います。

## Public Gate VPG の所属を解除する

Public Gate VPG に限らず VPG は有料のサービスです。そのため、利用が済み次第終了することを強くお勧めします。


その後、表示されたダイアログで以下のように設定します。

* グループ名: `public-gate` (任意の名前でかまいません)

最後に [グループ作成] をクリックします。

![remote-ctl / 1 gate_peering / create-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vTTeloEzakEE7Am8xiBHWITOhbsiyXZKYIGavbCWepQCHfaRkd1K8nr3HSWU3g0VowUwUyJg8wDfkNw/pub?w=773&h=626)

### SIM グループの設定をする

[Menu] ＞ [SIM グループ] と進み、 SIM グループ一覧画面で *public-gate* (今回作成した SIM グループ) をクリックします。

SIM グループの画面から [SORACOM Air for Cellular 設定] をクリックすると、設定内容が開きます。  
その中から VPG 設定を探し、スイッチを **OFF** にした後、 [保存] をクリックします。

![remote-ctl / 1 gate_peering / unconf-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vS-L7xDjWH_E349zxVHq4DO0HnUG_mK0fYrUPFzGqblBwZJ6TkSJ4l_Al-CiMaL3M-2ZvsOczub7BXO/pub?w=700&h=729)

以上の作業で VPG 設定は OFF となるため課金対象ではなくなりますが、 SIM グループから SIM を外しておけば万全です。

#### SIM を SIM グループに所属させる

[Menu] ＞ [SIM 管理] と進み、 SIM 一覧画面で操作対象の SIM を選択(チェックボックスをつけ) [操作] をクリックします。  
表示されたメニューの一覧から [所属グループ変更] をクリックします。

その後、表示されたダイアログで [グループ解除] をクリックします。

![remote-ctl / 1 gate_peering / unjoin-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vTuu9ph5GnKtVhqxmsdg1HnAYcgfd8j__lAQly_gpBP1BcvFHjuCC6Up_iQR4osBTB8GZygswWl42HL/pub?w=705&h=704)

すると、以下のように SIM に SIM グループが「空」となるので、確認してください。

![remote-ctl / 1 gate_peering / unjoined-sim-group](https://docs.google.com/drawings/d/e/2PACX-1vSVV6UxulXlb4JaqAn2nEs-sRfGrvn68jBVUSEWw_unAhHACfW170_lg1O16PuEUpXHgEdFVbNwRckG/pub?w=447&h=100)

## 以上で本章は終了です

達成状況を運営表へご記入ください。

* [目次ページへ戻る](../index)

## Appendix

### 遠隔操作用の PC について

遠隔操作用の PC に取り付けている USB 型モデムドングルと、その中に入れている SORACOM Air SIM も、Public Gate VPG に所属させているため、 IP による通信が可能となっています。

また Public Gate によりオペレーター(アカウント)をまたいだ通信となっています。

![remote-ctl / 1 gate_peering / public-gate](https://docs.google.com/drawings/d/e/2PACX-1vQ_XsuW_8fKs94qs_UjQBarBPAGVpWcZ-lLDQyrBl60_9ult4d6uTtA-n4k_z8jHy2Br52ydJr7XqIP/pub?w=928&h=521)
