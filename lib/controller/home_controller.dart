import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

import '../util/calculate_day.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxString prefix = ''.obs;
  RxString backgroundUrl = ''.obs;
  RxInt digit = 0.obs;
  RxInt day = 0.obs;
  RxList<int> number = RxList();
  RxString currentTime = ''.obs;
  RxString currentDate = ''.obs;
  RxString theme = ''.obs;
  TextStyle textStyle =
  GoogleFonts.vinaSans(fontSize: 120, color: Colors.white);
  late Timer timer;
  CalculateDay calculateDay = CalculateDay(DateTime(2024, 2, 4));
  WeatherFactory wf = WeatherFactory('0d1d921ec4ff49e0f085bfb8a866b88f',
      language: Language.KOREAN);
  Weather? weather;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      prefix(calculateDay.isBorn() ? '+' : '-');
      digit(calculateDay.getDigit());
      number(calculateDay.getDigitNumber());
      day(calculateDay.getDay());
      currentTime(calculateDay.getCurrentTime());
      currentDate(calculateDay.getCurrentDate());
    });
    Timer.periodic(Duration(seconds: 10), (timer) {
      setWeather();
    });
    setBackground();
  }

  Future<void> setWeather() async {
    weather = await wf.currentWeatherByCityName('ULSAN');
  }
  setBackground() async {
    theme(theme.value == 'nature'?'universe':'nature');
    backgroundUrl('https://source.unsplash.com/random/?${theme.value}');
  }
}

