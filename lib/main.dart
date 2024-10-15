import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture/common/routes.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {

  //초기화 보장
  WidgetsFlutterBinding.ensureInitialized();

  //카메라 권한 받기 시작
  var cameraStatus = await Permission.camera.status;
  print("cameraStatus: ${cameraStatus}");
  if (cameraStatus.isDenied) {
    if(await Permission.camera.request().isDenied){
      print("카메라 권한 거부됨");
    }else{
      print("카메라 권한 활성화 됨");
    }
  }
  //카메라 권한 받기 종료

  runApp(const LectureApp());

}

class LectureApp extends StatelessWidget {
  const LectureApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'AI 강의',
      debugShowCheckedModeBanner: false,
      initialRoute: '/main',
      getPages:Routes.appRoutes(),
    );
  }
}