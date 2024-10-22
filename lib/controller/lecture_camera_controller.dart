import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as IMG;
import 'package:http/http.dart' as http;

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

  late int loadingChk = 0;//카메라 캡쳐 로딩

  //서버에서 가져오는 데이터 리스트
  late List<String> dataList;
  late int dataListCnt =0;

  @override
  void onInit() async{
    //딱 한번만 페이지 들어 올때 실행 합니다.
    initCamera();
    screenshotController = ScreenshotController();//화면 스크린 캡쳐 초기화
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
    loadingChk =1;
    List<Uint8List>? PictureImgList = <Uint8List>[];
    IMG.Image ? img = IMG.decodeImage(image);
    IMG.Image resized = IMG.copyResize(img!, width: widget_width, height: widget_height);
    image = IMG.encodeJpg(resized);

    print('widget_width : ${img.width}');
    print('widget_height : ${img.height}');

    PictureImgList.add(image);
    print('## clickPicture 종료 ##');

    httpMultipartCall(PictureImgList); //서버로 이미지를 보내서 체크 하도록 합니다. (아래 httpMultipartCall 메서드 로 옵니다)

  }

  /*서버 AI 체크 */
  String serverUrl = 'http://172.17.16.1:8081'; // 각자 로컬 IP
  String mapping = '/getAiData';
  Future<Map<String, dynamic>> ? httpMultipartCall(List<Uint8List> pictureImgList) async {
    print('## httpMultipartCall 시작 ##');
    late Map<String, dynamic> resultData ={};//반환 데이터

    String dbSelectUrl = serverUrl+mapping;
    try {
      var request = http.MultipartRequest("POST", Uri.parse(dbSelectUrl),);
      for (var i = 0; i < pictureImgList.length; i++) {
        request.files.add(await http.MultipartFile.fromBytes('test_${i + 1}', pictureImgList[i],filename: 'test_${i + 1}'),);
      }

      var response = await request.send();//위에 이미지 를 서버로 보낸다.

      if (response.statusCode == 200) {
        print('############ httpMultipartCall 서버데이터 호출 완료 #########');

        var responseSend = await http.Response.fromStream(response);
        resultData = jsonDecode(utf8.decode(responseSend.bodyBytes));
        //print('responseData resultList: ${resultData['resultList']}');
        String serverData = resultData['resultList'].toString().trim();

        print('serverData: ${serverData}');

        if(serverData.length > 2){
          serverData = serverData.substring(1,serverData.length-1);
          dataList = serverData.split('|,');
          print('dataList: ${dataList}');
          print('dataList length: ${dataList.length}');
          dataListCnt = dataList.length;
        }else{
          dataListCnt =0;
        }

        loadingChk =0;
        update();
      }
      print('## httpMultipartCall 종료 ##');
    } catch (e) {
      print('httpMultipartCall 서버 에러 : ${e}');
    }
    return resultData;
  }

  //서버 데이터 로 박스 만들기
  Widget predictorData(int i) {
    List<String> tempData = dataList[i].trim().split(',');

    print('tempData : ${tempData}');


    double x = double.parse(tempData[1]);
    double y = double.parse(tempData[2]);
    double w = double.parse(tempData[3]);
    double h = double.parse(tempData[4]);

    String predictorValue = tempData[5].substring(0,4);
    String classValue = tempData[0];
    String predictor = classValue +':'+predictorValue;//오브젝트 이름+확률

    return Positioned(
        top: y, //y
        left: x, //x
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.red,
                  )
              ),
            ),
            DefaultTextStyle(
              style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 20
              ),
              child: Text('${predictor}'),
            ),
          ],
        )
    );
  }

}
