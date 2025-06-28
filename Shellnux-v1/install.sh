#!/bin/bash
# Shellnux v1 Game Builder - Improved Edition (30 Levels)
# Author: Mr. Gentleman & Assistant

BASE_DIR="/home/shellnux"
LEVELS=30
PASSWORD_LENGTH=20

mkdir -p "$BASE_DIR"
> /root/shellnux_v1_passwords.txt

HINTS=(
  "cat",
  "ls",
  "cd",
  "find",
  "chmod",
  "find",
  "bash",
  "base64",
  "filename with spaces",
  "filename with dash",
  "symlinks",
  "grep",
  "tar",
  "gzip",
  "csv format",
  "log search with grep",
  "find smallest file",
  "hex decode",
  "hidden ascii in noise",
  "cron logic",
  "special char in name",
  "grep in text",
  "strings in binary",
  "find in archive",
  "decode and decompress",
  "search real dir",
  "find by size",
  "hidden directory",
  "combine base64 + xxd",
  "read congrats"
)

for i in $(seq 0 $((LEVELS - 1))); do
  USER="shellnux$(printf "%02d" $i)"
  HOME_DIR="$BASE_DIR/$USER"

  useradd -m -d "$HOME_DIR" -s /bin/bash "$USER"
  chmod 750 "$HOME_DIR"

  if [ $i -eq 0 ]; then
    echo "$USER:$USER" | chpasswd
    echo "$USER:$USER" >> /root/shellnux_v1_passwords.txt
    continue
  fi

  PREV_USER="shellnux$(printf "%02d" $((i - 1)))"
  PREV_HOME="$BASE_DIR/$PREV_USER"
  PASS=$(openssl rand -base64 $PASSWORD_LENGTH | tr -d '/+=' | head -c $PASSWORD_LENGTH)

  echo "$USER:$PASS" | chpasswd
  echo "$USER:$PASS" >> /root/shellnux_v1_passwords.txt

  mkdir -p "$PREV_HOME"

  case $((i - 1)) in
    0) echo "$PASS" > "$PREV_HOME/pw.txt" ;;
    1) echo "$PASS" > "$PREV_HOME/.hiddenpw" ;;
    2) mkdir "$PREV_HOME/dir" && echo "$PASS" > "$PREV_HOME/dir/password.txt" ;;
    3) echo "Here's a clue buried in here..." > "$PREV_HOME/foundme.txt" && echo "Some noise text" >> "$PREV_HOME/foundme.txt" && echo "pw:$PASS" >> "$PREV_HOME/foundme.txt" ;;
    4) echo "$PASS" > "$PREV_HOME/locked.txt" && chmod 000 "$PREV_HOME/locked.txt" ;;
    5) mkdir -p "$PREV_HOME/a/b/c" && echo "$PASS" > "$PREV_HOME/a/b/c/deep.txt" ;;
    6) echo -e "#!/bin/bash\necho $PASS" > "$PREV_HOME/runme.sh" && chmod +x "$PREV_HOME/runme.sh" ;;
    7) echo "$PASS" | base64 > "$PREV_HOME/encoded.b64" ;;
    8) echo "$PASS" > "$PREV_HOME/file with space.txt" ;;
    9) echo "$PASS" > "$PREV_HOME/-strange" ;;
    10) echo "$PASS" > "$PREV_HOME/target.txt" && ln -s "$PREV_HOME/target.txt" "$PREV_HOME/link.txt" ;;
    11) for j in {1..10}; do echo $((RANDOM % 99999)) > "$PREV_HOME/data$j.txt"; done && echo "$PASS" > "$PREV_HOME/data$((RANDOM % 10 + 1)).txt" ;;
    12) echo "$PASS" > "$PREV_HOME/payload.txt" && tar -cf "$PREV_HOME/archive.tar" -C "$PREV_HOME" payload.txt && rm "$PREV_HOME/payload.txt" ;;
    13) echo "$PASS" > "$PREV_HOME/compressed.txt" && gzip "$PREV_HOME/compressed.txt" ;;
    14) for j in {1..10}; do echo "Sample data row $j" >> "$PREV_HOME/data.csv"; done && echo "pw:$PASS" >> "$PREV_HOME/data.csv" ;;
    15) for j in {1..1000}; do echo "Line $j: something" >> "$PREV_HOME/mixed.log"; done && sed -i "$((RANDOM % 999 + 1))s/.*/pw:$PASS/" "$PREV_HOME/mixed.log" ;;
    16) PASS_SHORT=$(echo "$PASS" | head -c 4); echo "$PASS_SHORT" > "$PREV_HOME/mini.txt"; echo "$USER:$PASS_SHORT" | chpasswd ;;
    17) echo -n "$PASS" | xxd -p > "$PREV_HOME/hexpw.txt" ;;
    18) for j in {1..10}; do echo $((RANDOM % 99999)) > "$PREV_HOME/data$j.txt"; done && echo "$PASS" > "$PREV_HOME/data$((RANDOM % 10 + 1)).txt" ;;
    19) echo "$PASS" > "$PREV_HOME/schedule.txt" ;;
    20) echo "$PASS" > "$PREV_HOME/#pwfile.txt" ;;
    21) for j in {1..1000}; do echo "line$j: junk" >> "$PREV_HOME/logs.txt"; done && sed -i "$((RANDOM % 999 + 1))s/.*/password:$PASS/" "$PREV_HOME/logs.txt" ;;
    22) echo "$PASS" > "$PREV_HOME/binarydump" ;;
    23) echo "$PASS" > "$PREV_HOME/inside.txt" && tar -cf "$PREV_HOME/dump.tar" -C "$PREV_HOME" inside.txt && rm "$PREV_HOME/inside.txt" ;;
    24) echo "$PASS" > "$PREV_HOME/base.txt" && gzip "$PREV_HOME/base.txt" ;;
    25) mkdir "$PREV_HOME/dirs" && echo "$PASS" > "$PREV_HOME/dirs/.real" ;;
    26) for j in {1..10}; do echo $((RANDOM % 99999)) > "$PREV_HOME/item$j.txt"; done && echo "$PASS" > "$PREV_HOME/item$((RANDOM % 10 + 1)).txt" ;;
    27) mkdir "$PREV_HOME/.secret" && echo "$PASS" > "$PREV_HOME/.secret/key.txt" ;;
    28) echo "$PASS" | xxd -p | base64 > "$PREV_HOME/encodedmix.txt" ;;
    29)
      echo "$PASS" > "$PREV_HOME/lastpass.txt"
      ;;
  esac

  echo "Hint: try using the command: ${HINTS[$((i - 1))]}" > "$PREV_HOME/hint.txt"
  chmod 444 "$PREV_HOME/hint.txt"
  chown -R $PREV_USER:$PREV_USER "$PREV_HOME"
done

# Ensure congrats message is in shellnux29's home
CONGRATS_DIR="$BASE_DIR/shellnux29"
echo "🎉 Congratulations! You completed Shellnux v1!" > "$CONGRATS_DIR/congrats.txt"
chmod 444 "$CONGRATS_DIR/congrats.txt"
chown shellnux29:shellnux29 "$CONGRATS_DIR/congrats.txt"