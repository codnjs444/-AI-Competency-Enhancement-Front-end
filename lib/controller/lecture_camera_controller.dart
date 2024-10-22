import 'dart:typed_data';
import 'dart:convert';
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
late int loadingChk = 0;
late int widget_height = 0;//위젯 높이
late int widget_width = 0;//위젯 넓이

//서버에서 가져오는 데이터 리스트
late List<String> dataList;
late int dataListCnt;

@override
void onInit() async {
initCamera();
//페이지 진입시 한번만 실행
screenshotController = ScreenshotController();
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

List<Uint8List>? PictureImgList = <Uint8List>[];
IMG.Image ? img = IMG.decodeImage(image);
IMG.Image resized = IMG.copyResize(img!, width: widget_width, height: widget_height);
image = IMG.encodeJpg(resized);

print('widget_width : ${widget_width}');
print('widget_height : ${widget_height}');

PictureImgList.add(image);
print('## clickPicture 종료 ##');

httpMultipartCall(PictureImgList); //서버로 이미지를 보내서 체크 하도록 합니다. (아래 httpMultipartCall 메서드 로 옵니다)

}

/*서버 AI 체크 */
  String serverUrl = 'http://172.17.16.1:8081';//각자 로컬 IP
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

print('responseData resultList: ${resultData['resultList']}');

String serverData = resultData['resultList'].toString().trim();

String list = resultData['list'].toString().trim();
String pk = resultData['pk'].toString().trim();
String cm = resultData['cm'].toString().trim();




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

}
