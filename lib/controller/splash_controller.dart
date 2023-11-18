import 'package:get/get.dart';

import '../view/home/home.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
        const Duration(seconds: 2), () => Get.offAllNamed(Home.route));
    super.onInit();
  }
}
