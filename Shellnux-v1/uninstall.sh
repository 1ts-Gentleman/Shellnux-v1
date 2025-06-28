# uninstall.sh
#!/bin/bash
read -p "This will remove all Shellnux v1 users and files. Are you sure? [y/N]: " confirm
if [[ "$confirm" != "y" ]]; then
  echo "Aborted."
  exit 1
fi

for i in $(seq 0 29); do
  user="shellnux$(printf "%02d" $i)"
  userdel -r "$user" 2>/dev/null
  echo "Removed user: $user"
done

rm -rf /home/shellnux
rm -f /root/shellnux_v1_passwords.txt

echo "Shellnux v1 has been uninstalled."
