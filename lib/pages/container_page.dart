import 'package:flutter/material.dart';
import 'package:idou/pages/data/data_page.dart';
import 'package:idou/pages/home_page.dart';
import 'package:idou/res/colors.dart';
import 'package:idou/utils/utils.dart';

import 'mine/mine_page.dart';

//import 'package:doubanapp/pages/group/group_page.dart';
//import 'package:doubanapp/pages/movie/book_audio_video_page.dart';
//import 'package:doubanapp/pages/home/home_page.dart';
//import 'package:doubanapp/pages/person/person_center_page.dart';
//import 'package:doubanapp/pages/shop_page.dart';

///这个页面是作为整个APP的最外层的容器，以Tab为基础控制每个item的显示与隐藏
class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContainerPageState();
  }
}

class _Item {
  String name, activeIcon, normalIcon;

  _Item(this.name, this.activeIcon, this.normalIcon);
}

class _ContainerPageState extends State<ContainerPage> {
  List<Widget> pages;

  final defaultItemColor = Color(0xff8B8B91);

  final itemNames = [
    _Item('首页', Utils.getImgPath('home_tabbar_icon_home_current'),
        Utils.getImgPath('home_tabbar_icon_home_default')),
    _Item('数据', Utils.getImgPath('home_tabbar_icon_data_current'),
        Utils.getImgPath('home_tabbar_icon_data_default')),
    _Item('我的', Utils.getImgPath('home_tabbar_icon_my_current'),
        Utils.getImgPath('home_tabbar_icon_my_default')),
  ];

  List<BottomNavigationBarItem> itemList;

  @override
  void initState() {
    super.initState();
    print('initState _ContainerPageState');
    if (pages == null) {
      pages = [
        HomePage(),
        DataPage(),
        MinePage(),
      ];
    }
    if (itemList == null) {
      itemList = itemNames
          .map((item) => BottomNavigationBarItem(

              icon: Image.asset(
                item.normalIcon,
                width: 19.0,
                height: 19.0,
              ),
              title: Text(
                item.name,
                style: TextStyle(fontSize: 10.0,color:defaultItemColor ),
              ),
              activeIcon:
                  Image.asset(item.activeIcon, width: 19.0, height: 19.0)))
          .toList();
    }
  }

  int _selectIndex = 0;

//Stack（层叠布局）+Offstage组合,解决状态被重置的问题
  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }

  @override
  void didUpdateWidget(ContainerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
//    Scaffold({
//    Key key,
//    this.appBar,
//    this.body,
//    this.floatingActionButton,
//    this.floatingActionButtonLocation,
//    this.floatingActionButtonAnimator,
//    this.persistentFooterButtons,
//    this.drawer,
//    this.endDrawer,
//    this.bottomNavigationBar,
//    this.bottomSheet,
//    this.backgroundColor,
//    this.resizeToAvoidBottomPadding = true,
//    this.primary = true,
//    })
    print('build _ContainerPageState');
    return Scaffold(
      body: new Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
        ],
      ),
//        List<BottomNavigationBarItem>
//        @required this.icon,
//    this.title,
//    Widget activeIcon,
//    this.backgroundColor,
      backgroundColor: Color(0xff191B1F),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.bottom_nav_bg,
        items: itemList,
        onTap: (int index) {
          ///这里根据点击的index来显示，非index的page均隐藏
          setState(() {
            _selectIndex = index;
            //这个是用来控制比较特别的shopPage中WebView不能动态隐藏的问题
//            shopPageWidget.setShowState(pages.indexOf(shopPageWidget) == _selectIndex);
          });
        },
        //图标大小
        iconSize: 18,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        //当前选中的索引
        currentIndex: _selectIndex,
        //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
        fixedColor: MyColors.nav_fixed_color,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
