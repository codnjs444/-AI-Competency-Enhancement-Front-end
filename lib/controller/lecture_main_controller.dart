import 'package:get/get.dart';
import 'package:camera/camera.dart';

class LectureMainController extends GetxController {
  LectureMainController get to => Get.find();

  late List<CameraDescription> cameras;
  late CameraController camerasController;
  bool cameraInitChk = false; //카메라 초기화 체크

 @override
  void onInit() async{
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

}
