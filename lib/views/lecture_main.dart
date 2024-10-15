import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture/controller/lecture_main_controller.dart';

class LectureMain extends GetView<LectureMainController> {
  LectureMain({super.key});

  @override
  Widget build(BuildContext context) {
    print('Main 화면');
    return GetBuilder<LectureMainController>(
      init: controller,
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            child:const Text('메인'),
            ),
        );
      }
    );
  }
}