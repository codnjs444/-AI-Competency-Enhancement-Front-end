import 'package:get/get.dart';
import 'package:camera/camera.dart';

class LectureWidgetController extends GetxController {
  LectureWidgetController get to => Get.find();

  int cnt = 0;

  late List<CameraDescription> cameras;
  late CameraController camerasController;
  bool cameraInitChk = false; //카메라 초기화 체크

 @override
  void onInit() async{
   // 단 한번 페이지에 들어올 떄 실행하는 함수
   print('*******************************************');
   print('widget(init)');
   cnt = 0;

   // initCamera();

   super.onInit();
  }

  // //카메라 초기화
  // Future<void> initCamera() async {
  //   cameras = await availableCameras(); //기다려줘 카메라 가져올때까지
  //   camerasController = CameraController(cameras[0], ResolutionPreset.max, enableAudio : false) ;
  //   //카메라 초기화
  //   camerasController.initialize().then((_) {// 카메라 사용 가능 상태로 왔 습니다.
  //     cameraInitChk = true;
  //     update();//화면에 값을 전달
  //   });
  // }

  void addCnt(){
    cnt ++;
    print('addCnt 실행');
    update();
  }

}
