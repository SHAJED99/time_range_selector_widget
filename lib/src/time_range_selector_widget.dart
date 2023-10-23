import 'dart:math';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class TimeRangeSelectorWidget extends StatefulWidget {
  const TimeRangeSelectorWidget({
    super.key,
    required this.initialTime,
    this.maxTime = 12,
    this.stockWidth = 24 * 2,
    this.padding = 8,
    required this.stockColor,
    this.shadowColorLight = Colors.white,
    this.shadowColorDark = const Color(0XFF8E9BAE),
    this.backgroundColor = const [
      Colors.white,
      Colors.white,
    ],
    this.onChangeValue,
    this.childBuilder,
    required this.colorGradient,
    this.dotBuilder,
  });

  final int initialTime;
  final int minTime = 1;
  final int maxTime;
  final double stockWidth;
  final double padding;

  final Color stockColor;
  final List<Color> colorGradient;
  final Color shadowColorLight;
  final Color shadowColorDark;
  final List<Color> backgroundColor;
  final Function(int currentTime)? onChangeValue;
  final Widget Function(int currentTime)? childBuilder;
  final Function(int itemIndex, Offset offset, Canvas canvas)? dotBuilder;

  @override
  State<TimeRangeSelectorWidget> createState() => _TimeRangeSelectorWidgetState();
}

class _TimeRangeSelectorWidgetState extends State<TimeRangeSelectorWidget> {
  late int currentTime;
  late int totalTime;

  @override
  void initState() {
    super.initState();
    currentTime = widget.initialTime;
    totalTime = widget.maxTime - widget.minTime + 2;
    if (widget.maxTime <= widget.minTime) throw Exception("Max Time must be greater than min time");
    if (currentTime < widget.minTime || currentTime > widget.maxTime) throw Exception("Current time must be in time range (Max and min time)");
  }

  Widget drawBox({required BuildContext context, Widget? child}) {
    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      margin: child == null ? null : EdgeInsets.all(widget.stockWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: child == null ? null : LinearGradient(colors: widget.colorGradient),
        color: child == null ? null : Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: widget.shadowColorLight,
            blurRadius: widget.padding / 2,
            offset: Offset(-widget.padding / 2, -widget.padding / 2),
            inset: child == null, // This line should be comment if you don't want to use "flutter_inset_box_shadow" package
          ),
          BoxShadow(
            color: widget.shadowColorDark,
            blurRadius: widget.padding / 2,
            offset: Offset(widget.padding / 2, widget.padding / 2),
            inset: child == null, // This line should be comment if you don't want to use "flutter_inset_box_shadow" package
          ),
        ],
      ),
      child: child,
    );
  }

  changeTime(double angle) async {
    int i = ((angle / 360) * totalTime).round();
    if (i > widget.maxTime) i = 0;
    if (currentTime != i && widget.onChangeValue != null) {
      if (mounted) setState(() => currentTime = i);
      widget.onChangeValue!(i);
    }
  }

  double angleCounter(Size size, DragUpdateDetails details) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final double dx = details.localPosition.dx - centerX;
    final double dy = details.localPosition.dy - centerY;

    double angle = atan2(dy, dx);
    angle = 90 + (angle * 180 / pi);
    if (angle < 0) angle += 360;
    return angle;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (context, box) {
        return Stack(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          children: [
            //! -------------------------------------------------------------------------------------- Background
            Positioned.fill(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: widget.backgroundColor),
                ),
              ),
            ),

            //! -------------------------------------------------------------------------------------- Line
            Positioned.fill(
              child: CustomPaint(
                painter: CustomClockPickerPaint(
                  time: currentTime,
                  totalTime: totalTime,
                  stokeWidth: widget.stockWidth,
                  stockColor: widget.stockColor,
                  padding: widget.padding,
                  dotBuilder: widget.dotBuilder,
                ),
              ),
            ),

            //! -------------------------------------------------------------------------------------- Back Canvas
            Positioned.fill(child: drawBox(context: context)),

            //! -------------------------------------------------------------------------------------- Front Canvas
            drawBox(
              context: context,
              child: AspectRatio(
                aspectRatio: 1,
                child: widget.childBuilder == null ? const SizedBox() : widget.childBuilder!(currentTime),
              ),
            ),

            //! -------------------------------------------------------------------------------------- Draggable
            Positioned.fill(
              child: GestureDetector(
                onPanUpdate: (details) {
                  double angle = angleCounter(Size(box.maxWidth, box.maxHeight), details);
                  changeTime(angle);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            //! Blocking Touch
            Positioned.fill(
              child: Container(
                margin: EdgeInsets.all(widget.stockWidth),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CustomClockPickerPaint extends CustomPainter {
  final int time;
  final int totalTime;
  final double stokeWidth;
  final double padding;
  final Color stockColor;
  final Function(int itemIndex, Offset offset, Canvas canvas)? dotBuilder;

  CustomClockPickerPaint({
    super.repaint,
    required this.time,
    required this.totalTime,
    required this.stokeWidth,
    required this.padding,
    required this.stockColor,
    this.dotBuilder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min((size.height / 2) - (stokeWidth / 2), (size.width / 2) - (stokeWidth / 2));

    //! -------------------------------------------------------------------------------------------- Line
    var arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = stockColor;
    double currentAngle = time * (2 * pi) / totalTime;
    final arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(arcRect, -pi / 2, currentAngle, false, arcPaint);

    //! -------------------------------------------------------------------------------------------- Small Dot
    final smallDotColor = Paint()..color = Colors.black;
    for (var i = 0; i < totalTime; i++) {
      final smallDotX = centerX + radius * cos((270 + (360 * i / totalTime)) * pi / 180);
      final smallDotY = centerY + radius * sin((270 + (360 * i / totalTime)) * pi / 180);
      final offset = Offset(smallDotX, smallDotY);

      if (dotBuilder != null) {
        dotBuilder!(i, offset, canvas);
      } else {
        canvas.drawCircle(offset, padding / 3, smallDotColor);
      }
    }

    //! -------------------------------------------------------------------------------------------- Big Dot
    final fillPaint = Paint()..color = Colors.white;
    final dotX = centerX + radius * cos((270 + (360 * time / totalTime)) * pi / 180);
    final dotY = centerY + radius * sin((270 + (360 * time / totalTime)) * pi / 180);
    canvas.drawCircle(Offset(dotX, dotY), (stokeWidth / 2) - padding, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
