import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class storepage extends StatefulWidget {
  const storepage({super.key});

  @override
  State<storepage> createState() => _storepageState();
}

class _storepageState extends State<storepage> {
  final TextEditingController controller_search = TextEditingController();
  var title = '';
  List<IconData> icon_list = [
    FluentIcons.re_order_16_filled,
    Icons.shop,
    Icons.supervised_user_circle_outlined,
    CupertinoIcons.time,
    FluentIcons.food_toast_16_filled,
    Icons.store,
    FluentIcons.currency_dollar_euro_16_filled,
    Icons.corporate_fare_rounded
  ];
  var title_list = [
    'WITHMIN 短袖女t恤夏显瘦简约正肩2025新款休闲白色修身上衣女装',
    '阿迪达斯短袖男纯棉夏新款2025半袖上衣宽松休闲圆领跑步运动T恤',
    '花花公子夏季加长工装裤男高个子190cm休闲裤青少年裤子学生大童',
    'FOG MIKI ESSENTIALS美式小众潮牌春夏高街纯棉宽松圆领短袖T恤男',
    '稚优泉卸妆水女眼唇脸三合一油膏卸妆液清洁温和正品官方品牌旗舰',
    '【520送男友礼物】欧莱雅男士耀白套装护肤品洗面奶水乳美白淡斑',
  ];
  var text_list = [
    '我的订单',
    '收藏',
    '评价中心',
    '小时达',
    '美食',
    '商店',
    '退款',
    '品牌中心',
  ];
  var money_list = [
    '89.2',
    '93',
    '567.4',
    '85',
    '67.3',
    '765',
  ];
  var image_url_list = [
    'assets/images/sp3.png',
    'assets/images/14.png',
    'assets/images/15.png',
    'assets/images/16.png',
    'assets/images/11.png',
    'assets/images/12.png',
  ];

  search_title(String title){

  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.light
          )
      );
    });
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+10),
      child: Column(
                children: [
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: controller_search,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          hintText: '请输入商品名',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                          filled: true,
                          fillColor: Color.fromARGB(255, 226, 226, 226),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(23)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(23)),
                            ),
                          suffixIcon: TextButton(
                            style: ButtonStyle(
                              padding:MaterialStatePropertyAll(EdgeInsets.zero),
                              backgroundColor: MaterialStatePropertyAll(Color(0xff6200ee)),
                            ),
                            onPressed: () {},
                            child: Text("搜索", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                                        ),
                    ),
                  SizedBox(height: 20,),
                  Container(
                    height: 200,
                    child: GridView.builder(
                      itemCount: icon_list.length,
                        padding: EdgeInsets.zero,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio:1/1
                        ),
                        itemBuilder: (context,index){
                          return Container(
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(icon_list[index],size: 35,),
                                  SizedBox(height: 3,),
                                  Text(text_list[index])
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: Container(
                      child: GridView.builder(
                        itemCount: image_url_list.length,
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              childAspectRatio:3/4
                          ),
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, '/skudetail');
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                    children: [
                                      Expanded(flex: 15,child: Container(width: MediaQuery.of(context).size.width,child: Image.asset(image_url_list[index],fit: BoxFit.cover,))),
                                      const SizedBox(height: 3,),
                                      Expanded(flex:2,child: Text(title_list[index],maxLines: 1,)),
                                      Expanded(flex:2,child: Text("￥${money_list[index]}",style: TextStyle(color: Colors.red),)),

                                    ],
                                  ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
        ),
    );
  }
}
