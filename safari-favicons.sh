#!/bin/zsh
LSD="Library/Safari"; TIC="Touch Icons Cache"; TAB="cache_settings"; DIR="/$HOME/$LSD/$TIC/"
DBF="$DIR/${${TIC// /}%s*}${${(C)TAB}/_/}.db"; SQL=$(sqlite3 "$DBF" "SELECT host FROM $TAB")
diff <(ls "$DIR/Images") <(for i in "${=SQL}"; do echo ${(U)$(md5 -qs $i)}.png; done | sort)