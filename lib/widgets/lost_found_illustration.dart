import 'package:flutter/material.dart';

class LostFoundIllustration extends StatelessWidget {
  const LostFoundIllustration({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
        width: 240,
        height: 190,
        child: CustomPaint(painter: _LostFoundPainter()),
      );
}

class _LostFoundPainter extends CustomPainter {
  const _LostFoundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 240, size.height / 190);
    final p = Paint()..isAntiAlias = true;

    p.color = const Color(0xFFEDEBFF);
    canvas.drawCircle(const Offset(117, 76), 63, p);

    canvas.save();
    canvas.translate(88, 37);
    canvas.rotate(-0.28);
    p.color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 68, 77),
        const Radius.circular(5),
      ),
      p,
    );
    canvas.restore();

    p.color = const Color(0xFF382D9C);
    canvas.drawPath(
      Path()
        ..moveTo(105, 103)
        ..lineTo(146, 91)
        ..lineTo(202, 104)
        ..lineTo(146, 119)
        ..close(),
      p,
    );
    p.color = const Color(0xFF6654E8);
    canvas.drawPath(
      Path()
        ..moveTo(72, 100)
        ..lineTo(100, 84)
        ..lineTo(141, 103)
        ..lineTo(106, 117)
        ..close(),
      p,
    );
    p.color = const Color(0xFF796AF2);
    canvas.drawPath(
      Path()
        ..moveTo(148, 102)
        ..lineTo(194, 87)
        ..lineTo(229, 103)
        ..lineTo(166, 123)
        ..close(),
      p,
    );
    p.color = const Color(0xFF6654E8);
    canvas.drawPath(
      Path()
        ..moveTo(72, 101)
        ..lineTo(141, 120)
        ..lineTo(141, 157)
        ..lineTo(72, 137)
        ..close(),
      p,
    );
    p.color = const Color(0xFF4637BE);
    canvas.drawPath(
      Path()
        ..moveTo(141, 120)
        ..lineTo(211, 103)
        ..lineTo(211, 137)
        ..lineTo(141, 157)
        ..close(),
      p,
    );
    p.color = const Color(0xFF5B4BDD);
    canvas.drawPath(
      Path()
        ..moveTo(54, 108)
        ..lineTo(73, 87)
        ..lineTo(143, 103)
        ..lineTo(120, 122)
        ..close(),
      p,
    );

    p.color = const Color(0xFFE7E5FA);
    canvas.drawOval(const Rect.fromLTWH(65, 151, 170, 9), p);

    p.color = const Color(0xFF30257D);
    canvas.drawCircle(const Offset(193, 66), 26, p);
    p.color = const Color(0xFFF8F8FC);
    canvas.drawCircle(const Offset(193, 66), 20, p);
    p.color = const Color(0xFF4C3BB7);
    canvas.save();
    canvas.translate(211, 84);
    canvas.rotate(-0.73);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-6, 0, 13, 42),
        const Radius.circular(6),
      ),
      p,
    );
    canvas.restore();

    p.color = const Color(0xFFF2D8D0);
    canvas.save();
    canvas.translate(187, 25);
    canvas.rotate(0.67);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-3, 0, 6, 21),
        const Radius.circular(3),
      ),
      p,
    );
    canvas.restore();
    p.color = const Color(0xFFD9D3FF);
    canvas.drawCircle(const Offset(73, 67), 2.7, p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LostFoundPainter oldDelegate) => false;
}
