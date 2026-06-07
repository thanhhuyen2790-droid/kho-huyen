#!/bin/bash
# Bấm đúp vào file này để đẩy bản mới lên GitHub.
# (Lần đầu phải chạy phần CÀI ĐẶT trong file DEPLOY-GITHUB.md trước.)
cd "$(dirname "$0")"
echo "==> Đang đẩy bản mới lên GitHub (kho-huyen)..."
git add -A
git commit -m "Cap nhat $(date '+%Y-%m-%d %H:%M')" || echo "(Khong co thay doi moi de luu)"
git push && echo "==> XONG. Doi ~1 phut roi mo lai link GitHub Pages." || echo "==> Loi khi day. Xem DEPLOY-GITHUB.md."
read -p "Nhan Enter de dong cua so..."
