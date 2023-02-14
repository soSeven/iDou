import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idou/bean/mine/invite_post_model.dart';
import 'package:idou/blocs/mine/invite/invite_event.dart';
import 'package:idou/blocs/mine/invite/invite_state.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:idou/blocs/mine/invite/invite_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;
import 'package:idou/widgets/toast.dart';
import 'package:idou/widgets/loading.dart';

class InvitePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '推广海报',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.scale(),
            fontWeight: FontWeight.bold,
            fontFamily: MineUtil.fontFamily,
          ),
        ),
        centerTitle: true,
        backgroundColor: HexColor.fromHex('#181824'),
        elevation: 0,
        leading: FlatButton(
          child: ConstrainedBox(
            child: Image(
              image: LoadImage.localImage('icon_back'),
            ),
            constraints: BoxConstraints.tightFor(width: 9.scale(), height: 16.scale()),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocProvider<InviteBloc>(
        create: (context) => InviteBloc()..add(InviteFetched()),
        child: Loading.build(child: _InviteListPageState()),
      ),
      backgroundColor: HexColor.fromHex('#181824'),
    );
  }

}

// ignore: must_be_immutable
class _InviteListPageState extends StatelessWidget {

  var _dataList = <InvitePostModel>[];

  @override
  Widget build(BuildContext context) {

    // ignore: close_sinks
    final InviteBloc bloc = BlocProvider.of<InviteBloc>(context);

    return Bloc.BlocListener<InviteBloc, InviteState>(
      listener: (context, state) {
        if (state is InviteSaveSuccess) {
//          Toast.showToast(
//            context: context,
//            text: '保存成功',
//            gravity: ToastGravity.CENTER,
//            state: ToastState.success,
//          );
          EasyLoading.showSuccess('保存成功');
        }
        if (state is InviteSaveFailure) {
          EasyLoading.showError('保存失败');
//          Toast.showToast(
//            context: context,
//            text: '保存失败',
//            gravity: ToastGravity.CENTER,
//            state: ToastState.error,
//          );
        }
      },
      bloc: bloc,
      child: Bloc.BlocBuilder<InviteBloc, InviteState>(
        bloc: bloc,
        buildWhen: (lastState, state) {
          if (state is InviteSaveFailure ||
              state is InviteSaveSuccess ) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is InviteInitial) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
          if (state is InviteFailure) {
            return Center(
              child: NormalText.normal(text: '请求失败'),
            );
          }

          var currentIdx = 0;
          if (state is InviteIndex) {
            currentIdx = state.index;
          }

          if (state is InviteSuccess) {
            _dataList = state.result;
          }

          return ListView(
            children: [
              Padding(
                child: NormalText.normal(
                    text: _dataList.isNotEmpty ? _dataList[currentIdx].title : '',
                    fontSize: 15,
                    textAlign: TextAlign.center
                ),
                padding: EdgeInsets.only(top: 20.scale(), bottom: 20.scale()),
              ),
              CarouselSlider(
                items: _dataList.map((m) => _getItem(m)).toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 375/367.5,
                    viewportFraction: 0.55,
                    onPageChanged: (index, reason) {
                      if (_dataList.isNotEmpty) {
                        bloc.add(InviteChangeIndex(index: index));
                      }
                    }
                ),
              ),
              Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _dataList.map((model) {
                    int index = _dataList.indexOf(model);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIdx == index
                            ? HexColor.fromHex('#FF324D')
                            : HexColor.fromHex('#696971'),
                      ),
                    );
                  }).toList(),
                ),
                padding: EdgeInsets.only(top: 20.scale()),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if (_dataList.length > currentIdx) {
                      bloc.add(InviteSave(model: _dataList[currentIdx]));
                      EasyLoading.show(status: '正在加载...');
                    }
                  },
                  child: NormalText.normal(
                    text: '保存推广海报',
                    fontSize: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.scale()),
                  ),
                  color: HexColor.fromHex('#FF324D'),
                ),
                margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 37.scale(), bottom: 37.scale()),
                height: 49.scale(),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _getItem(InvitePostModel model) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(model.bgImg, fit: BoxFit.cover, width: 1000,),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

}