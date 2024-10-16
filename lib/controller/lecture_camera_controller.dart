import 'package:camera/camera.dart';
import 'package:get/get.dart';

class LectureCameraController extends GetxController {
  LectureCameraController get to => Get.find();

  late List<CameraDescription> cameras;
  late CameraController camerasController;
  bool cameraInitChk = false; //카메라 초기화 체크

  @override
  void onInit() async{
    //딱 한번만 페이지 들어 올때 실행 합니다.
    print('카메라 화면 출력');
    initCamera();
    super.onInit();
  }

  //카메라 초기화
  Future<void> initCamera() async {
    cameras = await availableCameras(); //기다려줘 카메라 가져올때까지
    camerasController = CameraController(cameras[0], ResolutionPreset.max, enableAudio : false) ;
    //카메라 초기화
    camerasController.initialize().then((_) {// 카메라 사용 가능 상태로 왔 습니다.
      cameraInitChk = true;
      update();//화면에 값을 전달
    });
  }


}
