import 'dart:convert';
import 'dart:ffi';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok1/SharedPreferences.dart';
import 'package:tiktok1/storepage.dart';
import 'friendpage.dart';
import 'homegae.dart';
import 'loginpage.dart';
import 'minepage.dart';
import 'SharedPreferences.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class mainpage extends StatefulWidget {
  const mainpage({super.key});

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> with RouteAware{
  final savainfomation _savainfomation = savainfomation();
  var current_index = 0;
  bool islogin = false;
  var user_phonenumber ='';
  bool ispopbutton = false;
  bool islive = false;
  var user_information= {};
  var widget_login_list = [
    homepage(),
    friendpage(),
    homepage(),
    storepage(),
    minepage()
  ];
  var widget_list = [
    homepage(),
  ];
  var theme_list = [
    ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.dark(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.white,
        onSecondary: Colors.white
      ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        )
    ),
    ThemeData.light(useMaterial3: true,).copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          background: Colors.white,
          surface: Colors.white
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        )
    ),
    ThemeData.light(useMaterial3: true,).copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
            background: Colors.white,
            surface: Colors.white
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        )
    ),
    ThemeData.light(useMaterial3: true,).copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
            background: Colors.white,
            surface: Colors.white
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        )
    ),
    ThemeData.light(useMaterial3: true,).copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
            background: Colors.white,
            surface: Colors.white
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
        )
    ),
  ];
  var brightness_list = [
    Brightness.light,
    Brightness.dark,
    Brightness.dark,
    Brightness.light,
    Brightness.dark
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _savainfomation.get_login().then((value) {
      setState(() {
        islogin = value;
      });
    });
    _savainfomation.get_user_information().then((value) {
      setState(() {
        user_information = json.decode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme_list[current_index],
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value){
              if(!islogin &&value!=0){
                Navigator.pushNamed(context, '/loginpage',arguments: value);
              }
              else if(islogin && value == 2){
                showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return
                        StatefulBuilder(
                          builder: (context,setmodelstate){
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height*0.3,
                                  child: GridView(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4),
                                    children: [
                                      TextButton(
                                          onPressed: (){
                                            setmodelstate((){
                                              ispopbutton = false;
                                            });
                                          },
                                          child: Text("短视频",style: TextStyle(color: Colors.black,fontSize: 20),)
                                      ),
                                      TextButton(
                                          onPressed: (){
                                            setmodelstate((){
                                              ispopbutton = true;
                                            });
                                          },
                                          child: Text("直播",style: TextStyle(color: Colors.black,fontSize: 20),)
                                      ),
                                      TextButton(
                                          onPressed: (){
                                            setmodelstate((){
                                              ispopbutton = false;
                                            });
                                          },
                                          child: Text("图文",style: TextStyle(color: Colors.black,fontSize: 20),)
                                      ),
                                    ],
                                  ),
                                ),
                                ispopbutton?Positioned(bottom:15,child: TextButton(
                                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xff6200ee))),
                                    onPressed: (){
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>LiveStreamingPage(liveID: user_information['liveid'], isHost: true, user_id: '${user_information['id']}', user_name: user_information['username'],)));
                                      });
                                    },
                                    child: Text('开启直播'))):SizedBox.shrink()
                              ],
                            );
                          },

                        );


                    }
                );
              }
              else{
                setState(() {
                  current_index = value;
                });
              }
            },
            iconSize: 30,
            currentIndex: current_index,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt),
                  label: 'friend'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'add'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.store),
                  label: 'store'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle_outlined),
                  label: 'mine'
              ),
            ]
        ),
        body: islogin?widget_login_list[current_index]:widget_list[current_index],

      ),
    );
  }
}
class LiveStreamingPage extends StatefulWidget {
  final String liveID;
  final String user_id;
  final String user_name;
  final bool isHost;
  const LiveStreamingPage({Key? key, required this.liveID, required this.isHost,required this.user_id,required this.user_name }) : super(key: key);

  @override
  State<LiveStreamingPage> createState() => _LiveStreamingPageState();
}

class _LiveStreamingPageState extends State<LiveStreamingPage> {
  postlive(bool islive ) async{
    final url = Uri.parse('http://124.70.183.83:8002/stock/post_live/');
    final response = await http.post(
        url ,
        headers: {'Content-Type':'application/json'},
        body: json.encode({
          'user_id':widget.user_id,
          'islive':islive
        })
    );
    if(response.statusCode ==200){
      print('开播成功');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('开播');
  }
  @override
  Widget build(BuildContext context) {
    // return Center(child: Text("data"),);
    return ZegoUIKitPrebuiltLiveStreaming(
      appID: 1127486329,
      appSign: '75c3e9462b4264c8b555497507a0262f279c5d7146f21c8122b63c52add8a8ac',
      userID: widget.user_id,
      userName: widget.user_name,
      liveID: widget.liveID,
      events:ZegoUIKitPrebuiltLiveStreamingEvents(
          onStateUpdated: (state){
                if(state== ZegoLiveStreamingState.living && widget.isHost == true){
                  print("接受回调，开播中");
                  postlive(true);
                }
                else if(state== ZegoLiveStreamingState.ended && widget.isHost == true){
                  print("接受回调，关播中");
                  postlive(false);
                }
          }
      ),
      config: widget.isHost
          ? ZegoUIKitPrebuiltLiveStreamingConfig.host(
              plugins: [ZegoUIKitSignalingPlugin()],
      )
          : ZegoUIKitPrebuiltLiveStreamingConfig.audience(
        plugins: [ZegoUIKitSignalingPlugin()],
      ),
    );
  }
}