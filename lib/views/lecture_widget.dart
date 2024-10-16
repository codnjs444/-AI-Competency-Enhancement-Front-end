import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture/controller/lecture_main_controller.dart';
import 'package:lecture/controller/lecture_widget_controller.dart';

class LectureWidget extends GetView<LectureWidgetController> {
  LectureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('위젯 화면');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blueGrey,
      extendBodyBehindAppBar: true, // body 위에 Appbar 올리기
      body: Center(  // 전체 컨텐츠를 중앙으로 배치하기 위해 Center로 감쌈
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로로 중앙 배치
          crossAxisAlignment: CrossAxisAlignment.center, // 가로로 중앙 배치
          children: [
            Container(
              child: const Text('Container 1 만들었습니다.'),
            ),
            const SizedBox(height: 20), // 크기 조정
            Container(
              child: const Text('Container 2 만들었습니다.'),
            ),
            const SizedBox(height: 20), // 크기 조정
            SizedBox(
              child: TextButton(
                onPressed: () {
                  // 여기에 클릭 이벤트 로직 추가 가능
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff96B0E5), // 버튼 배경 색상 적용
                  ),
                ),
                child: const Text('카운트 증가 시키자'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '값: 0', // 기본값 0으로 표시
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
