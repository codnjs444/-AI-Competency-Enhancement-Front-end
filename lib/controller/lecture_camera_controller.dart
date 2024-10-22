import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as IMG;

class LectureCameraController extends GetxController {
  LectureCameraController get to => Get.find();

  late List<CameraDescription> cameras;
  late CameraController camerasController;
  bool cameraInitChk = false; //카메라 초기화 체크

  //스크린 샷
  late ScreenshotController screenshotController;
  //이미지 높이와 넓이
  late int widget_height = 0;//위젯 높이
  late int widget_width = 0;//위젯 넓이

  @override
  void onInit() async{
    //딱 한번만 페이지 들어 올때 실행 합니다.
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

  //화면 캡쳐
  Future<void> clickPicture(Uint8List image) async {
    print('## clickPicture 시작 ##');

    List<Uint8List>? PictureImgList = <Uint8List>[];
    IMG.Image ? img = IMG.decodeImage(image);
    IMG.Image resized = IMG.copyResize(img!, width: widget_width, height: widget_height);
    image = IMG.encodeJpg(resized);

    print('widget_width : ${widget_width}');
    print('widget_height : ${widget_height}');

    PictureImgList.add(image);
    print('## clickPicture 종료 ##');

    //httpMultipartCall(PictureImgList); //서버로 이미지를 보내서 체크 하도록 합니다. (아래 httpMultipartCall 메서드 로 옵니다)

  }

}
