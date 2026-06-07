# Deploy lên GitHub bằng 1 lệnh

Sau khi cài đặt 1 lần, mỗi khi tôi cập nhật `index.html`, bạn chỉ cần **bấm đúp `deploy.command`** (hoặc chạy 1 lệnh) là bản mới lên mạng.

---

## A. CÀI ĐẶT (chỉ làm 1 lần)

### 1. Tạo Personal Access Token trên GitHub
GitHub không cho dùng mật khẩu tài khoản khi push. Cần 1 token:

1. Vào **https://github.com/settings/tokens** → **Generate new token** → **Tokens (classic)**.
2. Note: `deploy-kho`; Expiration: chọn **No expiration** (hoặc 1 năm).
3. Tích quyền **`repo`**.
4. **Generate token** → **copy** chuỗi `ghp_...` và lưu lại (chỉ hiện 1 lần).

### 2. Kết nối thư mục với repo (mở Terminal, dán cả khối)

> Repo của bạn: **thanhhuyen2790-droid/kho-huyen** — đã điền sẵn bên dưới.

```bash
git config --global credential.helper osxkeychain
cd ~/Claude/Projects/"Phần mềm quản lý kho Huyền"
git init
git branch -M main
git remote add origin https://github.com/thanhhuyen2790-droid/kho-huyen.git
git add -A
git commit -m "deploy local"
git push -u origin main --force
```

Khi nó hỏi:
- **Username**: `thanhhuyen2790-droid`
- **Password**: dán **token `ghp_...`** (KHÔNG phải mật khẩu tài khoản)

### 3. Cho phép chạy file deploy
```bash
chmod +x ~/Claude/Projects/"Phần mềm quản lý kho Huyền"/deploy.command
```

Xong cài đặt.

---

## B. MỖI LẦN CẬP NHẬT (chọn 1 trong 2 cách)

**Cách 1 — Bấm đúp:** mở thư mục dự án trong Finder → bấm đúp **`deploy.command`**. (Nếu Mac chặn: chuột phải → Open → Open.)

**Cách 2 — Dán 1 lệnh vào Terminal:**
```bash
cd ~/Claude/Projects/"Phần mềm quản lý kho Huyền" && git add -A && git commit -m "cap nhat" && git push
```

Đợi ~1 phút rồi mở lại link GitHub Pages là thấy bản mới. Dữ liệu trên Supabase giữ nguyên.

---

## C. Cách khác: để tôi deploy giúp (không cần lệnh)

Vì hiện chưa có "trình kết nối GitHub" để tôi đẩy thẳng, lựa chọn mượt nhất nếu bạn muốn **chỉ cần nói "đẩy lên giúp"** là **kết nối Netlify** (có nút Connect tôi gửi trong khung chat). Khi đã kết nối:
- Bạn tạo tài khoản Netlify miễn phí (1 lần).
- Sau đó mỗi lần cần, bạn chỉ cần bảo tôi *"deploy bản mới"* — tôi đẩy thẳng `index.html` lên site Netlify của bạn, ra link cố định, không cần gõ lệnh.

Bạn muốn đi hướng GitHub (lệnh) hay Netlify (tôi deploy giúp) đều được — nói tôi biết.
