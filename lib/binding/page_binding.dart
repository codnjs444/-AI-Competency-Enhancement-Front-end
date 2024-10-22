import 'package:get/get.dart';
import 'package:lecture/controller/lecture_insta_controller.dart';
import 'package:lecture/controller/lecture_main_controller.dart';
import 'package:lecture/controller/lecture_widget_controller.dart';
import 'package:lecture/controller/lecture_camera_controller.dart';

class PageBinding implements Bindings {
  @override
  void dependencies() {
    //put : 페이지가 넘어감과 동시에 인스턴스 자동 생성, binding 을 통해 라우트 단계에서 인스턴스를 전달
    //lazyPut : 사용할 때 인스턴스를 생성
    Get.lazyPut<LectureMainController>(() => LectureMainController());
    Get.lazyPut<LectureWidgetController>(() => LectureWidgetController());
    Get.lazyPut<LectureCameraController>(() => LectureCameraController());
    Get.lazyPut<LectureInstaController>(() => LectureInstaController());
  }
}