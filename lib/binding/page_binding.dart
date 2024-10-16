import 'package:get/get.dart';
import 'package:lecture/controller/lecture_main_controller.dart';
import 'package:lecture/controller/lecture_widget_controller.dart';

class PageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LectureMainController>(() => LectureMainController());
    Get.lazyPut<LectureWidgetController>(() => LectureWidgetController());

  }
}