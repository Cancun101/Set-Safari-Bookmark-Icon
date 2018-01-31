#!/bin/zsh
# Fix Safari Favorites Icons

LSD="Library/Safari"
TIC="Touch Icons Cache"
TAB="cache_settings"
DIR="/$HOME/$LSD/$TIC/"

DBF="$DIR/${${TIC// /}%s*}${${(C)TAB}/_/}.db"
SQL=$(sqlite3 "$DBF" "SELECT host FROM $TAB")

diff <(ls "$DIR/Images") <(for i in "${=SQL}"; do echo ${(U)$(md5 -qs $i)}.png; done | sort)
sqlite3 "$DBF" "UPDATE $TAB SET ${${${(L)TIC// /_}#*_*}/s/_is_in}=1,download_status_flags=1"
for file in "$1"/*.png; do
  URL="$(plutil -convert xml1 -o - "$HOME/$LSD/Bookmarks.plist" | \
  awk -F '[</>]' -v f="${${file##*/}%%.*}" '{if($3~f){for(i=0;i<3;i++)getline;print $5}}')"; \
  cp -fv "$file" "$HOME/$LSD/Touch Icons Cache/Images/${(U)$(md5 -q -s $URL)}.png";
done
exit
