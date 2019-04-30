#!/bin/sh
#
# クリップボードの履歴をfzfを表示し、選択したものを水平連結する
# clipObserver.shで作成されたクリップボードログファイルを参照するスクリプト
#
DIR_CLIP_LOG=~/.cliplog

clip_logs=$(ls -t $DIR_CLIP_LOG | fzf --height 100% --prompt "CHOOSE" --preview "cat $DIR_CLIP_LOG/{}")
select_files=''
for clip_log in $clip_logs; do
    select_files="${select_files} ${DIR_CLIP_LOG}/${clip_log}"
done

if [ -n "$select_files" ]; then
    # 水平連結したものをクリップボードにコピーする
    paste $select_files | pbcopy
    pbpaste
fi

