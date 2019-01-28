#!/bin/bash

# 終了時に LED を消灯する
trap 'echo 0 > /sys/class/leds/led0/brightness ; exit' 2

# SORACOM Air メタデータサービスの `interval_sec` タグの値を取得
METADATA_VALUE=$(curl -q -s metadata.soracom.io/v1/subscriber.tags.interval_sec)
# 数値として利用可能かをチェックし、そうでなければ(取得できなかった時等)デフォルト値を採用する
expr "${METADATA_VALUE}" + 1 >/dev/null 2>&1
if [ $? -lt 2 ] ; then
        echo "Use metadata value (${METADATA_VALUE})"
        INTERVAL_SEC="${METADATA_VALUE}"
else
        echo "Use default value"
        INTERVAL_SEC="1"
fi

# メイン部
echo none > /sys/class/leds/led0/trigger
while true
do
        echo "on"
        echo 255 > /sys/class/leds/led0/brightness
        sleep ${INTERVAL_SEC}
        echo "off"
        echo 0 > /sys/class/leds/led0/brightness
        sleep ${INTERVAL_SEC}
done
