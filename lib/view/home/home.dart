import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class Home extends GetView<HomeController> {
  static const route = '/home';

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Welcome !!!',
                      style: TextStyle(color: Colors.grey, fontSize: 60),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/seed.png'))),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text('D', style: controller.textStyle)),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(controller.prefix.value,
                                style: controller.textStyle)),
                        for (int i = 0; i < controller.day.length; i++)
                          Expanded(
                            flex: 1,
                            child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text('${controller.day[i]}',
                                    style: controller.textStyle)),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
