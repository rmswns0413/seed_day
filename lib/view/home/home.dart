import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                  height: Get.height * 0.2,
                  width: Get.width * 0.18,
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
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 30, 0),
                  height: Get.height * 0.25,
                  width: Get.width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/seed.png',
                                fit: BoxFit.scaleDown),
                          ],
                        ),
                      ),
                      AutoSizeText(
                          'D${controller.prefix.value}${controller.day.value}',
                          style: GoogleFonts.josefinSans(
                              color: Colors.white, fontSize: 60)),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      exit(0);
                    },
                    icon: Icon(Icons.power_settings_new),
                    color: Colors.white),
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
