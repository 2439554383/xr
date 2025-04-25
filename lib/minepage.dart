import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SharedPreferences.dart';
import 'package:http/http.dart' as http;

class minepage extends StatefulWidget {
  const minepage({super.key});

  @override
  State<minepage> createState() => _minepageState();
}

class _minepageState extends State<minepage> with SingleTickerProviderStateMixin{
  int current_index = 0;
  TabController? tabbar_controller;
  var user_information = {};
  final savainfomation _savainfomation = savainfomation();
  var iamge_list = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _savainfomation.get_user_information().then((value){
                setState(() {
                  user_information = json.decode(value);
                });
    });
    tabbar_controller = TabController(length: 4, vsync: this,initialIndex: current_index);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark
          )
      );
    });
    if(user_information.isEmpty){
      return Stack(
        children: [
          Center(child: CircularProgressIndicator(),),
          Positioned(top:MediaQuery.of(context).padding.top,right:15,child: IconButton(onPressed: (){_savainfomation.set_login(false);Navigator.pushNamed(context, '/mainpage');}, icon: Icon(Icons.exit_to_app,size: 35,color: Colors.grey,)))
        ],
      );
    }
    else{
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.27,
                child: Stack(
                  children: [
                    Image.asset(user_information['background_image_url'],height: MediaQuery.of(context).size.height*0.3,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                    Positioned(height: 100,width: MediaQuery.of(context).size.width,bottom: 15,left: 15,child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage(user_information['useravatar']),fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(user_information['username'],style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),),
                            SizedBox(height: 5,),
                            Text('id：${user_information['user_appid']}',style: TextStyle(color: Color.fromARGB(
                                202, 84, 84, 84),fontWeight: FontWeight.w500),)
                          ],
                        ))
                      ],
                    )),
                    Positioned(top: MediaQuery.of(context).padding.top,right:10,child: IconButton(icon:Icon(Icons.exit_to_app,size: 35,color: Colors.grey[800],) ,onPressed: () { _savainfomation.set_login(false);Navigator.pushNamed(context,'/mainpage'); },))

                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(user_information['like_count'].toString(),style: TextStyle(fontSize: 20),),
                        Text("获赞")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(user_information['followers_count'].toString(),style: TextStyle(fontSize: 20),),
                        Text("关注")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(user_information['fans_count'].toString(),style: TextStyle(fontSize: 20),),
                        Text('粉丝')
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 250,child: Text(user_information['introduce'],maxLines: 3,)),
                      SizedBox(height: 3,),
                      Container(
                        width: 200,
                        height: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.male,color: Colors.blue,size: 13,),
                                SizedBox(width: 2,),
                                Text(user_information['usersex'])
                              ],
                            ),
                            SizedBox(width: 5,),
                            Text(user_information['useraddress']),
                            SizedBox(width: 5,),
                            Text(user_information['userschool'])
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                child:TabBar(
                  tabs: [
                    Text('作品'),
                    Text('喜欢'),
                    Text('收藏'),
                    Text('推荐'),
                  ],
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(fontSize: 19),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  dividerColor:Colors.transparent,
                  unselectedLabelColor: Colors.grey[600],
                  controller: tabbar_controller,
                ),
              ),
              Container(
                height: 500,
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: iamge_list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio:3/4,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1
                    ),
                    itemBuilder: (context,index){
                      return Image.asset(iamge_list[index],fit: BoxFit.cover,);
                    }),
              )
            ],
          ),
        ),
      );
    }
  }
}
