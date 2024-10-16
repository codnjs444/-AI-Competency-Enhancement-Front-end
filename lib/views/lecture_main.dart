import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture/controller/lecture_main_controller.dart';

class LectureMain extends GetView<LectureMainController> {
  LectureMain({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LectureMainController>(
      init: controller,
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0, // 그림자 제거
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.orangeAccent), // 주황색 아이콘
              onPressed: () {
                // 뒤로 가기 동작
              },
            ),
            title: const Text(
              '당근 마켓 스타일',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            centerTitle: true,
          ),
          backgroundColor: const Color(0xfff2f2f2), // 당근 마켓 스타일의 배경색
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // 상단에 당근 캐릭터 이미지
                Image.asset(
                  'assets/images/carrot_character.png', // 당근 마켓 캐릭터 이미지
                  width: 150,
                  height: 150,
                ),

                const SizedBox(height: 20), // 간격 추가

                // '당근 AI 솔루션' 텍스트
                const Text(
                  '당근 AI 솔루션',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 40), // 텍스트와 버튼 간격 추가

                // Widget 버튼
                SizedBox(
                  width: double.infinity, // 버튼을 화면 전체 너비로 설정
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/lecture_widget');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent, // 당근 마켓 주황색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0, // 당근 마켓처럼 평평한 버튼
                    ),
                    child: const Text(
                      'Widget',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20), // 버튼 간격 추가

                // 인스타 버튼
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // 인스타 버튼 클릭 이벤트
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      '인스타',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 40), // 하단 간격

                // 하단에 당근 로고 이미지
                Image.asset(
                  'assets/images/carrot_logo.png', // 당근 마켓 로고 이미지
                  width: 80,
                  height: 80,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
