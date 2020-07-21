import 'package:flutter/material.dart';

class TimerController extends AnimationController {
  bool wasActive = false;

  TimerController(TickerProvider vsync) : super(vsync: vsync);

  void start() {
    wasActive = true;
    this.forward();
  }

  void pause() {
    wasActive = false;
    this.stop();
  }

  @override
  void reset() {
    wasActive = false;
    super.reset();
  }
}
