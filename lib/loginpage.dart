// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok1/homegae.dart';
import 'package:tiktok1/storepage.dart';
import 'SharedPreferences.dart';
import 'friendpage.dart';
import 'main.dart';
import 'minepage.dart';
import 'package:oktoast/oktoast.dart';
class loginpage extends StatefulWidget with RouteAware{
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> with RouteAware{
  final RegExp phone_re = RegExp(r'^1[3-9]\d{9}$');
  final RegExp sms_re = RegExp(r'^\d{4}$');
  var sms  = "";
  var session_id = '';
  Timer? _timer;
  int _seconds = 0;
  final TextEditingController _controller = TextEditingController();
  var phonenumber= "";
  var user_phonenumber = '';
  var user_information ;
  bool issend = false;
  final savainfomation _savainfomation = savainfomation();
  var widget_list = [
    homepage(),
    friendpage(),
    storepage(),
    minepage()
  ];

  getsms(String phonenumber) async{
    final url = Uri.parse('http://124.70.183.83:8002/stock/getsms/');
    final response = await http.post(
        url,
        headers :{'Content-Type':'application/json'},
        body:json.encode({
          'phonenumber':phonenumber
        })
    );
    if(response.statusCode == 200){
      print(response.statusCode);
      bool x =json.decode(response.body)['status'];
      if(x==true){
        print(x);
        setState(() {
          issend =true;
          session_id = json.decode(response.body)['session_id'];
          sms_time();
        });
      }
      else{
        setState(() {
          print('失败：${x}');
          issend =false;
        });
      }
    }
  }
  sms_time() {
    setState(() {
      _seconds = 60;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
        if(_seconds <= 1){
          timer.cancel();
          _controller.clear();
          setState(() {
            issend =false;
          });
        }
        setState(() {
          _seconds--;
        });
    });
  }
  verify_sms(String sms) async{
    final url = Uri.parse('http://124.70.183.83:8002/stock/verify_sms/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type':'application/json',
        'Cookie': 'sessionid=${session_id}'
      },
      body: json.encode({
        'sms':sms
      })
    );
    print(response.statusCode);
    bool x =json.decode(response.body)['status'];
    print(x);
    if(x ==true){
        _savainfomation.set_login(true);
        Navigator.pushNamed(context, '/mainpage');
        showToast("登录成功",position: ToastPosition(align: Alignment.topCenter));
        get_user_information(user_phonenumber);
    }
    else{
      showToast("登录失败，请检查验证码",position: ToastPosition(align: Alignment.topCenter));
    }
  }

  get_user_information(String user_phonenumber) async{
    final url = Uri.parse('http://124.70.183.83:8002/stock/get_user_information/');
    final response = await http.post(
        url,
        headers: {'Content-Type':'applicatin/json'},
        body: json.encode({
          'user_phonenumber':user_phonenumber
        })
    );
    print(response.statusCode);
    if(response.statusCode ==200){
      final data = json.decode(response.body);
      setState(() {
        user_information = json.encode(data['data']);
        _savainfomation.set_user_information(user_information);
        print("保存用户信息成功");
        _savainfomation.get_user_information().then((value){
          print("value:${value}");
        });

      });
    }
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
    int args = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: Icon(CupertinoIcons.back,size: 35,)),
      ),
      body: Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(top:100,child: Text("登录后，体验完整功能",style: TextStyle(fontSize: 18,color: Colors.black),)),
                Positioned(
                  top: 250,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.9,
                    child:
                    issend?Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              onChanged: (value){
                                setState(() {
                                  sms = value;
                                });
                              },
                              decoration: const InputDecoration(
                                fillColor: Color.fromARGB(255, 226, 226, 226),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                ),

                                hintText: "请输入验证码",
                                hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                              )),
                        ),
                        SizedBox(width: 10,),
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.red),
                                fixedSize: WidgetStatePropertyAll(Size(120,50))
                            ),
                            onPressed: (){
                            },
                            child: Text("${_seconds}",style: TextStyle(color: Colors.white,fontSize: 20),)
                        )
                      ],
                    ):
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (value){
                            setState(() {
                              phonenumber = value;
                            });
                          },
                          decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 226, 226, 226),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),

                              hintText: "请输入手机号",
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                          )),
                        ),
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.red),
                                fixedSize: WidgetStatePropertyAll(Size(120,50))
                            ),
                            onPressed: (){
                              if(phone_re.hasMatch(phonenumber)){
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  user_phonenumber = phonenumber;
                                });
                                getsms(phonenumber);
                                _controller.clear();
                              }
                              else{
                                showToast("请输入正确手机号",position: ToastPosition(align: Alignment.topCenter));
                              }
                            },
                            child: Text("获取验证码",style: TextStyle(color: Colors.white),)
                        )
                      ],
                    ),
                )),
                Positioned(top: 350,child: Container(width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      color:Colors.red,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextButton(
                  style: ButtonStyle(),
                          onPressed: (){
                            if(sms!='' && sms_re.hasMatch(sms)){
                              FocusScope.of(context).unfocus();
                              verify_sms(sms);
                            }
                            else{
                              showToast('请输入正确验证码',position: ToastPosition(align: Alignment.topCenter));
                            }
                            },
                          child: Text('一键登录',style: TextStyle(fontSize: 18,color: Colors.white),),))),
                Positioned(bottom: 50,child: TextButton(onPressed: () {}, child: Text("登录其他账号",style: TextStyle(fontSize: 13,color: Colors.black))),)
              ],
            )));
  }
}
