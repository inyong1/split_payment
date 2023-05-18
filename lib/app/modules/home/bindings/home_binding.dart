import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/split_popup_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
