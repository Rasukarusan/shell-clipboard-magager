#!/bin/sh
#
# 現在のクリップボードの内容をログファイルとして保存する
# crontabにセットしてクリップボード監視を行うためのスクリプト
# ログ保存場所は~/.cliplog/連番のファイル
#

DIR_CLIP_LOG=~/.cliplog
MAX_CLIP_CNT=100

clip_log_cnt=$(ls -1 $DIR_CLIP_LOG | wc -l | tr -d " ")
latest_clip_log=$(ls -t $DIR_CLIP_LOG | head -n 1)
oldest_clip_log=$(ls -t $DIR_CLIP_LOG | tail -n 1)

# クリップボードのログ置き場が存在しなければ作成する
if [ ! -e $DIR_CLIP_LOG ]; then
    mkdir $DIR_CLIP_LOG
fi

# クリップボードが空の場合は何もしない
if [ "$(pbpaste)" = "" ]; then
    exit
fi

# 一番最初はファイルが存在しないのでログファイル作成して終了
if [ -z $latest_clip_log ]; then
    pbpaste 2>/dev/null | /usr/local/bin/nkf -w > $DIR_CLIP_LOG/1
    exit
fi

# 最大履歴保存数を超えていたら一番古いファイルを削除する
if [ $clip_log_cnt -gt $MAX_CLIP_CNT ]; then
    rm $DIR_CLIP_LOG/$oldest_clip_log 2>/dev/null
fi

new_clip_log=$(expr $latest_clip_log + 1)
# クリップボードログを作成
pbpaste 2>/dev/null | /usr/local/bin/nkf -w > $DIR_CLIP_LOG/$new_clip_log


# 最新のクリップボードのログが現在の内容と同じだったら今作ったログを削除する
# ファイルを一旦作ってdiffを取るほうが動作が安定する
is_different=$(diff -EbB $DIR_CLIP_LOG/$latest_clip_log $DIR_CLIP_LOG/$new_clip_log)
if [ -z "$is_different" ]; then
    rm $DIR_CLIP_LOG/$new_clip_log 2>/dev/null
fi
