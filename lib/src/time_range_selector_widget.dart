import 'dart:math';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class TimeRangeSelectorWidget extends StatefulWidget {
  const TimeRangeSelectorWidget({
    super.key,
    this.initialTime = 0,
    this.minTime = 0,
    this.maxTime = 12,
    this.handlePadding = 12,
    this.stockWidth = 24 * 2,
    this.depth = 3,
    this.stockColor,
    this.backgroundColor,
    this.shadowColorDark,
    this.shadowColorLight,
    this.childBuilder,
    this.positionalDotBuilder,
    this.positionalDotSize = 8,
    this.positionalDotColor = Colors.black,
    this.handleColor,
    this.handleBuilder,
    this.onChangeValue,
  });

  /// A builder function to provide custom child widgets based on the selected time.
  final Widget Function(int currentTime)? childBuilder;

  /// A builder function to provide custom dots at specific positions.
  final Function(int itemIndex, Offset offset)? positionalDotBuilder;

  /// A builder function to provide custom dots at handle positions.
  final Function(int itemIndex, Offset offset)? handleBuilder;

  /// A callback function called when the selected time changes.
  final Function(int currentTime)? onChangeValue;

  /// Canvas background color
  final Color? backgroundColor;

  /// Canvas depth
  final double depth;

  /// Handle point color
  final Color? handleColor;

  /// Handle point padding from Stock
  final double handlePadding;

  /// The initial time value of the selector.
  final int initialTime;

  /// The maximum selectable time value.
  final int maxTime;

  /// The minimum selectable time value.
  final int minTime;

  /// Positional dots color.
  final Color positionalDotColor;

  /// Positional dots size.
  final double positionalDotSize;

  /// Depth shadow Color
  final Color? shadowColorDark;

  /// Depth shadow Color
  final Color? shadowColorLight;

  /// Stock / Progress bar color
  final Color? stockColor;

  /// Stock / Progress bar width
  final double stockWidth;

  @override
  State<TimeRangeSelectorWidget> createState() =>
      _TimeRangeSelectorWidgetState();
}

class _TimeRangeSelectorWidgetState extends State<TimeRangeSelectorWidget> {
  late int currentPosition;
  late int totalPosition;

  @override
  void initState() {
    super.initState();

    if (widget.initialTime < widget.minTime ||
        widget.initialTime > widget.maxTime) {
      throw Exception("Current time must be in time range (Max and min time)");
    }
    currentPosition = widget.initialTime - widget.minTime;

    if (widget.maxTime <= widget.minTime) {
      throw Exception("Max Time must be greater than min time");
    }
    totalPosition = widget.maxTime - widget.minTime + 1;
  }

  Widget drawBox(
      {required BuildContext context, Widget? child, bool? isHandle}) {
    double s = isHandle != null ? widget.depth / 2 : widget.depth;
    return Container(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      margin: child == null ? null : EdgeInsets.all(widget.stockWidth),
      decoration: BoxDecoration(
        color: isHandle != null
            ? isHandle
                ? widget.handleColor ?? Theme.of(context).canvasColor
                : widget.positionalDotColor
            : child == null
                ? null
                : Theme.of(context).canvasColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: widget.shadowColorLight ??
                Theme.of(context).cardColor.withOpacity(0.5),
            blurRadius: s,
            offset: Offset(-s, -s),
            inset: isHandle != null
                ? !isHandle
                : child ==
                    null, // This line should be comment if you don't want to use "flutter_inset_box_shadow" package
          ),
          BoxShadow(
            color: widget.shadowColorDark ??
                Theme.of(context).shadowColor.withOpacity(0.5),
            blurRadius: s,
            offset: Offset(s, s),
            inset: isHandle != null
                ? !isHandle
                : child ==
                    null, // This line should be comment if you don't want to use "flutter_inset_box_shadow" package
          ),
        ],
      ),
      child: child,
    );
  }

  Widget dot(
      double centerX, double centerY, double radius, int index, bool isHandle) {
    Offset offset = _countOffset(
        centerX: centerX,
        centerY: centerY,
        radius: radius,
        currentPosition: index,
        totalPosition: totalPosition);

    Widget w;

    if (isHandle) {
      if (widget.handleBuilder == null) {
        w = Padding(
          padding: EdgeInsets.all(widget.handlePadding / 2),
          child: drawBox(context: context, isHandle: true),
        );
      } else {
        w = widget.handleBuilder!(index, offset);
      }
    } else {
      if (widget.positionalDotBuilder == null) {
        w = SizedBox(
          width: widget.positionalDotSize,
          height: widget.positionalDotSize,
          child: drawBox(context: context, isHandle: false),
        );
      } else {
        w = widget.positionalDotBuilder!(index, offset);
      }
    }

    return Positioned(
      left: offset.dx - (widget.stockWidth / 2),
      top: offset.dy - (widget.stockWidth / 2),
      child: Container(
        alignment: Alignment.center,
        width: widget.stockWidth,
        height: widget.stockWidth,
        child: w,
      ),
    );
  }

  /// Handles the time change when dragging.
  changeTime(double angle) async {
    int i = ((angle / 360) * totalPosition).round();
    if (i >= totalPosition) i = 0;
    if (currentPosition != i) {
      if (mounted) setState(() => currentPosition = i);
      if (widget.onChangeValue != null)
        widget.onChangeValue!(i + widget.minTime);
    }
  }

  /// Calculates the angle of a point relative to the center of the clock selector.
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
      child: LayoutBuilder(
        builder: (context, box) {
          double centerX = box.maxWidth / 2;
          double centerY = box.maxHeight / 2;
          final radius = min((box.maxHeight / 2) - (widget.stockWidth / 2),
              (box.maxWidth / 2) - (widget.stockWidth / 2));

          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: widget.backgroundColor),
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// -------------------------------------------------------------------------------------- Line
                Positioned.fill(
                  child: CustomPaint(
                    painter: _CustomClockPickerPaint(
                      stockColor:
                          widget.stockColor ?? Theme.of(context).primaryColor,
                      stokeWidth: widget.stockWidth,
                      time: currentPosition,
                      totalTime: totalPosition,
                      positionalDotSize: widget.positionalDotSize,
                      positionalDotColor: widget.positionalDotColor,
                    ),
                  ),
                ),

                /// -------------------------------------------------------------------------------------- Back Canvas
                Positioned.fill(child: drawBox(context: context)),

                /// -------------------------------------------------------------------------------------- Front Canvas
                drawBox(
                  context: context,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: widget.childBuilder == null
                        ? const SizedBox()
                        : widget
                            .childBuilder!(currentPosition + widget.minTime),
                  ),
                ),

                /// --------------------------------------------------------------------------------------- Small Dots
                for (int i = 0; i < totalPosition; i++)
                  dot(centerX, centerY, radius, i, false),

                /// --------------------------------------------------------------------------------------- Big Dot
                dot(centerX, centerY, radius, currentPosition, true),

                /// --------------------------------------------------------------------------------------- Draggable
                Positioned.fill(
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      double angle = angleCounter(
                          Size(box.maxWidth, box.maxHeight), details);
                      // print(angle);
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
            ),
          );
        },
      ),
    );
  }
}

class _CustomClockPickerPaint extends CustomPainter {
  const _CustomClockPickerPaint({
    required this.stockColor,
    required this.stokeWidth,
    required this.time,
    required this.totalTime,
    required this.positionalDotSize,
    required this.positionalDotColor,
  });

  final Color positionalDotColor;
  final double positionalDotSize;
  final Color stockColor;
  final double stokeWidth;
  final int time;
  final int totalTime;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min((size.height / 2) - (stokeWidth / 2),
        (size.width / 2) - (stokeWidth / 2));

    //! -------------------------------------------------------------------------------------------- Line
    var arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = stockColor;
    double currentAngle = time * (2 * pi) / totalTime;
    if (currentAngle == 0) currentAngle = 0.0001;
    final arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(arcRect, -pi / 2, currentAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Offset _countOffset(
    {required double centerX,
    required double centerY,
    required double radius,
    required int currentPosition,
    required int totalPosition}) {
  double x = centerX +
      radius * cos((270 + (360 * currentPosition / totalPosition)) * pi / 180);
  double y = centerY +
      radius * sin((270 + (360 * currentPosition / totalPosition)) * pi / 180);
  return Offset(x, y);
}
