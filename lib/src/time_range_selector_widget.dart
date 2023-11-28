import 'dart:math';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class TimeRangeSelectorWidget extends StatefulWidget {
  const TimeRangeSelectorWidget({
    Key? key,
    this.initialTime = 0,
    this.minTime = 0,
    this.maxTime = 12,
    this.handlePadding,
    this.stockWidth,
    this.depth = 2,
    this.stockColor,
    this.backgroundColor,
    this.shadowColorDark,
    this.shadowColorLight,
    this.childBuilder,
    this.positionalDotBuilder,
    this.positionalDotSize,
    this.positionalDotColor,
    this.handleColor,
    this.handleBuilder,
    this.onChangeValue,
  }) : super(key: key);

  /// A builder function to provide custom child widgets based on the selected time.
  final Widget Function(int currentTime)? childBuilder;

  /// A builder function to provide custom dots at specific positions.
  final Widget? Function(int itemIndex, Offset offset)? positionalDotBuilder;

  /// A builder function to provide custom dots at handle positions.
  final Widget? Function(int itemIndex, Offset offset)? handleBuilder;

  /// A callback function called when the selected time changes.
  final void Function(int currentTime)? onChangeValue;

  /// Canvas background color
  final Color? backgroundColor;

  /// Canvas depth
  final double depth;

  /// Handle point color
  /// Default: Theme.of(context).colorScheme.background
  final Color? handleColor;

  /// Handle point padding from Stock
  /// Default: Theme.of(context).buttonTheme.height / 3
  final double? handlePadding;

  /// The initial time value of the selector.
  final int initialTime;

  /// The maximum selectable time value.
  final int maxTime;

  /// The minimum selectable time value.
  final int minTime;

  /// Positional dots color.
  /// Theme.of(context).colorScheme.onBackground
  /// Theme.of(context).colorScheme.onPrimary
  final Color? positionalDotColor;

  /// Positional dots size.
  /// Default: Theme.of(context).buttonTheme.height / 8
  final double? positionalDotSize;

  /// Depth shadow Color
  final Color? shadowColorDark;

  /// Depth shadow Color
  /// Default: blendColors(baseColor: Colors.transparent, blendColor: Colors.white, blendMode: BlendModeType.screen).withOpacity(0.7)
  final Color? shadowColorLight;

  /// Stock / Progress bar color
  /// Theme.of(context).colorScheme.primary
  final Color? stockColor;

  /// Stock / Progress bar width
  /// Default: Theme.of(context).buttonTheme.height
  final double? stockWidth;

  @override
  State<TimeRangeSelectorWidget> createState() =>
      _TimeRangeSelectorWidgetState();
}

class _TimeRangeSelectorWidgetState extends State<TimeRangeSelectorWidget> {
  late int currentPosition;
  late double handlePadding;
  late double positionalDotSize;
  late double stockWidth;
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

  setValue() {
    stockWidth = widget.stockWidth ?? Theme.of(context).buttonTheme.height;
    handlePadding =
        widget.handlePadding ?? Theme.of(context).buttonTheme.height / 3;
    positionalDotSize =
        widget.positionalDotSize ?? Theme.of(context).buttonTheme.height / 8;
  }

  Widget drawBox({Widget? child, bool? isHandle, int? index}) {
    double s = isHandle != null ? widget.depth / 2 : widget.depth;

    Color? dotColor;

    if (widget.positionalDotColor != null) {
      dotColor = widget.positionalDotColor!;
    } else if (index != null) {
      dotColor = currentPosition < index
          ? Theme.of(context).colorScheme.onBackground
          : Theme.of(context).colorScheme.onPrimary;
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      margin: child == null ? null : EdgeInsets.all(stockWidth),
      decoration: BoxDecoration(
        color: isHandle != null
            ? isHandle
                ? widget.handleColor ?? Theme.of(context).colorScheme.background
                : dotColor
            : child == null
                ? null
                : Theme.of(context).colorScheme.background,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: widget.shadowColorLight ??
                blendColors(
                        baseColor: Colors.transparent,
                        blendColor: Colors.white,
                        blendMode: BlendModeType.screen)
                    .withOpacity(0.5),
            blurRadius: s,
            offset: Offset(-s, -s),
            inset: isHandle != null
                ? !isHandle
                : child ==
                    null, // This line should be comment if you don't want to use "flutter_inset_box_shadow" package
          ),
          BoxShadow(
            color: widget.shadowColorDark ??
                blendColors(
                        baseColor: Colors.transparent,
                        blendColor: Colors.black,
                        blendMode: BlendModeType.multiply)
                    .withOpacity(0.5),
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
          padding: EdgeInsets.all(handlePadding / 2),
          child: drawBox(isHandle: true),
        );
      } else {
        w = widget.handleBuilder!(index, offset) ?? const SizedBox();
      }
    } else {
      if (widget.positionalDotBuilder == null) {
        w = SizedBox(
          width: positionalDotSize,
          height: positionalDotSize,
          child: drawBox(isHandle: false, index: index),
        );
      } else {
        w = widget.positionalDotBuilder!(index, offset) ?? const SizedBox();
      }
    }

    return Positioned(
      left: offset.dx - (stockWidth / 2),
      top: offset.dy - (stockWidth / 2),
      child: Container(
        alignment: Alignment.center,
        width: stockWidth,
        height: stockWidth,
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
      if (widget.onChangeValue != null) {
        widget.onChangeValue!(i + widget.minTime);
      }
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
    setValue();
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, box) {
          double centerX = box.maxWidth / 2;
          double centerY = box.maxHeight / 2;
          final radius = min((box.maxHeight / 2) - (stockWidth / 2),
              (box.maxWidth / 2) - (stockWidth / 2));

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
                      stockColor: widget.stockColor ??
                          Theme.of(context).colorScheme.primary,
                      stokeWidth: stockWidth,
                      time: currentPosition,
                      totalTime: totalPosition,
                    ),
                  ),
                ),

                /// -------------------------------------------------------------------------------------- Back Canvas
                Positioned.fill(child: drawBox()),

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
                    margin: EdgeInsets.all(stockWidth),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                /// -------------------------------------------------------------------------------------- Front Canvas
                drawBox(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: widget.childBuilder == null
                        ? const SizedBox()
                        : widget
                            .childBuilder!(currentPosition + widget.minTime),
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
  });

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

//! ------------------------------------------------------------------------------------------------ Colors
Color blendColors(
    {required Color baseColor,
    required Color blendColor,
    required BlendModeType blendMode}) {
  double normalize(int value) => value / 255.0;

  int clamp(double value) => value.clamp(0, 255).toInt();

  switch (blendMode) {
    case BlendModeType.normal:
      return baseColor;

    case BlendModeType.multiply:
      return Color.fromARGB(
        baseColor.alpha,
        clamp(normalize(baseColor.red) * normalize(blendColor.red) * 255),
        clamp(normalize(baseColor.green) * normalize(blendColor.green) * 255),
        clamp(normalize(baseColor.blue) * normalize(blendColor.blue) * 255),
      );

    case BlendModeType.screen:
      return Color.fromARGB(
        baseColor.alpha,
        clamp((1 -
                (1 - normalize(baseColor.red)) *
                    (1 - normalize(blendColor.red))) *
            255),
        clamp((1 -
                (1 - normalize(baseColor.green)) *
                    (1 - normalize(blendColor.green))) *
            255),
        clamp((1 -
                (1 - normalize(baseColor.blue)) *
                    (1 - normalize(blendColor.blue))) *
            255),
      );

    default:
      return baseColor;
  }
}

enum BlendModeType {
  normal,
  multiply,
  screen,
}
