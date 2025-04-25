import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
class MyNavigatorObserver extends NavigatorObserver {

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    print('页面进入: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    print('页面退出: ${route.settings.name}');
    print('上一个页面:${previousRoute?.settings.name}');
    if(route.settings.name =='/skudetail'){
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.light
          )
      );
    }
    else if(route.settings.name =='/loginpage'){
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.black,
              systemNavigationBarIconBrightness: Brightness.light
          )
      );
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    // TODO: implement didRemove
    super.didRemove(route, previousRoute);
  }
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print('移除旧页面：${oldRoute?.settings.name},页面进入: ${newRoute?.settings.name }');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

}
