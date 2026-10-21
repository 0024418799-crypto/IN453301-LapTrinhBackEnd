# Trả lời câu hỏi Slide 34: Vì sao cần cô lập (Isolation)?

## Tình huống tranh chấp (Race Condition):
- Khi hai phiên (An và Bình) cùng đọc số chỗ trống tại một thời điểm, cả hai đều thấy còn 1 chỗ[cite: 214].
- Cả hai cùng thực hiện lệnh `INSERT` đăng ký làm cho số người đăng ký vượt quá sức chứa tối đa của khóa học (ví dụ: 41/40 người)[cite: 214].

## Cách giải quyết:
- Sử dụng cơ chế khóa hàng với `SELECT ... FOR UPDATE` trong transaction[cite: 34, 214].
- Phiên A giữ khóa hàng cho đến khi `COMMIT`, phiên B phải chờ phiên A hoàn tất mới được kiểm tra và xử lý tiếp, tránh tình trạng tranh chấp dữ liệu[cite: 34, 214].