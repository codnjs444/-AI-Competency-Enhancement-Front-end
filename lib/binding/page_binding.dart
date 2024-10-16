import 'package:get/get.dart';
import 'package:lecture/controller/lecture_camera_controller.dart';
import 'package:lecture/controller/lecture_insta_controller.dart';
import 'package:lecture/controller/lecture_main_controller.dart';
import 'package:lecture/controller/lecture_widget_controller.dart';

class PageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LectureMainController>(() => LectureMainController());
    Get.lazyPut<LectureWidgetController>(() => LectureWidgetController());
    Get.lazyPut<LectureCameraController>(() => LectureCameraController());
    Get.lazyPut<LectureInstaController>(() => LectureInstaController());
  }
}