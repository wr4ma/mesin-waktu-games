#!/data/data/com.termux/files/usr/bin/bash
# Terapkan update.zip lokal lalu push (alternatif jika zip > 25 MB untuk upload web).
# Pakai: bash tools/update.sh
set -e
[ -f update.zip ] || { echo "update.zip tidak ditemukan di folder ini"; exit 1; }
command -v unzip >/dev/null || pkg install -y unzip rsync
rm -rf /tmp/upd && mkdir /tmp/upd && unzip -q update.zip -d /tmp/upd
cd /tmp/upd
if [ "$(ls -A | wc -l)" = "1" ] && [ -d "$(ls -A | head -n1)" ]; then cd "$(ls -A | head -n1)"; fi
cp -a . "$OLDPWD"/
cd "$OLDPWD"
rm -f update.zip
git add -A
git commit -m "chore: terapkan update.zip" || echo "Tidak ada perubahan"
git push
