import 'package:flutter/material.dart';

class RoundedTabIndicator extends Decoration {
  final BoxPainter _painter;

  RoundedTabIndicator({
    required Color color,
    required double radius,
    required double indicatorHeight,
  }) : _painter = _RoundedPainter(
          color,
          radius,
          indicatorHeight,
        );

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _RoundedPainter extends BoxPainter {
  final Paint _paint;
  final double radius;
  final double indicatorHeight;

  _RoundedPainter(Color color, this.radius, this.indicatorHeight)
      : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Rect rect = Offset(
          offset.dx,
          cfg.size!.height - indicatorHeight,
        ) &
        Size(cfg.size!.width, indicatorHeight);

    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rRect, _paint);
  }
}
