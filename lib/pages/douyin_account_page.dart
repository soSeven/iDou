import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idou/bean/douyin_account_bean.dart';
import 'package:idou/bean/qr_code_bean.dart';
import 'package:idou/blocs/bloc_provider.dart';
import 'package:idou/blocs/douyin_account_bloc.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/widgets/base_dialog.dart';
import 'package:idou/widgets/widgets.dart';

class DouyinAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        child: DouyinAccountPageStateless(), bloc: DouyinAccountBloc());
  }
}

class DouyinAccountPageStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final DouyinAccountBloc bloc = BlocProvider.of<DouyinAccountBloc>(context);
    Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
      bloc.getDouyinAccountList();
    });
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff151921),
            centerTitle: true,
            title: Text("我的抖音号",
                style: TextStyle(fontSize: 18, color: Colors.white))),
        body: new StreamBuilder(
            stream: bloc.douyinStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<DouyinAccount>> snapshot) {
              var data = snapshot.data;
              print(data);
              if (data == null) {
                return new Container(
                  alignment: Alignment.center,
//          color: Colours.gray_f0,
                  child: new ProgressView(),
                );
              } else if (ObjectUtil.isEmpty(data)) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 45),
                        child: Column(
                          children: [
                            Image(
                                image:
                                    AssetImage("assets/images/icon_phone.png"),
                                width: 142.5,
                                height: 142.5),
                            Padding(
                                padding: const EdgeInsets.only(top: 45),
                                child: Text("授权抖音号您可：",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff8B8C91)))),
                            Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/icon_yes.png"),
                                          width: 15.5,
                                          height: 15.5),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6),
                                          child: Text("一键发布视频到抖音",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white)))
                                    ])),
                            Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/icon_yes.png"),
                                          width: 15.5,
                                          height: 15.5),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6),
                                          child: Text("查看小程序收益数据",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white)))
                                    ])),
                            Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                        image: AssetImage(
                                            "assets/images/icon_yes.png"),
                                        width: 15.5,
                                        height: 15.5),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Text("获取抖音粉丝用户画像以及活跃度",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white)))
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 29),
                        child: InkWell(
                          onTap: () {
                            getDoudinQrCode(context, bloc);

//                        Navigator.push(context, new CupertinoPageRoute<void>(
//                          builder: (ctx) => new AppletDetailClass(
//                              encode_id: bean.encodeId
//                          ),
//                        ));
                          },
                          child: new Container(
                            width: double.infinity,
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xffFF324D),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text("添加抖音号",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white)),
                          ),
                        )),
                  ],
                );
              } else
                return buildDouyinAccountList(data, bloc, context);
            }));
  }

  Widget buildDouyinAccountList(
      List<DouyinAccount> data, DouyinAccountBloc bloc, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              DouyinAccount bean = data[index];
              return Padding(
                padding: const EdgeInsets.only(top: 25, right: 15, left: 15),
                child: _getItem(data, bean, index, bloc, context),
              );
            },
            itemCount: data == null ? 0 : data.length,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 29),
            child: InkWell(
              onTap: () {
                getDoudinQrCode(context, bloc);
//                        Navigator.push(context, new CupertinoPageRoute<void>(
//                          builder: (ctx) => new AppletDetailClass(
//                              encode_id: bean.encodeId
//                          ),
//                        ));
              },
              child: new Container(
                width: double.infinity,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffFF324D),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text("添加抖音号",
                    style: TextStyle(fontSize: 15.0, color: Colors.white)),
              ),
            )),
      ],
    );
  }

  Widget _getItem(List<DouyinAccount> data, DouyinAccount bean, int index,
      DouyinAccountBloc bloc, BuildContext context) {
    return Container(
        height: 40,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(bean.avatar),
                      fit: BoxFit.cover,
                    ))),
//            new CachedNetworkImage(
//              width: 40,
//              height: 40,
//              fit: BoxFit.fill,
//              imageUrl: bean.avatar,
//              errorWidget: (context, url, error) => new Icon(Icons.error),
//            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 2, bottom: 2),
              child: Column(children: [
                Expanded(
                    child: Text(bean.nickname,
                        style: TextStyle(fontSize: 14, color: Colors.white))),
                Text("粉丝数：" + bean.fansCount.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.white))
              ]),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 52),
              child: Row(children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: (BoxDecoration(
                    color: Color(0xffF3CF4A),
                    borderRadius: BorderRadius.circular(35.0),
                  )),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text("剩余" + bean.expiresDay.toString() + "天",
                        style:
                            TextStyle(fontSize: 13, color: Color(0xffC6C6C9))))
              ]),
            )),
            InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BaseDialog(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        right: 13, top: 13, bottom: 2),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/images/close_icon.png"),
                                              width: 15,
                                              height: 15),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    )),
                                Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 11.5),
                                    child: Text(
                                        "授权剩余" +
                                            bean.expiresDay.toString() +
                                            "天",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff1A1A1A),
                                            fontWeight: FontWeight.bold))),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    getDoudinQrCode(context, bloc);
                                  },
                                  child: Container(
                                      height: 44,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          left: 25.5, right: 25.5),
                                      decoration: (BoxDecoration(
                                        color: Color(0xffFF324D),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      )),
                                      child: Text("重新授权",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white))),
                                ),
                                InkWell(
                                  onTap: () {
                                    bloc.deleteDouyinAccount(bean.encodeId);
                                    bloc.getDouyinAccountList();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      height: 44,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          left: 25.5, right: 25.5, top: 15),
                                      decoration: (BoxDecoration(
                                        color: Color(0xffCFCFD1),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      )),
                                      child: Text("删除抖音号",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white))),
                                ),
                              ],
                            ),
                            207,
                            300);
                      });
                },
                child: Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          decoration: (BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 2),
                          width: 4,
                          height: 4,
                          decoration: (BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 2),
                          width: 4,
                          height: 4,
                          decoration: (BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                          )),
                        )
                      ],
                    )))
          ],
        ));
  }

  Widget BuildQrCode(BuildContext context, DouyinAccountBloc bloc) {
    return new StreamBuilder(
        stream: bloc.douyinQrCodeStream,
        builder: (BuildContext context, AsyncSnapshot<QrCodeBean> snapshot) {
          var data = snapshot.data;
          if (ObjectUtil.isEmpty(data)) {
            return Container(height: 0);
          }
          return Container(
            padding: const EdgeInsets.all(11),
            child: GestureDetector(
                onLongPress: () async {
                  Utils.saveImage(data.url);
//                print(result);
//                if(result){
//                }else{
//                  Fluttertoast.showToast(msg: "保存失败");
//                }
                },
                child: new CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: data.url,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                )),
          );
        });
  }

  void getDoudinQrCode(BuildContext context, DouyinAccountBloc bloc) {
    bloc.bindingDouyinAccount();
    showDialog(
        context: context,
        builder: (context) {
          return BaseDialog(
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(right: 13, top: 13, bottom: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: Image(
                                image:
                                    AssetImage("assets/images/close_icon.png"),
                                width: 15,
                                height: 15),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 11.5),
                      child: Text("抖音APP扫码授权",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff1A1A1A),
                              fontWeight: FontWeight.bold))),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 22),
                      child: Text("授权功能当前支持所有抖音号",
                          style: TextStyle(
                              fontSize: 14, color: Color(0xff8B8C91)))),
                  Container(
                    height: 210,
                    width: 210,
                    decoration: (BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border:
                            Border.all(width: 2.5, color: Color(0xffE8E8E9)))),
                    child: BuildQrCode(context, bloc),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 11),
                      child: Text("授权抖音号您可：",
                          style: TextStyle(
                              fontSize: 14, color: Color(0xff8B8C91)))),
                  Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: AssetImage("assets/images/icon_yes.png"),
                                width: 15.5,
                                height: 15.5),
                            Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text("一键发布视频到抖音",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff23252F))))
                          ])),
                  Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: AssetImage("assets/images/icon_yes.png"),
                                width: 15.5,
                                height: 15.5),
                            Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text("查看小程序收益数据",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff23252F))))
                          ])),
                  Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: AssetImage("assets/images/icon_yes.png"),
                              width: 15.5,
                              height: 15.5),
                          Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text("获取抖音粉丝用户画像以及活跃度",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff23252F))))
                        ],
                      ))
                ],
              ),
              445,
              300);
        });
  }
}
