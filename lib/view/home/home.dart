import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class Home extends GetView<HomeController> {
  static String route = '/home';

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Obx(() => Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
                color: Colors.white
            ),
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      controller.updateWeather();
                    },
                    title: Container(
                        alignment: Alignment.center,
                        child: Text('날씨')),
                    leading: Checkbox(value: controller.isWeather.value, onChanged: (bool? value) { controller.updateWeather(); },),
                  ),
                  ListTile(
                    onTap: (){
                      controller.updateDday();
                    },
                    title: Container(
                        alignment: Alignment.center,
                        child: Text('D-day')),
                    leading: Checkbox(value: controller.isDday.value, onChanged: (bool? value) { controller.updateDday(); },),
                  ),
                  ListTile(
                    onTap: (){
                      showDialog(context: context, builder: (context) {
                        return Container(
                          child: SfDateRangePicker(
                            backgroundColor: Colors.white,
                            selectionMode: DateRangePickerSelectionMode.single,
                            onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                              DateTime date =dateRangePickerSelectionChangedArgs.value;
                              controller.updateDdayTime(date);
                              Get.back();
                            },
                          ),
                        );
                      },);
                    },
                    title: Container(
                        alignment: Alignment.center,
                        child: Text('D-day 날짜 지정하기')),
                    leading: Icon(Icons.calendar_today),
                  ),
                  ListTile(
                    onTap: (){
                      exit(0);
                    },
                    title: Container(
                      alignment: Alignment.center,
                        child: Text('종료하기')),
                    leading: Icon(Icons.power_settings_new),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.network(
                  controller.backgroundUrl.value,
                  fit: BoxFit.cover,
                  width: Get.width,
                  height: Get.height,
                ),
              ),
              Visibility(
                visible: controller.isWeather.value,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                    height: 65,
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.network(
                            'https://openweathermap.org/img/wn/${controller.weather == null ? '01d' : controller.weather?.weatherIcon}@2x.png',
                            height: 60,
                            width: 60,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                                '습도\t${controller.weather?.humidity ?? 0}％',
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 0.9)),
                            AutoSizeText(
                                '풍량\t${controller.weather?.windSpeed?.round() ?? 0}㎧',
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 0.9)),
                            AutoSizeText(
                                '온도\t${controller.weather?.temperature?.celsius?.round() ?? 0}℃',
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 0.9))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: controller.isDday.value,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 30, 0),
                    height: 65,
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              alignment: Alignment.center,
                              height: 65,
                              width: 65,
                              child: Image.file(
                                controller.image.value,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    alignment: Alignment.center,
                                    color: Colors.grey,
                                    child: Icon(Icons.add),
                                  );
                                },
                              ),
                            ),
                          ),
                          onTap: () {
                            controller.setImage();
                          },
                        ),
                        AutoSizeText(
                            'D${controller.prefix.value}${controller.day.value}',
                            style: GoogleFonts.josefinSans(
                                color: Colors.white, fontSize: 60)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(controller.currentDate.value,
                        style: GoogleFonts.vinaSans(
                            color: Colors.white, fontSize: 40, height: 0.7)),
                    AutoSizeText(controller.currentTime.value,
                        style: GoogleFonts.vinaSans(
                            color: Colors.white, fontSize: 130, height: 0.7)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
