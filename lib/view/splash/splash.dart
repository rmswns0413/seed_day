import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}



class Splash extends GetView<SplashController> {
  static const route = '/splash';
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo.png', scale: 2.4,),
      ),
    );
  }
}
