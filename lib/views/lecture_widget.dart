import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture/controller/lecture_widget_controller.dart';

class LectureWidget extends GetView<LectureWidgetController> {
  LectureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('widget 화면');
    return GetBuilder<LectureWidgetController>(
        init: controller,
        builder: (_) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('widget'),
                backgroundColor: const Color.fromRGBO(67, 116, 217, 0.5),
                actions: [
                  TextButton(
                      onPressed: (){
                        print('카메라 이벤트');
                      },
                      child: const Icon(Icons.camera_alt)
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: const Text('Container 1 만들었습니다.'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: const Text('Container 2 만들었습니다.'),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child:
                      TextButton(onPressed: (){
                        print('값을 증가시키자');
                        controller.addCnt();
                      },
                        style:ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(const Color(0xff96B0E5))
                        ),
                        child: const Text('카운트 증가 시키자'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: Text('값 : ${controller.cnt}' ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Image.asset('assets/images/carrot_character.png'),
                        ),
                        Container(
                          width: 200,
                          child: Image.asset('assets/images/carrot_character.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 200,
                      child: Image.asset('assets/images/carrot_character.png'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 200,
                      child: Image.asset('assets/images/carrot_character.png'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 200,
                      child: Image.asset('assets/images/carrot_character.png'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 200,
                      child: Image.asset('assets/images/carrot_character.png'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 400,
                      child: controller.cameraInitChk == true
                          ? CameraPreview(controller.camerasController)
                          : SizedBox.shrink(),
                    )
                  ],
                ),
              )

          );
        }
    );
  }
}