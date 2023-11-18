import 'dart:async';
import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/util/day_calculator.dart';

class HomeController extends GetxController {
  RxString prefix = ''.obs;
  RxList<int> day = RxList();
  late Timer timer;
  DayCalculator dayCalculator = DayCalculator(DateTime(2024, 2, 4));
  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 60);
  TextEditingController width = TextEditingController();
  TextEditingController height = TextEditingController();
  @override
  void onInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      prefix(dayCalculator.getPrefix());
      day(dayCalculator.getDay());
    });
    setDisplay();
    super.onInit();
  }

  setDisplay() async {
    await DesktopWindow.setFullScreen(true);
  }

  setDisplaySize() async {
    double widthSize = double.parse(width.text);
    double heightSize = double.parse(height.text);
    await DesktopWindow.setWindowSize(Size(widthSize, heightSize));
  }
}
