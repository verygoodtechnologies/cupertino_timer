library cupertino_timer;

import 'dart:ui';
import 'package:flutter/material.dart';

import 'src/timer_painter.dart';

class CupertinoTimer extends StatefulWidget {
  CupertinoTimer({
    Key key,

    // The duration of time the widget should countdown from.
    @required this.duration,

    // Function listener for current value.
    this.valueListener,

    // Whether or not the widget should start countdown after appearing.
    this.startOnInit = false,

    // Custom style of time string.
    this.timeStyle,

    // Color for timer circle, default is green.
    this.ringColor = Colors.green,

    // Width of the timer circle.
    this.ringStroke = 6.0,
  }) : super(key: key);

  final Duration duration;

  final void Function(Duration timeElapsed) valueListener;

  final bool startOnInit;

  final TextStyle timeStyle;

  final Color ringColor;

  final double ringStroke;

  @override
  State<StatefulWidget> createState() {
    return _CupertinoTimerState();
  }
}

class _CupertinoTimerState extends State<CupertinoTimer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  bool running = false;

  @override
  void initState() {
    controller = AnimationController(vsync: this);

    controller.duration = widget.duration;
    controller.addListener(_animationValueListener);
    controller.addStatusListener(_animationStatusListener);
    if (widget.startOnInit) {
      controller.forward();
      running = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!running) {
          controller.forward();
          running = true;
        } else if (running) {
          controller.stop();
          running = false;
        }
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: <Widget>[
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return CustomPaint(
                      size: MediaQuery.of(context).size,
                      painter: TimerPainter(
                          animation: controller,
                          ringColor: widget.ringColor,
                          ringStroke: widget.ringStroke),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) {
                          return Text(getText(),
                              style: TextStyle(
                                      fontFeatures: [
                                    FontFeature.tabularFigures()
                                  ],
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              100)
                                  .merge(widget.timeStyle));
                        }),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void didUpdateWidget(CupertinoTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _animationValueListener() {
    if (widget.valueListener != null) {
      widget.valueListener(controller.duration * controller.value);
    }
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.forward) {
      running = true;
    } else if (status == AnimationStatus.dismissed) {
      running = false;
    }
  }

  String getText() {
    Duration duration = controller.duration * controller.value;

    duration =
        Duration(seconds: controller.duration.inSeconds - duration.inSeconds);

    if (duration.inHours > 0) {
      return "${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, "0")}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
    } else {
      return "${duration.inMinutes.toString().padLeft(2, "0")}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
    }
  }

  @override
  void dispose() {
    controller.stop();
    controller.removeStatusListener(_animationStatusListener);
    controller.dispose();
    super.dispose();
  }
}
