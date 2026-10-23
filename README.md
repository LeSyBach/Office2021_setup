# Office LTSC Professional Plus 2021 — bộ cài riêng tư

Cài Word, Excel và PowerPoint 64-bit, giao diện tiếng Anh và tiếng Việt bằng Office Deployment Tool của Microsoft.

> Gói này chứa khóa MAK trong `Configuration.xml`. 

Office LTSC 2021 đã hết hỗ trợ ngày **13/10/2026**: phần mềm vẫn có thể chạy nhưng không còn cập nhật bảo mật. [Thông báo Microsoft](https://learn.microsoft.com/en-us/lifecycle/announcements/office-ltsc-2021-end-of-support).

## Thư mục có gì?

- `Cai-Office2021.bat`: bấm đúp để tự yêu cầu quyền quản trị và chạy bộ cài.
- `setup.exe`: Office Deployment Tool có chữ ký Microsoft.
- `Configuration.xml`: cấu hình Office 2021, đã điền khóa MAK do chủ repo cung cấp và bật thử kích hoạt tự động.
- `officedeploymenttool_19725-20126.exe`: gói giải nén công cụ ban đầu, không cần mở lại khi đã có `setup.exe`.
- `configuration-Office365-x64.xml`: tệp mẫu Microsoft 365, **không dùng cho lệnh cài Office 2021 bên dưới**.

Gói này chưa chứa dữ liệu cài Office đầy đủ. Máy nhận vẫn cần Internet để tải Office từ Microsoft và thực hiện kích hoạt.

## Tạo hoặc chỉnh sửa Configuration.xml

Bạn có thể tạo cấu hình bằng công cụ chính thức **Office Customization Tool**:

[https://config.office.com/deploymentsettings](https://config.office.com/deploymentsettings)

Chọn các mục sau:

1. **Products and releases** → **Office LTSC Professional Plus 2021**.
2. **Architecture** → chọn **64-bit** (hoặc chọn 32-bit nếu máy cần tương thích với ứng dụng 32-bit).
3. **Update channel** → **PerpetualVL2021**.
4. **Apps** → chọn các ứng dụng cần cài, hoặc bỏ chọn ứng dụng không dùng.
5. **Language** → chọn `en-us` và `vi-vn` để cài cả tiếng Anh và tiếng Việt.
6. **Installation and update** → bật cập nhật nếu muốn nhận bản cập nhật từ Office CDN.
7. **Licensing and activation** → chọn **MAK** chỉ khi bạn có khóa MAK hợp lệ và được phép sử dụng. Không dán khóa vào cấu hình rồi đưa lên repo công khai.
8. Chọn **Export**, đặt tên `Configuration.xml`, rồi chép tệp xuất ra cùng thư mục với `setup.exe`.

Sau khi tạo xong, kiểm tra XML có các phần chính tương tự:

```xml
<Add OfficeClientEdition="64" Channel="PerpetualVL2021">
  <Product ID="ProPlus2021Volume">
    <Language ID="en-us" />
    <Language ID="vi-vn" />
  </Product>
</Add>
```

Nếu dùng `Cai-Office2021.bat`, hãy giữ đúng tên `Configuration.xml` và đặt cạnh file BAT. Cấu hình mới sẽ thay thế cấu hình cũ khi bạn chạy bộ cài. Office Customization Tool chỉ tạo tệp cấu hình; bộ cài vẫn cần `setup.exe` của Office Deployment Tool.

## Cách cài bằng một tệp BAT

1. Tải bằng **Code → Download ZIP** rồi **giải nén toàn bộ**. Không chạy BAT ngay trong cửa sổ xem ZIP.
2. Giữ `Cai-Office2021.bat`, `setup.exe` và `Configuration.xml` trong cùng thư mục. Có thể để thư mục ở ổ C, D hoặc vị trí khác; không bắt buộc chép vào `C:\Office2021`.
3. Lưu tài liệu và đóng các ứng dụng Office.
4. Bấm đúp **`Cai-Office2021.bat`**. Khi Windows hỏi quyền quản trị, chọn **Yes**; nhập thông tin tài khoản quản trị nếu được yêu cầu.
5. Chờ bộ cài tải và cài Office. Nếu bộ cài hiện điều khoản hoặc thông báo cần xử lý, hãy đọc và thao tác theo nội dung hiển thị.
6. Khi hoàn tất, mở **Word → File → Account** để kiểm tra **Product Activated**. Nếu được báo cần khởi động lại, lưu công việc rồi tự khởi động lại Windows.

BAT tự tìm bộ cài và cấu hình trong thư mục chứa nó. Nếu thiếu tệp, bị từ chối quyền quản trị hoặc cài lỗi, cửa sổ sẽ hiện thông báo. Các thông báo trong BAT dùng tiếng Anh để tránh lỗi dấu trên Command Prompt.

**Máy vẫn cần Internet.** BAT thực hiện cài Office 2021 theo cấu hình đã có; không tự chuyển sang Office 2024. Cấu hình có `<RemoveMSI />`, nên có thể gỡ các bản Office cũ dùng bộ cài MSI; nếu đang có Office khác, kiểm tra khả năng xung đột và giấy phép trước khi chạy.

Cấu hình đã có khóa MAK và bật thử kích hoạt tự động. Cài đặt thành công không bảo đảm kích hoạt thành công; kết quả còn phụ thuộc vào khóa và giấy phép của máy nhận.

### Chạy thủ công nếu cần

Mở Command Prompt bằng **Run as administrator**, vào đúng thư mục bộ cài, ví dụ:

```cmd
cd /d C:\Office2021
setup.exe /configure Configuration.xml
```

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

