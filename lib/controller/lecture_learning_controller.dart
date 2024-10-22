import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as IMG;

class LectureLearningController extends GetxController {
  LectureLearningController get to => Get.find();

  late int loadingChk = 0;//카메라 캡쳐 로딩
  late int dataListCnt = 0;
  late List<String> dataList;

  late int widget_height = 0;//위젯 높이
  late int widget_width = 0;//위젯 넓이

  //스크린 샷
  late ScreenshotController screenshotController;

  late List<CameraDescription> cameras;
  late CameraController camerasController;
  bool cameraInitChk = false; //카메라 초기화 체크

  late Future<void> initializeControllerFuture;

  @override
  void onInit() async{
    print('LectureLearningController Init');
    initState();
    screenshotController = ScreenshotController();
    super.onInit();
  }

  Future<void> initState() async {
    cameras = await availableCameras();

    camerasController = CameraController(cameras[0], ResolutionPreset.max, enableAudio : false) ;
    //카메라 초기화
    camerasController.initialize().then((_) {
      cameraInitChk = true;
      update();
    });
  }


  Future<void> clickPicture(Uint8List image) async {
    print('## clickPicture 시작 ##');
    List<Uint8List>? PictureImgList = <Uint8List>[];
    IMG.Image ? img = IMG.decodeImage(image);
    IMG.Image resized = IMG.copyResize(img!, width: widget_width, height: widget_height);
    image = IMG.encodeJpg(resized);

    PictureImgList.add(image);
    print('## clickPicture 종료 ##');
    httpMultipartCall(PictureImgList);
  }

  /*서버 AI 체크 */
  String serverUrl = 'http://192.168.20.34:8081';//각자 로컬 IP
  String mapping = '/serverAiChk';
  Future<Map<String, dynamic>> ? httpMultipartCall(List<Uint8List> pictureImgList) async {
    print('## httpMultipartCall 시작 ##');
    late Map<String, dynamic> resultData ={};//반환 데이터

    String dbSelectUrl = serverUrl+mapping;
    try {
      var request = http.MultipartRequest("POST", Uri.parse(dbSelectUrl),);
      for (var i = 0; i < pictureImgList.length; i++) {
        request.files.add(await http.MultipartFile.fromBytes('test_${i + 1}', pictureImgList[i],filename: 'test_${i + 1}'),);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        print('############ httpMultipartCall 서버데이터 호출 완료 #########');

        var responseSend = await http.Response.fromStream(response);
        resultData = jsonDecode(utf8.decode(responseSend.bodyBytes));

        print('responseData resultList: ${resultData['resultList']}');

        String serverData = resultData['resultList'].toString().trim();

        if(serverData.length > 2){
          serverData = serverData.substring(1,serverData.length-1);
          dataList = serverData.split(',');
          print('dataList: ${dataList.length}');
          dataListCnt = dataList.length;
        }else{
          dataListCnt =0;
        }
        loadingChk = 2;
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
    List<String> tempData = dataList[i].trim().split('|');

    double x = double.parse(tempData[0]);
    double y = double.parse(tempData[1]);
    double w = double.parse(tempData[2]);
    double h = double.parse(tempData[3]);

    String predictorValue = tempData[4].substring(0,4);
    String classValue = tempData[5];
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
