import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture/binding/page_binding.dart';
import 'package:lecture/views/lecture_main.dart';
import 'package:lecture/views/lecture_widget.dart';

class Routes extends GetMiddleware {

  @override
  GetPage? onPageCalled(GetPage? page) {
    print('onPageCalled : ${page?.name}');
    return super.onPageCalled(page);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    print('onBindingsStart :${bindings}');
    return super.onBindingsStart(bindings);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page)  {
    print('onPageBuildStart : ${page}');
    return super.onPageBuildStart(page);
  }

  @override
  void onPageDispose() async{
    super.onPageDispose();
  }

  @override
  RouteSettings? redirect(String? route) {
    print('----redirect');
    //페이지 넘어가기 전에 로그인페이지나 중간에 타야 하는곳 여기에 추가
    if(1 == 1){//
      print('----RouteSettings ');
      //return RouteSettings(name:'/styleTest');
    }
    return null;
  }

  /*화면 이동시 라우터 사용*/
  static List<GetPage<dynamic>> appRoutes() => [
    GetPage(
      name: '/main',
      page: () => LectureMain(),
      binding: PageBinding(),
      middlewares: [Routes()],
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: '/lecture_widget',
      page: () => LectureWidget(),
      binding: PageBinding(),
      middlewares: [Routes()],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    )
  ];
}

