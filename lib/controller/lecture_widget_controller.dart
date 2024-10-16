import 'package:get/get.dart';

class LectureWidgetController extends GetxController {
  LectureWidgetController get to => Get.find();

 @override
  void onInit() async{
   // 단 한번 페이지에 들어올 떄 실행하는 함수
   print('widget(init)');
    super.onInit();
  }

}
