import 'package:get/get.dart';

class PageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LectureMainController>(() => LectureMainController());
  }
}