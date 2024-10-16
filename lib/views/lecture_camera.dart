import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture/controller/lecture_camera_controller.dart';
import 'package:camera/camera.dart';

class LectureCamera extends GetView<LectureCameraController> {
  LectureCamera({super.key});

  @override
  Widget build(BuildContext context) {
    print('카메라 화면');
    return GetBuilder<LectureCameraController>(
        init: controller,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: (){
                      //다 만들고 이벤트 생성 할게요.
                    },
                    child: Icon(Icons.add_circle)
                )
              ],
              title: const Text('카메라 화면'),
              backgroundColor: const Color.fromRGBO(71, 200, 62, 0.1),
            ),
            body: controller.cameraInitChk == false
                ? const SizedBox.shrink()
                : Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(controller.camerasController),
                )
              ],
            ),
          );
        }
    );
  }
}