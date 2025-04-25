
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tiktok1/homegae.dart';
import 'package:tiktok1/loginpage.dart';
import 'package:tiktok1/skudetail.dart';
import 'MyNavigatorObserver.dart';
import 'mainpage.dart';
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light
      )
  );
  runApp(
    OKToast(
      child: MaterialApp(
          routes: {
            '/homepage': (context) => homepage(),
            '/loginpage':(context) => loginpage(),
            '/mainpage':(context) => mainpage(),
            '/skudetail':(context) => skudetail()
          },
          navigatorObservers: [MyNavigatorObserver()],
        theme: ThemeData.light(
          useMaterial3: true,
        ).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.white
          ),
          scaffoldBackgroundColor: Colors.white
        ),
        home:startimage()),
    ),

  );
}

class startimage extends StatefulWidget {
  const startimage({super.key});

  @override
  State<startimage> createState() => _startimageState();
}

class _startimageState extends State<startimage> with RouteAware{
  @override
  void initState() {

    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, '/mainpage');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light
        )
    );
    return Center(
        child: Image.asset('assets/images/tiktok.png',width: 150,height: 150,),
    );
  }
}
