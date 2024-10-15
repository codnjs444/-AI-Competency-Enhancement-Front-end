import 'package:get/get.dart';
import 'package:lecture/controller/lecture_main_controller.dart';

class PageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LectureMainController>(() => LectureMainController());
  }
}