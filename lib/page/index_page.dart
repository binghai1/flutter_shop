import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './cart_page.dart';
import './category_page.dart';
import './home_page.dart';
import './member_page.dart';
class IndexPage extends StatefulWidget {
  final Widget child;

  IndexPage({Key key, this.child}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomBars=[
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        title: Text("首页")
      ),
       BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        title: Text("分类")
      ),
       BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        title: Text("购物车")
      ),
       BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        title: Text("会员中心")
      )

  ];
  int currentIndex=0;
  var currentPage;
  final allPage=[HomePage(),CategoryPage(),CartPage(),MemberPage()];
  @override
  void initState() {
    super.initState();
    currentPage=allPage[currentIndex];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromRGBO(244,233,222,0),
       bottomNavigationBar: BottomNavigationBar(
         type:BottomNavigationBarType.fixed,
         currentIndex: currentIndex,
         items:bottomBars,
         onTap: (index){
           setState(() {
             currentPage=allPage[index];
           });
         },
       ),
       body: currentPage
    );
  }
}