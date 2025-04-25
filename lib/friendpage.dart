import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:tiktok1/SharedPreferences.dart';
import 'package:tiktok1/mainpage.dart';
import 'package:shimmer/shimmer.dart';
class friendpage extends StatefulWidget {
  const friendpage({super.key});

  @override
  State<friendpage> createState() => _friendpageState();
}

class _friendpageState extends State<friendpage> {
  final savainfomation _savainformation = savainfomation();
  var my_id = 0;
  var user_information_list = [] ;
  var user_information = {} ;
  bool islive = false;
  get_friends(int my_id) async{
    final url = Uri.parse('http://124.70.183.83:8002/stock/get_friends/');
    final response = await http.post(
      url,
      headers: {'Content-Type':'applicatin/json'},
      body: json.encode({
        'my_id':my_id
      })
    );
    print(response.statusCode);
    if(response.statusCode ==200){
        final data = json.decode(response.body);
        setState(() {
          print(data['data']);
          user_information_list = data['data'];
        });
    }
  }
  @override
  void initState() {
    _savainformation.get_user_information().then((value){
      setState(() {
        user_information = json.decode(value);
        my_id = user_information['id'];
      });
      get_friends(my_id);
    });
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("friends"),
        centerTitle: true,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outline,size: 35,)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.search,size: 35,))
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          for (var item in user_information_list)
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>user_chat(username: item['username'], avatar: item['useravatar'], user_id: item['id'], my_id: my_id, my_avatar: user_information['useravatar'],)));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15,left: 8),
              child: Row(
                children: [
                  ClipOval(
                    child:item['islive']==1?GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>LiveStreamingPage(liveID: item['liveid'], isHost: false, user_id:'${user_information['id']}', user_name: user_information['username'],)));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 发光边框层
                          Shimmer(
                            gradient: LinearGradient(
                              tileMode:TileMode.clamp,
                              colors: [
                                Colors.pink.withOpacity(0.8),
                                Colors.red.withOpacity(0.8),
                                Colors.orange.withOpacity(0.3),
                                Colors.pink.withOpacity(0.8),
                                Colors.red.withOpacity(0.8),

                              ],
                              stops: const [0.0,0.3,0.5,0.8,1],
                            ),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.red, width: 2.5),
                              ),
                            ),
                          ),
                          // 头像层
                          ClipOval(
                            child: Image.asset(
                              item['useravatar'],
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                    ):Image.asset(item['useravatar'],width: 75,height: 75,fit:BoxFit.cover ,)
                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      Text(item['username']),
                      SizedBox(height: 5,),
                      item['new']!=null?Text(item['new']):SizedBox.shrink()
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class user_chat extends StatefulWidget {
  final username ;
  final user_id;
  final avatar;
  final my_avatar;
  final my_id ;
  const user_chat({super.key ,required this.username,required this.avatar,required this.my_avatar,required this.user_id,required this.my_id});

  @override
  State<user_chat> createState() => _user_chatState();
}

class _user_chatState extends State<user_chat> {
  final savainfomation _savainfomation  = savainfomation();
  var issend = false;
  var new_message;
  var date;
  var send_list = [];
  var accept_list = [];
  var user_id = 0;
  final TextEditingController _controller = TextEditingController();
  postmessage(String new_message, int user_id, int my_id) async{
    final url = Uri.parse('http://124.70.183.83:8002/stock/post_message/');
    final response = await http.post(
        url ,
        headers: {'Content-Type':'application/json'},
        body: json.encode(
            {
              'description':new_message,
              'accept_user_id':user_id,
              'send_user_id':my_id,
              'sent_time': DateTime.now().toIso8601String()
            }
        )
    );
    if(response.statusCode ==200){
      setState(() {
        issend = true;
      });
    }
  }

  get_send_list(int my_id) async{
    final url = Uri.parse('http://124.70.183.83:8002/stock/get_send_list/');
    final response = await http.post(
        url,
        headers: {
          'Content-Type':'application/json'
        },
        body: json.encode({
          'send_user_id':my_id,
          'accept_user_id':widget.user_id
        })
    );
    if(response.statusCode ==200){
      final data  = json.decode(response.body);
      if (!mounted) return;
      setState(() {
        send_list = data['data'];
      });
    }
  }

  @override
  void initState() {
    get_send_list(widget.my_id);
    Timer.periodic(Duration(seconds: 1), (_) => get_send_list(widget.my_id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(CupertinoIcons.back,size: 35,)),
          title: Row(
            children: [
              ClipOval(
                child: Image.asset(widget.avatar,width: 40,height: 40,fit: BoxFit.cover,),
              ),
              SizedBox(width: 10,),
              Text(widget.username)
            ],
          )
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: send_list.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    if (send_list[index]['send_user_id']!=widget.my_id) {
                      return Padding(
                      padding: const EdgeInsets.only(left: 10,top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: Image.asset(widget.avatar,width: 60,height: 60,fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 10,),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6, // 设置最大宽度为屏幕宽度的80%
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(send_list[index]['description']),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                    } else {
                      return Padding(
                      padding: const EdgeInsets.only(right: 10,top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6, // 设置最大宽度为屏幕宽度的80%
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.purple
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(send_list[index]['description']),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          ClipOval(
                            child: Image.asset(widget.my_avatar,width: 60,height: 60,fit: BoxFit.cover,),
                          )
                        ],
                      ),
                    );
                    }
                  })
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              height: 60,
              width: MediaQuery.of(context).size.width*0.85,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                    fillColor: Color.fromARGB(255, 226, 226, 226),
                    suffixIcon: IconButton(
                      style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(58, 40)),
                        backgroundColor: WidgetStatePropertyAll(Colors.purple)
                      ),
                        onPressed: (){
                          postmessage(new_message,widget.user_id,widget.my_id);
                          FocusScope.of(context).unfocus();
                          _controller.clear();
                        },
                        icon: Icon(Icons.send,color: Colors.white,)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                onChanged: (value){
                  setState(() {
                    new_message = value;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
