import 'package:get/get.dart';

class LectureInstaController extends GetxController {
  LectureInstaController get to => Get.find();

  @override
  void onInit() async{
    // 단 한번 페이지에 들어올 떄 실행하는 함수
    print('insta(init)');
    super.onInit();
  }
}
