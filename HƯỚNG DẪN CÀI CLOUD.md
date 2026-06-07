# Hướng dẫn đưa phần mềm lên Cloud (Supabase)

Làm 1 lần duy nhất, khoảng 15 phút. Sau khi xong: dữ liệu lưu trên cloud, **đồng bộ thời gian thực** giữa máy tính và điện thoại của mọi người. Nhân sự đăng ký từ điện thoại → quản lý duyệt từ máy khác, tất cả thấy ngay.

> Nếu chưa cài cloud, file vẫn chạy bình thường ở chế độ **lưu cục bộ** (💾) — chỉ trên một máy. Sau khi cài xong sẽ chuyển sang **☁️ Cloud**.

---

## Bước 1 — Tạo tài khoản & dự án Supabase (miễn phí)

1. Vào **https://supabase.com** → bấm **Start your project** → đăng nhập bằng Google hoặc email.
2. Bấm **New project**.
   - **Name:** kho-huyen (tùy ý)
   - **Database Password:** đặt 1 mật khẩu mạnh và **lưu lại** (không cần dùng thường xuyên).
   - **Region:** chọn **Southeast Asia (Singapore)** cho nhanh.
3. Bấm **Create new project**, đợi ~2 phút cho project khởi tạo xong.

---

## Bước 2 — Tạo bảng dữ liệu (copy–paste 1 lần)

1. Trong project, mở menu trái → **SQL Editor** → **New query**.
2. Dán toàn bộ đoạn dưới đây vào rồi bấm **Run** (nút xanh, hoặc Ctrl/Cmd + Enter):

```sql
-- Bảng lưu toàn bộ dữ liệu phần mềm (1 dòng duy nhất)
create table if not exists app_state (
  id text primary key,
  data jsonb,
  client_id text,
  updated_at timestamptz default now()
);

-- Cho phép app (khóa anon) đọc/ghi
alter table app_state enable row level security;
drop policy if exists "anon_all" on app_state;
create policy "anon_all" on app_state
  for all to anon using (true) with check (true);

-- Bật đồng bộ thời gian thực cho bảng
alter publication supabase_realtime add table app_state;
```

3. Thấy báo **Success. No rows returned** là đúng. Xong bước này.

---

## Bước 3 — Lấy URL và khóa API

1. Menu trái → **Project Settings** (biểu tượng bánh răng) → **API**.
2. Copy 2 giá trị:
   - **Project URL** — dạng `https://abcdxyz.supabase.co`
   - **anon public** key — một chuỗi rất dài (bắt đầu bằng `eyJ...`)

> Khóa **anon public** dùng cho ứng dụng phía người dùng là bình thường, không phải bí mật. Tuyệt đối **không** dùng khóa `service_role`.

---

## Bước 4 — Dán vào phần mềm

1. Mở file **`quan-ly-kho.html`** bằng Notepad / TextEdit / VS Code (chuột phải → Open with).
2. Tìm đoạn đầu file (khoảng dòng 20):

```js
const SUPABASE_URL = "";       // VD: https://abcdxyz.supabase.co
const SUPABASE_ANON_KEY = "";  // chuỗi "anon public" key dài
```

3. Dán 2 giá trị vừa copy vào giữa hai dấu ngoặc kép, ví dụ:

```js
const SUPABASE_URL = "https://abcdxyz.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6...";
```

4. **Lưu file** (Ctrl/Cmd + S).
5. Mở lại file trong trình duyệt → sau khi đăng nhập, góc trên phải hiện **☁️ Cloud** là đã kết nối thành công.

---

## Bước 5 — Đưa lên mạng để truy cập từ điện thoại

Để mọi người mở được từ điện thoại, file cần một đường link trên internet. Cách dễ nhất, **miễn phí, không cần cài đặt**:

1. Vào **https://app.netlify.com/drop**
2. **Kéo–thả** file `quan-ly-kho.html` vào trang đó.
3. Netlify tạo ngay một đường link, ví dụ `https://ten-ngau-nhien.netlify.app`.
4. Gửi link này cho nhân sự. Mở trên điện thoại → đăng nhập bằng mật khẩu **user 123456** → đăng ký ca → bấm **Xác nhận & gửi duyệt**.
5. Bạn mở cùng link trên máy → đăng nhập **admin 204290** → vào tab **Phê duyệt**.

> Mẹo: trên điện thoại, mở link rồi bấm "Thêm vào màn hình chính" để dùng như một app.
> Mỗi lần bạn sửa file (đổi mật khẩu, chỉnh giao diện…) thì kéo–thả lại file mới lên Netlify để cập nhật. Dữ liệu nằm ở Supabase nên **không bị mất** khi cập nhật file.

---

## Mật khẩu đăng nhập

| Tài khoản | Mật khẩu | Quyền |
|---|---|---|
| Quản lý (Admin) | `204290` | Xem & sửa toàn bộ, phê duyệt đăng ký |
| Nhân sự (User) | `123456` | Chỉ đăng ký lịch, gửi duyệt |

Đổi mật khẩu: mở file HTML, tìm dòng `const PW={admin:'204290',user:'123456'};` và sửa.

---

## Lưu ý quan trọng

- **Bảo mật:** đây là công cụ nội bộ, bảo vệ bằng mật khẩu chung + đường link riêng. Phù hợp cho kho, nhưng không nên dùng cho dữ liệu nhạy cảm. Ai có link + mật khẩu đều vào được — chỉ chia sẻ trong nội bộ.
- **Sao lưu:** thỉnh thoảng vào tab **Cài đặt → Xuất dữ liệu (.json)** để giữ một bản dự phòng.
- **Gói miễn phí Supabase** dư sức cho quy mô vài chục người. Nếu để trống không dùng ~1 tuần, project có thể bị "tạm ngủ" — chỉ cần đăng nhập lại supabase.com để kích hoạt.
- **Xung đột hiếm gặp:** nếu hai người sửa đúng cùng một giây, bản lưu sau sẽ thắng. Với quy mô kho thì gần như không xảy ra.

Cần tôi hỗ trợ bước nào, cứ gửi ảnh chụp màn hình.
