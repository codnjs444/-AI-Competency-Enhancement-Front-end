import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture/controller/lecture_camera_controller.dart';
import 'package:camera/camera.dart';

class LectureCamera extends GetView<LectureCameraController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LectureCameraController>(
        init: controller,
        builder: (_) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.lightBlue[100],
                actions: [
                  TextButton(

                      onPressed: (){
                        Get.toNamed('/lecture_camera');
                      },
                      child: const Icon(Icons.camera_alt_outlined, color : Colors.black54)
                  )
                ],
              ),
              body: controller.cameraInitChk == false ?
              const SizedBox.shrink()
                  : Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(controller.camerasController),
                    )
                  ]
              )

          );
        }
    );
  }
}