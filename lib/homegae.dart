import 'dart:convert';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '';
import 'main.dart';
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with RouteAware{
  late VideoPlayerController controller;
  var video_type_list =[
    "推荐",
    "同城",
    "国外",
    "短视频",
    "学习",
    "直播",
    "团购"
  ];
  var video_list = [];
  @override
  void initState() {
    get_video_list();
    super.initState();
  }
  get_video_list() async{
    final url = Uri.parse('http://124.70.183.83:8002/stock/get_videourls/');
    final response = await http.post(
        url,
        headers:{'Content-Type':'application/json'},
        body: json.encode({})
    );
    print(response.statusCode);
    if(response.statusCode ==200){
      final response_data = json.decode(response.body);
      setState(() {
        video_list = response_data['data'];
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.black,
              systemNavigationBarIconBrightness: Brightness.light
          )
      );
    });
    return Stack(
        alignment: Alignment.center,
        children: [
          PageView(
          scrollDirection: Axis.vertical,
          children: [
            for (var item in video_list) item_video(title: item['title'], url: item['url'])
          ],),
          Positioned(top:MediaQuery.of(context).padding.top+10,child: Container(
            height:40,width:MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Icon(Icons.menu,size: 35,),
                Expanded(
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        TextButton(onPressed: (){},  style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.center,), child: Text("推荐",style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
                        TextButton(onPressed: (){},  style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.center,), child: Text("同城",style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
                        TextButton(onPressed: (){},  style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.center,), child: Text("国外",style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
                        TextButton(onPressed: (){},  style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.center,), child: Text("短视频",style: TextStyle(fontSize:18),textAlign: TextAlign.center,)),
                        TextButton(onPressed: (){},  style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.center,), child: Text("学习",style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
                        TextButton(onPressed: (){},  style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.center,), child: Text("直播",style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
                        TextButton(onPressed: (){},  style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.center,), child: Text("团购",style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
                      ],
                    ),
                  ),
                ),
                Icon(CupertinoIcons.search,size: 35,)
              ],
            ),
          )),
        ],
    );
}}


class item_video extends StatefulWidget {
  final title;
  final url;
  const item_video({super.key,required this.title, required this.url});

  @override
  State<item_video> createState() => _item_videoState();
}

class _item_videoState extends State<item_video> {
  late VideoPlayerController controller;
  bool islike = false;
  bool iscollect = false;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    controller.initialize().then((_){
      if(mounted){
        setState(() {
        });
      }
    });
    controller.addListener((){
      if(controller.value.isInitialized && mounted){
        setState(() {

        });
      }
    });
    controller.setLooping(true);
    controller.play();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.removeListener((){});
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
      if(controller.value.isPlaying){
        controller.pause();
      }
      else{
        controller.play();
      }
    },
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
                Center(
                  child: controller.value.isInitialized?AspectRatio(aspectRatio:controller.value.aspectRatio,child: VideoPlayer(controller))
                  :CircularProgressIndicator(),
                ),
               Align(
                 alignment: Alignment.bottomCenter,
                   child: Container(
                     height: 20,
                     width: MediaQuery.of(context).size.width*0.95,
                     alignment: Alignment.center,
                     child: ProgressBar(
                      timeLabelLocation: TimeLabelLocation.sides,
                      progress: Duration(milliseconds: controller.value.position.inMilliseconds),
                      buffered: Duration(milliseconds: 1000),
                      total: Duration(milliseconds: controller.value.duration.inMilliseconds),
                      onSeek: (duration) {
                            controller.seekTo(duration);
                      },),
                   ),
               ),
              Positioned(left:10,bottom:60,child: Container(width: MediaQuery.of(context).size.width*0.6,child: Text(widget.title,maxLines: 2,))),
              Positioned(right:10,bottom:70,child: Column(
                children: [
                  IconButton(onPressed: (){
                          setState(() {
                            islike = !islike;
                          });
                  }, icon: Icon(CupertinoIcons.heart_solid,size: 35,color: islike?Colors.red:Colors.white,)),
                  Text("25.6k"),
                  IconButton(onPressed: (){}, icon: Icon(FluentIcons.comment_12_filled,size: 35,color: Colors.white)),
                  Text("8.1k"),
                  IconButton(onPressed: (){
                    setState(() {
                      iscollect = !iscollect;
                    });
                  }, icon: Icon(FluentIcons.collections_16_filled,size: 35,color: iscollect?Colors.orange:Colors.white)),
                  Text("3.4k"),
                  IconButton(onPressed: (){}, icon: Icon(FluentIcons.share_16_filled,size: 35,color: Colors.white)),
                  Text("1.2k")
                ],
              ))
            ]
          ),
        ));
  }
}
