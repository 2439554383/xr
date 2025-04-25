import 'dart:async';
import 'dart:convert';
import 'package:alipay_kit/alipay_kit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class skudetail extends StatefulWidget {
  const skudetail({super.key});

  @override
  State<skudetail> createState() => _skudetailState();
}

class _skudetailState extends State<skudetail> {
  flutter_pay(String data) async{
    final result = await AlipayKitPlatform.instance.pay(orderInfo: data);
  }
  postpay() async{
    final url = Uri.parse('http://124.70.183.83:8002/stock/postpay/');
    final response = await http.post(
      url,
      headers:{'Centant-Type':'application/json'},
      body:json.encode({

      })
    );
    if(response.statusCode ==200){
        final data = json.decode(response.body)['data'];
        setState(() {
          print(data);
          flutter_pay(data);
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,(){
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          )
      );
    });
    return Scaffold(
      body: Stack(
        children: [

          SingleChildScrollView(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.5,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Image.asset('assets/images/sp2.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.5,fit: BoxFit.cover,),
                        Image.asset('assets/images/sp1.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.5,fit: BoxFit.cover,),
                        Image.asset('assets/images/sp3.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.5,fit: BoxFit.cover,),
                        Image.asset('assets/images/sp6.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.5,fit: BoxFit.cover,),
                        Image.asset('assets/images/sp5.png',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.5,fit: BoxFit.cover,),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey[850]!,
                          Colors.grey[900]!,      // 深灰（接近黑）
                          Colors.black87!,      // 纯黑底色
                          Colors.grey[900]!,
                          Colors.grey[850]!, // 底部稍亮
                        ],
                        stops: [0.0,0.3 ,0.5, 0.8,1.0],  // 控制过渡位置
                      ),
                    ),
                    height: 95,
                    child:Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    Text("￥89.2",style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 255, 189, 0), // 金属金主色
                                            Color.fromARGB(255, 255, 215, 105),// 高光黄
                                            Color.fromARGB(249, 255, 253, 2),
                                            Color.fromARGB(255, 255, 204, 143),
                                          ],
                                          stops: [0.0, 0.3, 0.7, 1.0],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                    ),),
                                    const SizedBox(width: 10,),
                                    Text("券后价￥46.7",style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 255, 189, 0), // 金属金主色
                                            Color.fromARGB(255, 255, 215, 105),// 高光黄
                                            Color.fromARGB(249, 255, 253, 2),
                                            Color.fromARGB(255, 255, 204, 143),
                                          ],
                                          stops: [0.0, 0.3, 0.7, 1.0],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                    ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    Text("已售874",style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 255, 189, 0), // 金属金主色
                                            Color.fromARGB(255, 255, 215, 105),// 高光黄
                                            Color.fromARGB(249, 255, 253, 2),
                                            Color.fromARGB(255, 255, 204, 143),
                                          ],
                                          stops: [0.0, 0.3, 0.7, 1.0],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                    )),
                                    const SizedBox(width: 10,),
                                    Text("券 5.5折",style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 255, 189, 0), // 金属金主色
                                            Color.fromARGB(255, 255, 215, 105),// 高光黄
                                            Color.fromARGB(249, 255, 253, 2),
                                            Color.fromARGB(255, 255, 204, 143),
                                          ],
                                          stops: [0.0, 0.3, 0.7, 1.0],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                    ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 4,
                          child: Text("活动特惠",style: TextStyle(
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [
                                  Color.fromARGB(254, 255, 145, 17), // 金属金主色
                                  Color.fromARGB(255, 255, 128, 29),// 高光黄
                                  Color.fromARGB(184, 241, 126, 10),
                                  Color.fromARGB(237, 255, 207, 153),
                                ],
                                stops: [0.0, 0.3, 0.7, 1.0],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                          )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("WITHMIN 短袖女t恤夏显瘦简约正肩2025新款休闲白色修身上衣女装",style: TextStyle(fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 30,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(247, 239, 239, 239),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("高品质",style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 253, 224, 61), // 金属金主色
                                        Color.fromARGB(255, 255, 93, 24),// 高光黄
                                        Color.fromARGB(184, 255, 223, 1),
                                        Color.fromARGB(255, 255, 157, 11),
                                      ],
                                      stops: [0.0, 0.3, 0.7, 1.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(247, 239, 239, 239),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("运费险",style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 253, 224, 61), // 金属金主色
                                        Color.fromARGB(255, 255, 93, 24),// 高光黄
                                        Color.fromARGB(184, 255, 223, 1),
                                        Color.fromARGB(255, 255, 157, 11),
                                      ],
                                      stops: [0.0, 0.3, 0.7, 1.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(247, 239, 239, 239),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("正品保证",style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 253, 224, 61), // 金属金主色
                                        Color.fromARGB(255, 255, 93, 24),// 高光黄
                                        Color.fromARGB(184, 255, 223, 1),
                                        Color.fromARGB(255, 255, 157, 11),
                                      ],
                                      stops: [0.0, 0.3, 0.7, 1.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(247, 239, 239, 239),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("店铺销量超过99%同行",style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 253, 224, 61), // 金属金主色
                                        Color.fromARGB(255, 255, 93, 24),// 高光黄
                                        Color.fromARGB(184, 255, 223, 1),
                                        Color.fromARGB(255, 255, 157, 11),
                                      ],
                                      stops: [0.0, 0.3, 0.7, 1.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(247, 239, 239, 239),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("4w+人感兴趣",style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 253, 224, 61), // 金属金主色
                                        Color.fromARGB(255, 255, 93, 24),// 高光黄
                                        Color.fromARGB(184, 255, 223, 1),
                                        Color.fromARGB(255, 255, 157, 11),
                                      ],
                                      stops: [0.0, 0.3, 0.7, 1.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(247, 239, 239, 239),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("好评率高达78%",style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 253, 224, 61), // 金属金主色
                                        Color.fromARGB(255, 255, 93, 24),// 高光黄
                                        Color.fromARGB(184, 255, 223, 1),
                                        Color.fromARGB(255, 255, 157, 11),
                                      ],
                                      stops: [0.0, 0.3, 0.7, 1.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                )),
                              ),
                            ),
                          ),
             
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Column(
                              children: [
                                Text('青年'),
                                SizedBox(height: 3,),
                                Text("适用对象")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Column(
                              children: [
                                Text('条纹'),
                                SizedBox(height: 3,),
                                Text("图案")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Column(
                              children: [
                                Text('面料'),
                                SizedBox(height: 3,),
                                Text("纯棉")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Column(
                              children: [
                                Text('领袖'),
                                SizedBox(height: 3,),
                                Text("圆领")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Column(
                              children: [
                                Text('风格'),
                                SizedBox(height: 3,),
                                Text("美式休闲")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Column(
                              children: [
                                Text('版型'),
                                SizedBox(height: 3,),
                                Text("宽松型")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Column(
                              children: [
                                Text('适用季节'),
                                SizedBox(height: 3,),
                                Text("夏季")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      height: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("预计12小时内发货，4月23日送达"),
                          SizedBox(height: 2,),
                          Text("广东省深圳 发货")
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        height: 400,
                        child: Text("评论区")
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        height: 200,
                        child: Text("店家信息")
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        height: 400,
                        child: Text("商品详情")
                    ),
                  ),
                ],
              ),
          ),
          Positioned(bottom:30,right:20,child: Container(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:Color(0xff6200ee),
          ),width:150,height:50,
              child: Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.shopping_cart)),
                  TextButton(
                      onPressed: (){
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context, builder: (context){
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.8,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,top: 10),
                                        child: Row(
                                          children: [
                                            ClipRRect(child: Image.asset('assets/images/sp2.png',width: 100,height: 100,fit: BoxFit.cover,),borderRadius: BorderRadius.circular(10),),
                                            SizedBox(width: 15,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text("实付价",style: TextStyle(fontSize: 20),),
                                                    Text("￥221",style: TextStyle(fontSize: 20))
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text('颜色:黑色',style: TextStyle(fontSize: 17)),
                                                    SizedBox(width: 10,),
                                                    Text("尺码:39",style: TextStyle(fontSize: 17))
                                                  ],
                                                )
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(CupertinoIcons.location_solid,color: Color(0xff6200ee),size: 40,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("骆旭东 福建省泉州市丰泽区泉秀街道泉秀街客运中心站泉州铂金酒店(群盛店)后门的丰巢柜",maxLines: 2,),
                                                    SizedBox(height: 3,),
                                                    Text("包邮·赠运费险·48小时内发货"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(bottom: 10,width: MediaQuery.of(context).size.width*0.85,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),child: TextButton(onPressed: (){postpay();}, child: Text("立即支付￥221.00"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff6200ee)),),)))
                                ]
                              );
                        });
                        }, 
                      child: Text("立即抢购"))
                ],
              ))),
          Positioned(top: MediaQuery.of(context).padding.top,left:5,child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(CupertinoIcons.back,size: 35,color: Colors.black,))),
        ]
      ),
    );
  }
}
