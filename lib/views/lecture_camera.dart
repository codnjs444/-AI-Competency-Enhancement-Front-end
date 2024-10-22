import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture/controller/lecture_camera_controller.dart';
import 'package:camera/camera.dart';
import 'package:screenshot/screenshot.dart';
import 'package:widget_size/widget_size.dart';

class LectureCamera extends GetView<LectureCameraController> {
  LectureCamera({super.key});

  @override
  Widget build(BuildContext context) {
    print('카메라 화면');
    return GetBuilder<LectureCameraController>(
        init: controller,
        builder: (_) {
          return Stack(
              children: [
                WidgetSize(onChange: (Size size){
                  int temp_height = size.height.round();
                  int temp_width = size.width.round();
                  //화면 사이즈 전달
                  controller.widget_height = temp_height;
                  controller.widget_width = temp_width;
                },
                    child:
                    Screenshot(
                        controller : controller.screenshotController,
                        child : Scaffold(
                          appBar: AppBar(
                            title: const Text('강의 학습 로드'),
                          ),
                          body: controller.cameraInitChk == false ?
                          const SizedBox.shrink()
                              :Stack(
                            children: [
                              Form(
                                  canPop: false,
                                  onPopInvokedWithResult: (bool didPop, Object? result){
                                    if(!didPop){
                                      controller.camerasController.dispose();
                                      Get.back();
                                      return;
                                    }
                                  },
                                  child: const SizedBox.shrink()
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: CameraPreview(controller.camerasController),
                              )
                            ],
                          ),
                          floatingActionButton: FloatingActionButton(
                            onPressed: ()  {
                              controller.loadingChk = 1;
                              controller.update();

                              controller.screenshotController.capture().then((Uint8List ? capturedImage) {
                                if(capturedImage != null){
                                  controller.clickPicture(capturedImage);
                                }
                              });
                            },
                            child: const Text('Click'),
                          ),
                        )
                    )
                ),

                //AI Picture BOX
                for(int i =0 ; i < controller.dataListCnt; i++)
                  controller.predictorData(i)
                ,
                //loading bar center
                controller.loadingChk == 1 ? const Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffd3d3d3))),
                ) : const SizedBox.shrink()
              ]
          );
        }
    );
  }
}