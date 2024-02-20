import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint();
    var paint2 = Paint();
    var paint3 = Paint();
    var paint4 = Paint();

    // Vẽ một điểm màu
    paint1.color = primaryColor.withOpacity(0.3); // Điều chỉnh màu sắc và độ mờ
    paint2.color = darkCyan.withOpacity(0.3); // Điều chỉnh màu sắc và độ mờ
    paint3.color = gold.withOpacity(0.3); // Điều chỉnh màu sắc và độ mờ
    paint4.color = deepPink.withOpacity(0.3); // Điều chỉnh màu sắc và độ mờ
    canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.6), size.width * 0.2, paint2);
    canvas.drawCircle(
        Offset(size.width * 0.9, size.height * 0.3), size.width * 0.3, paint1);
    canvas.drawCircle(
        Offset(size.width * 0.1, size.height * 0.1), size.width * 0.2, paint3);
    canvas.drawCircle(
        Offset(size.width, size.height), size.width * 0.2, paint4);
    // Thêm các lệnh vẽ khác để tạo thêm điểm màu tại các vị trí khác nhau
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
