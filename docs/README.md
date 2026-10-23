# GreenTech Infrastructure MiniProject

Hệ thống mẫu quản lý hạ tầng và tài nguyên phần cứng cho Startup GreenTech.

## 1. Cấu trúc dự án

```text
10A1_NhapMonCNTT_MiniProject_Infrastructure/
├── docs/
│   ├── README.md
│   └── srs-he-thong.docx
├── scripts/
│   └── auto_report.bat
├── data/
│   ├── log-he-thong.log
│   └── quan-ly-thiet-bi.xlsx
├── backup/
│   └── bao-cao-su-co.txt
├── .env.example
└── .gitignore
```

## 2. Cách chạy script trên Windows

Mở Command Prompt tại thư mục gốc repository và chạy:

```bat
scripts\auto_report.bat
```

Script đọc `data\log-he-thong.log`, lọc các dòng có `CRITICAL` hoặc `ERROR`, rồi nối kết quả vào `backup\bao-cao-su-co.txt`.

> Script mẫu dùng `findstr` theo luồng, không nạp toàn bộ tệp log vào biến bộ nhớ. Nếu dùng PowerShell, có thể thay bằng `Select-String`.

## 3. Checklist kiểm tra thiết bị

- [ ] Kiểm tra mã trạm cảm biến.
- [ ] Đối chiếu mã linh kiện với danh mục.
- [ ] Kiểm tra dung lượng RAM và loại ổ lưu trữ.
- [ ] Xác nhận ngày lắp đặt.
- [ ] Kiểm tra báo cáo sự cố sau khi chạy script.

## 4. Bảng thông số phần cứng mẫu

| Thành phần | Thông số mẫu | Mục đích |
|---|---|---|
| CPU | ARM Cortex-A53 | Xử lý dữ liệu cảm biến |
| RAM | 4 GB | Chạy dịch vụ IoT |
| SSD | 128 GB | Lưu dữ liệu cục bộ |
| Kết nối | Ethernet/Wi-Fi | Truyền dữ liệu về máy chủ |

## 5. Mô hình IPO và DIKW

- **Input:** log hệ thống, mã linh kiện, thông số trạm.
- **Process:** lọc log, chuẩn hóa mã bằng TRIM, tra cứu VLOOKUP.
- **Output:** báo cáo sự cố và bảng danh mục thiết bị đã đối soát.

DIKW: dữ liệu thô (Data) được xử lý thành thông tin (Information), phân tích thành tri thức (Knowledge), từ đó hỗ trợ quyết định vận hành (Wisdom).

## 6. Excel: đối soát linh kiện

Workbook `data/quan-ly-thiet-bi.xlsx` có hai sheet:
- `danh-muc-linh-kien`: danh mục linh kiện, mã linh kiện là khóa chính.
- `trang-thai-tram`: danh sách trạm, mã linh kiện là khóa ngoại.

Công thức ví dụ (mã linh kiện ở B2, bảng danh mục ở sheet đầu tiên):

```excel
=IFERROR(VLOOKUP(TRIM(B2),'danh-muc-linh-kien'!$A$2:$D$101,2,FALSE),"Không tìm thấy mã")
```

Vùng tra cứu dùng `$` để cố định khi sao chép công thức. `FALSE` yêu cầu khớp chính xác.

## 7. Audit an toàn

Trước khi chạy script, xác nhận:
1. Đường dẫn log là `data\log-he-thong.log`.
2. Đường dẫn đầu ra là `backup\bao-cao-su-co.txt`.
3. Script chỉ đọc log và ghi nối báo cáo; không xóa tệp.
4. Không chạy các lệnh như `del /f /s /q` nếu chưa hiểu rõ phạm vi và chưa có bản sao lưu.

## 8. Ước tính thời gian tải log

Công thức gần đúng:

`Thời gian (giây) = Kích thước (MB) × 8 / Tốc độ (Mbps)`

Ví dụ log 500 MB qua đường truyền 100 Mbps: `500 × 8 / 100 = 40 giây` trong điều kiện lý tưởng. Thực tế thường lâu hơn do overhead và tốc độ mạng biến động.

## 9. Bảo mật và Git

Tệp `.env.example` chỉ chứa giá trị giả định. Hãy tạo `.env` cục bộ và không commit tệp này. `.gitignore` đã cấu hình để bỏ qua `.env`.
