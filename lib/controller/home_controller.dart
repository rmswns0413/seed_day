import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:workspace/model/repository.dart';

import '../util/calculate_day.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Repository repository = Repository();
  RxString prefix = ''.obs;
  RxString backgroundUrl = ''.obs;
  RxInt digit = 0.obs;
  RxInt day = 0.obs;
  RxList<int> number = RxList();
  RxString currentTime = ''.obs;
  RxString currentDate = ''.obs;
  RxString theme = 'jesus'.obs;
  TextStyle textStyle =
      GoogleFonts.vinaSans(fontSize: 120, color: Colors.white);
  late Timer timer;
  CalculateDay calculateDay = CalculateDay(DateTime(2024, 2, 4));
  WeatherFactory wf = WeatherFactory('0d1d921ec4ff49e0f085bfb8a866b88f',
      language: Language.KOREAN);
  Weather? weather;

  Rx<File> image = Rx(File(''));
  RxBool isWeather = true.obs;
  RxBool isDday = true.obs;

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
    Timer.periodic(const Duration(minutes: 10), (timer) {
      setWeather();
    });

    setWidget();
    setWeather();
    setBackground();
  }

  Future<void> setWeather() async {
    weather = await wf.currentWeatherByCityName('ULSAN');
  }

  setBackground() async {
    backgroundUrl('https://source.unsplash.com/random/?${theme.value}');
  }

  setWidget() async {
    image(File(await repository.getPath()));
    isWeather(await repository.getWeather());
    isDday(await repository.getDday());
    calculateDay = CalculateDay(await repository.getDdayDateTime());
  }

  setImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      await repository.setPath(result.files.single.path!);
      image(File(result.files.single.path!));
    }
  }

  updateWeather() async {
    isWeather(!isWeather.value);
    await repository.setWeather(isWeather.value);
  }

  updateDday() async {
    isDday(!isDday.value);
    await repository.setDday(isDday.value);
  }

  updateDdayTime(DateTime date) async{
    calculateDay = CalculateDay(DateTime(date.year, date.month, date.day));
    await repository.setDdayDateTime(date);
  }
}
