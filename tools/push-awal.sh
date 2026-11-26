#!/data/data/com.termux/files/usr/bin/bash
# Push pertama project ke GitHub dari Termux (Android).
# Pakai: bash tools/push-awal.sh USERNAME_GITHUB TOKEN_GITHUB
# Token: GitHub > Settings > Developer settings > Personal access tokens (scope: repo, workflow)
set -e
USER="$1"; TOKEN="$2"; REPO="Mesin-Waktu-Games"
if [ -z "$USER" ] || [ -z "$TOKEN" ]; then
  echo "Pakai: bash tools/push-awal.sh USERNAME TOKEN"; exit 1
fi
command -v git >/dev/null || pkg install -y git curl

# Buat repo (abaikan error jika sudah ada)
curl -s -X POST -H "Authorization: token $TOKEN" \
  -d "{\"name\":\"$REPO\",\"private\":false}" \
  https://api.github.com/user/repos >/dev/null || true

[ -d .git ] || git init -b master
git config user.name "$USER"
git config user.email "$USER@users.noreply.github.com"
git add -A
git commit -m "Initial commit: Mesin-Waktu-Games" || true
git remote remove origin 2>/dev/null || true
git remote add origin "https://$USER:$TOKEN@github.com/$USER/$REPO.git"
git push -u origin master
echo "Selesai. Aktifkan Pages: Settings > Pages > Source: GitHub Actions"
