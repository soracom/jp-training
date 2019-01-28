# Raspberry Pi の電源 OFF の方法

Raspberry Pi は電源ボタンがありません。 microUSB ケーブルから電源が供給され次第、電源が ON となります。

OFF にする方法は Raspberry Pi にログインしてから、下記コマンドを実行します。

```console
sudo systemctl halt
```

緑色 LED の点灯が途絶えたら microUSB ケーブルを抜きます。  
※ 緑色 LED は標準ではディスクへのアクセス状況です

## 再起動

再起動は以下のコマンドです。

```console
sudo systemctl reboot
```

### Raspberry Pi にログインできない場合

ログインできない場合は、緑色 LED の点灯がほぼなくなったころを見計らって microUSB ケーブルを抜きます。次回起動時にディスクの破損有無チェックなどが動きますので、起動に若干時間がかかる、もしくは起動できない可能性があります。

## 以上で本章は終了です

* [目次ページへ戻る](../index)
