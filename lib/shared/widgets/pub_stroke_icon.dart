import 'package:flutter/material.dart';

/// 퍼블 `ui.js` / 화면 HTML과 동일한 stroke SVG 아이콘
enum PubStrokeIconType {
  bell,
  calendar,
  home,
  chat,
  chatDots,
  memory,
  profile,
  phone,
  more,
}

class PubStrokeIcon extends StatelessWidget {
  const PubStrokeIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color,
  });

  final PubStrokeIconType icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PubStrokeIconPainter(
        icon: icon,
        color: color ?? IconTheme.of(context).color ?? Colors.black,
      ),
    );
  }
}

class _PubStrokeIconPainter extends CustomPainter {
  _PubStrokeIconPainter({required this.icon, required this.color});

  final PubStrokeIconType icon;
  final Color color;

  static const _viewBox = 24.0;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / _viewBox;
    canvas.scale(scale);

    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    switch (icon) {
      case PubStrokeIconType.bell:
        _drawBell(canvas, stroke);
      case PubStrokeIconType.calendar:
        _drawCalendar(canvas, stroke);
      case PubStrokeIconType.home:
        _drawHome(canvas, stroke);
      case PubStrokeIconType.chat:
        _drawChat(canvas, stroke);
      case PubStrokeIconType.chatDots:
        _drawChat(canvas, stroke);
        for (final c in const [(8.5, 11.0), (12.0, 11.0), (15.5, 11.0)]) {
          canvas.drawCircle(Offset(c.$1, c.$2), 1, fill);
        }
      case PubStrokeIconType.memory:
        _drawMemory(canvas, stroke, fill);
      case PubStrokeIconType.profile:
        _drawProfile(canvas, stroke);
      case PubStrokeIconType.phone:
        _drawPhone(canvas, stroke);
      case PubStrokeIconType.more:
        for (final x in [5.0, 12.0, 19.0]) {
          canvas.drawCircle(Offset(x, 12), 1.6, fill);
        }
    }
  }

  void _drawBell(Canvas canvas, Paint stroke) {
    final body = Path()
      ..moveTo(6, 9)
      ..arcToPoint(const Offset(18, 9), radius: const Radius.circular(6), clockwise: false)
      ..cubicTo(18, 14, 20, 15, 20, 15)
      ..lineTo(4, 15)
      ..cubicTo(4, 15, 6, 14, 6, 9);
    canvas.drawPath(body, stroke);

    final clapper = Path()
      ..moveTo(10, 19)
      ..arcToPoint(const Offset(14, 19), radius: const Radius.circular(2));
    canvas.drawPath(clapper, stroke);
  }

  void _drawCalendar(Canvas canvas, Paint stroke) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(3.5, 5, 17, 16),
        const Radius.circular(3),
      ),
      stroke,
    );
    canvas.drawLine(const Offset(3.5, 9.5), const Offset(20.5, 9.5), stroke);
    canvas.drawLine(const Offset(8, 3.5), const Offset(8, 6.5), stroke);
    canvas.drawLine(const Offset(16, 3.5), const Offset(16, 6.5), stroke);
  }

  void _drawHome(Canvas canvas, Paint stroke) {
    canvas.drawLine(const Offset(4, 10.5), const Offset(12, 4), stroke);
    canvas.drawLine(const Offset(12, 4), const Offset(20, 10.5), stroke);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(5.5, 9.5, 13, 10.5),
        const Radius.circular(1),
      ),
      stroke,
    );
    canvas.drawLine(const Offset(9.5, 15), const Offset(9.5, 20), stroke);
    canvas.drawLine(const Offset(14.5, 15), const Offset(14.5, 20), stroke);
    canvas.drawLine(const Offset(9.5, 20), const Offset(14.5, 20), stroke);
  }

  void _drawChat(Canvas canvas, Paint stroke) {
    final bubble = Path()
      ..moveTo(4, 5.5)
      ..lineTo(20, 5.5)
      ..arcToPoint(const Offset(21, 6.5), radius: const Radius.circular(1))
      ..lineTo(21, 15.5)
      ..arcToPoint(const Offset(20, 16.5), radius: const Radius.circular(1))
      ..lineTo(9, 16.5)
      ..lineTo(5, 20)
      ..lineTo(5, 16.5)
      ..lineTo(4, 16.5)
      ..arcToPoint(const Offset(3, 15.5), radius: const Radius.circular(1))
      ..lineTo(3, 6.5)
      ..arcToPoint(const Offset(4, 5.5), radius: const Radius.circular(1));
    canvas.drawPath(bubble, stroke);
  }

  void _drawMemory(Canvas canvas, Paint stroke, Paint fill) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(3.5, 4.5, 17, 15),
        const Radius.circular(2.5),
      ),
      stroke,
    );
    canvas.drawLine(const Offset(3.5, 15), const Offset(7.5, 11.5), stroke);
    canvas.drawLine(const Offset(7.5, 11.5), const Offset(11, 14.5), stroke);
    canvas.drawLine(const Offset(11, 14.5), const Offset(15, 10.5), stroke);
    canvas.drawLine(const Offset(15, 10.5), const Offset(20.5, 15.5), stroke);
    canvas.drawCircle(const Offset(8.5, 9), 1.4, stroke);
  }

  void _drawProfile(Canvas canvas, Paint stroke) {
    canvas.drawCircle(const Offset(12, 8.5), 3.5, stroke);
    final body = Path()
      ..moveTo(5, 20)
      ..cubicTo(5.7, 16.4, 8.4, 14.5, 12, 14.5)
      ..cubicTo(15.6, 14.5, 18.3, 16.4, 19, 20);
    canvas.drawPath(body, stroke);
  }

  void _drawPhone(Canvas canvas, Paint stroke) {
    final phone = Path()
      ..moveTo(4, 5)
      ..cubicTo(4, 13, 11, 20, 19, 20)
      ..lineTo(20.5, 16.5)
      ..lineTo(16.5, 14.5)
      ..lineTo(15, 16)
      ..cubicTo(12.5, 13.5, 10.5, 11.5, 10, 11)
      ..lineTo(11.5, 9.5)
      ..lineTo(9.5, 5.5)
      ..close();
    canvas.drawPath(phone, stroke);
  }

  @override
  bool shouldRepaint(covariant _PubStrokeIconPainter oldDelegate) {
    return oldDelegate.icon != icon || oldDelegate.color != color;
  }
}
