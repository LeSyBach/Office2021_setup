# Office LTSC Professional Plus 2021 — bộ cài riêng tư

Cài Word, Excel và PowerPoint 64-bit, giao diện tiếng Anh bằng Office Deployment Tool của Microsoft.

> Gói này chứa khóa MAK trong `Configuration.xml`. Chỉ lưu trong repo **Private** và chỉ cấp quyền cho người được phép dùng giấy phép. Số lượt kích hoạt không phải số giấy phép được quyền chia sẻ.

Office LTSC 2021 đã hết hỗ trợ ngày **13/10/2026**: phần mềm vẫn có thể chạy nhưng không còn cập nhật bảo mật. [Thông báo Microsoft](https://learn.microsoft.com/en-us/lifecycle/announcements/office-ltsc-2021-end-of-support).

## Thư mục có gì?

- `setup.exe`: Office Deployment Tool có chữ ký Microsoft.
- `Configuration.xml`: cấu hình Office 2021, đã điền khóa MAK do chủ repo cung cấp và bật thử kích hoạt tự động.
- `officedeploymenttool_19725-20126.exe`: gói giải nén công cụ ban đầu, không cần mở lại khi đã có `setup.exe`.
- `configuration-Office365-x64.xml`: tệp mẫu Microsoft 365, **không dùng cho lệnh cài Office 2021 bên dưới**.

Gói này chưa chứa dữ liệu cài Office đầy đủ. Máy nhận vẫn cần Internet để tải Office từ Microsoft và thực hiện kích hoạt.

## Cách cài trên máy nhận

1. Tải repo bằng **Code → Download ZIP**, rồi giải nén ZIP. Nếu nhận thư mục đã giải nén qua USB thì không cần bước này.
2. Chép các tệp sao cho `setup.exe` và `Configuration.xml` nằm trực tiếp trong `C:\Office2021`.
3. Lưu tài liệu, đóng Word, Excel và các ứng dụng Office. Nếu đã có Office khác, kiểm tra khả năng xung đột và giấy phép trước khi gỡ bản cũ.
4. Mở Start, gõ **cmd**, chọn **Run as administrator**.
5. Chạy lần lượt:

```cmd
cd /d C:\Office2021
setup.exe /configure Configuration.xml
```

Lệnh trên thực hiện cài đặt và có thể thay đổi Office đang có. Cấu hình có `<RemoveMSI />`, vì vậy có thể gỡ các bản Office cũ dùng bộ cài MSI.

6. Chờ cài xong, mở Word → **File → Account**, kiểm tra **Product Activated**.

Không cần chạy lại tệp giải nén Office Deployment Tool. Cấu hình đã có khóa, nhưng kích hoạt thành công còn phụ thuộc vào tính hợp lệ của khóa, hạn mức và giấy phép được cấp cho máy nhận.

## Kiểm tra kích hoạt

Lệnh sau chỉ đọc trạng thái:

```cmd
cscript "%ProgramFiles%\Microsoft Office\Office16\OSPP.VBS" /dstatusall
```

Nếu không tìm thấy tệp, thử:

```cmd
cscript "%ProgramFiles(x86)%\Microsoft Office\Office16\OSPP.VBS" /dstatusall
```

- `LICENSE STATUS: ---LICENSED---`: mục đó đang được kích hoạt.
- `RETAIL(MAK)` hoặc `VOLUME_MAK`: dạng MAK, kích hoạt một lần; không theo chu kỳ gia hạn 180 ngày của KMS.
- `REMAINING GRACE`: thời gian còn lại nếu công cụ có báo cáo.
- Nhiều mục `UNLICENSED` có thể xuất hiện khi dùng `/dstatusall`; đối chiếu đúng mục Office 2021 đang sử dụng.

Cài lại Windows hoặc đổi phần cứng có thể cần kích hoạt lại. `LICENSED` không thay thế bằng chứng quyền sử dụng hợp lệ và không bảo đảm khóa dùng được vĩnh viễn.

## Khi gặp lỗi

| Hiện tượng | Cách kiểm tra |
| --- | --- |
| Không nhận lệnh `setup.exe` | Kiểm tra đang ở đúng thư mục có `setup.exe` |
| Không tìm thấy cấu hình | Kiểm tra tên tệp không phải `Configuration.xml.txt` |
| Không tải được Office | Kiểm tra Internet và thông báo lỗi bộ cài |
| Xung đột Office 32-bit/64-bit | Đối chiếu kiến trúc các bản Office hiện có trước khi xử lý |
| Cài xong chưa kích hoạt | Kiểm tra Internet, giấy phép và mã lỗi; liên hệ bên cấp khóa |

## Nguồn Microsoft

- [Triển khai Office LTSC 2021](https://learn.microsoft.com/en-us/office/ltsc/2021/deploy)
- [Tải Office Deployment Tool mới nhất](https://www.microsoft.com/en-us/download/details.aspx?id=49117)
- [Kích hoạt Office bằng MAK](https://learn.microsoft.com/en-us/office/volume-license-activation/activate-office-by-using-mak)

Nếu bộ cài báo lỗi tương thích, tải Office Deployment Tool mới nhất từ nguồn trên và thay `setup.exe`, giữ lại cấu hình riêng của bạn.

