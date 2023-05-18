import 'package:get/get.dart';

import '../controllers/new_page_controller.dart';

class NewPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPageController>(
      () => NewPageController(),
    );
  }
}
