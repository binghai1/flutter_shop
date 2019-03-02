import 'package:flutter/material.dart';
import '../services/servicesUtil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
class HomePage extends StatefulWidget {

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String contentData="正在获取数据";
  @override
  void initState() { 
    getHomePageContent().then((val){
      print(val);
        setState((){
            contentData=val.toString();
        });
    });  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
         title: Text("百姓生活+"),
       ),
        body:FutureBuilder(
          future: getHomePageContent(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              print("111$snapshot");
              var data=json.decode(snapshot.data.toString());
              List<Map> swiperList=(data['data']['slides'] as List).cast();
               print("66$swiperList");
              return Column(children: <Widget>[
                SwiperComponent(swiperList:swiperList)
              ],);
            }else{
              return Center(
              child: Text('加载中'),
            );
            }
          },
        ),

    );
  }
  
}
class SwiperComponent extends StatelessWidget {
  final List swiperList;

  SwiperComponent({Key key, this.swiperList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333.0,
      child: Swiper(
        itemBuilder:(BuildContext context,int index){
          return Image.network(swiperList[index]['image'],fit:BoxFit.fill);
        },
        itemCount: swiperList.length,
        pagination:SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}