import 'package:flutter/material.dart';
import '../services/servicesUtil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              List<Map> navigatorList =(data['data']['category'] as List).cast();
               print("66$swiperList");
              return Column(children: <Widget>[
                SwiperComponent(swiperList:swiperList),
                 TopNavigator(navigatorList:navigatorList),
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
      height: ScreenUtil.getInstance().setHeight(333),
      width: ScreenUtil.getInstance().setWidth(750),
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
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  Widget __gridViewItemUI(BuildContext context,item){
      return InkWell(
        onTap: (){
          print("点击了小部件");
        },
        child: Column(
          children: <Widget>[
            Image.network(item['image'],width: ScreenUtil.getInstance().setWidth(95)),
            Text(item['mallCategoryName'])
          ],
        ),
      );
  }
  TopNavigator({Key key, this.navigatorList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(navigatorList.length>10){
      navigatorList.removeRange(10, 11);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding:EdgeInsets.all(3.0),
      child:GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item){
          return __gridViewItemUI(context,item);
        }).toList()),
    );
  }
}