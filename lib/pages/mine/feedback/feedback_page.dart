
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idou/blocs/mine/feedback/feedback_bloc.dart';
import 'package:idou/blocs/mine/feedback/feedback_event.dart';
import 'package:idou/blocs/mine/feedback/feedback_state.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;
import 'package:idou/widgets/normal_button.dart';
import 'package:idou/widgets/loading.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '意见反馈',
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
      body: Bloc.BlocProvider<FeedbackBloc>(
        create: (context) => FeedbackBloc(),
        child: Loading.build(child: _FeedbackListPageState()),
      ),
      backgroundColor: HexColor.fromHex('#181824'),
    );
  }

}

// ignore: must_be_immutable
class _FeedbackListPageState extends StatelessWidget {

  final _picker = ImagePicker();
  var _imageList = <FeedbackStateUploadSuccess>[];
  TextEditingController _contentController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  // ignore: close_sinks
  FeedbackBloc _bloc;

  void _showSheet(BuildContext context) {

    FocusScope.of(context).requestFocus(FocusNode());

    showModalBottomSheet(
      backgroundColor: HexColor.fromHex('#242630'),
      context: context,
      builder: (context) {
          return SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  NormalButton(
                    child: NormalText.normal(text: '照 相', fontSize: 15),
                    height: 50.scale(),
                    onTap: () {
                      Navigator.of(context).pop();
                      _getImage(0);
                    },
                  ),
                  Divider(thickness: 0.5, color: Colors.white24),
                  NormalButton(
                    child: NormalText.normal(text: '相 册', fontSize: 15),
                    height: 50.scale(),
                    onTap: () {
                      Navigator.of(context).pop();
                      _getImage(1);
                    },
                  ),
                ],
              ),
              height: 120.scale(),
            ),
       );
    });
  }

  Future _getImage(int type) async {
    PickedFile pickedFile;
    if (type == 0) {
      pickedFile = await _picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await _picker.getImage(source: ImageSource.gallery);
    }
    if (pickedFile != null) {
      EasyLoading.show(status: '正在图片上传...');
      _bloc.add(FeedbackEventUploadImage(image: pickedFile));
    }

  }

  @override
  Widget build(BuildContext context) {

    if (_bloc == null) {
      _bloc = BlocProvider.of<FeedbackBloc>(context);
    }

    return Bloc.BlocListener<FeedbackBloc, FeedbackState>(
      listener: (context, state) {
        if (state is FeedbackStateUploadSuccess) {
          EasyLoading.showSuccess('上传图片成功');
        }
        if (state is FeedbackStateFailure) {
          EasyLoading.showError(state.error);
        }
        if (state is FeedbackStateSuccess) {
          EasyLoading.showSuccess('提交成功');
          Future.delayed(Duration(milliseconds: 2000), (){
            Navigator.of(context).pop();
          });
        }
      },
      bloc: _bloc,
      child: Bloc.BlocBuilder<FeedbackBloc, FeedbackState>(
        bloc: _bloc,
        buildWhen: (lastState, state) {
          if (state is FeedbackStateSuccess) {
            return false;
          }
          return true;
        },
        builder: (context, state) {

          if (state is FeedbackStateUploadSuccess) {
            _imageList.add(state);
            _bloc.add(FeedbackEventUploadComplete());
          }

          return ListView(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15.scale(), top: 16.scale(), bottom: 16.scale()),
                child: NormalText.normal(
                  text: '反馈内容',
                  fontSize: 15,
                  color: HexColor.fromHex('#FEFEFE'),
                  weight: FontWeight.bold
                ),
              ),
              Container(
//                height: 198.scale(),
                color: HexColor.fromHex('#242630'),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5.scale(),),
                    TextField(
                      maxLines: 4,
                      maxLength: 200,
                      decoration: InputDecoration(
                          hintText: '请填写10字以上的描述以便我们提供更好的帮助',
                          hintStyle: TextStyle(
                              color: HexColor.fromHex('#696971'),
                              fontSize: 14.scale(),
                              fontWeight: FontWeight.normal,
                              fontFamily: MineUtil.fontFamily
                          ),
                          border: InputBorder.none
                      ),
                      controller: _contentController,
                    ),
                    SizedBox(height: 10.scale(),),
                    _getUploadView(context),
                  ],
                ),
                padding: EdgeInsets.only(left: 15.scale(), right: 15.scale(), bottom: 24.scale()),
              ),
              Container(
                padding: EdgeInsets.only(left: 15.scale(), top: 16.scale(), bottom: 16.scale()),
                child: NormalText.normal(
                    text: '联系方式',
                    fontSize: 15,
                    color: HexColor.fromHex('#FEFEFE'),
                    weight: FontWeight.bold
                ),
              ),
              Container(
                height: 40.scale(),
                color: HexColor.fromHex('#242630'),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: 'QQ号/微信号/手机号',
                        hintStyle: TextStyle(
                            color: HexColor.fromHex('#696971'),
                            fontSize: 14.scale(),
                            fontWeight: FontWeight.normal,
                            fontFamily: MineUtil.fontFamily
                        ),
                        border: InputBorder.none
                    ),
                  controller: _contactController,
                  ),
                padding: EdgeInsets.only(left: 15.scale(), right: 15.scale()),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_contentController.text.length < 10) {
                      EasyLoading.showError('请填写10字以上的描述');
                      return;
                    }
                    EasyLoading.show(status: '正在提交...');

                    final pic = _imageList.map((e) => e.url).toList().join(',');

                    _bloc.add(FeedbackEventUpload(
                      content: _contentController.text,
                      contact: _contactController.text,
                      pic: pic
                    ));
                  },
                  child: NormalText.normal(
                    text: '提交',
                    fontSize: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.scale()),
                  ),
                  color: HexColor.fromHex('#FF324D'),
                ),
                margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 35.scale(), bottom: 37.scale()),
                height: 49.scale(),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _getUploadView(BuildContext context) {

    final images = _imageList.map((e) => Container(
      child: NormalButton(
        child: Image.network(e.url, fit: BoxFit.cover, width: double.infinity, height: double.infinity,),
        width: 61.scale(),
        height: 61.scale(),
        onTap: () {
          _imageList.remove(e);
          _bloc.add(FeedbackEventUploadComplete());
        },
      ),
      margin: EdgeInsets.only(right: 10.scale()),
    )).toList();

    if (images.length < 5) {
      images.add(Container(child: NormalButton(
        child: Image(image: LoadImage.localImage('upload'),),
        width: 61.scale(),
        height: 61.scale(),
        onTap: () => _showSheet(context),
      ),));
    }

    return Container(
      child: Row(
        children: images,
      ),
    );
  }

}