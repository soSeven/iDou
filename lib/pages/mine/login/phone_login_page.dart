
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idou/blocs/mine/bindphone/bind_phone_event.dart';
import 'package:idou/blocs/mine/bindphone/bind_phone_state.dart';
import 'package:idou/blocs/mine/bindphone/bine_phone_bloc.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/pages/mine/bind_phone/count_down.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:idou/widgets/loading.dart';
import 'package:idou/widgets/normal_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;

class PhoneLoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Bloc.BlocProvider<BindPhoneBloc>(
      create: (context) => BindPhoneBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '手机号登录',
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
        body: _PhoneLoginPage(),
        backgroundColor: HexColor.fromHex('#181824'),
      ),
    );
  }

}

// ignore: must_be_immutable
class _PhoneLoginPage extends StatelessWidget {

  bool _checkCodeEnable = false;
  bool _decideEnable = false;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _weChatController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // ignore: close_sinks
    final bloc = Bloc.BlocProvider.of<BindPhoneBloc>(context);

    return Bloc.BlocListener<BindPhoneBloc, BindPhoneState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is BindPhoneStateCheckCodeGetFailure) {
          EasyLoading.showError('获取验证码失败');
        }

        if (state is BindPhoneStateCheckCodeGetSuccess) {
          EasyLoading.showSuccess('获取验证码成功');
        }

        if (state is BindPhoneStateSuccess) {
          EasyLoading.showSuccess('提交成功');
          Future.delayed(Duration(milliseconds: 2000), (){
            Navigator.of(context).pop();
          });
        }

        if (state is BindPhoneStateFailure) {
          EasyLoading.showError(state.error);
        }

      },
      child: Bloc.BlocBuilder<BindPhoneBloc, BindPhoneState>(
        buildWhen: (context, state) {
          if (state is BindPhoneStateCheckCodeGetFailure ||
              state is BindPhoneStateCheckCodeGetSuccess ||
              state is BindPhoneStateSuccess ||
              state is BindPhoneStateFailure) {
            return false;
          }
          return true;
        },
        builder: (context, state) {

          if (state is BindPhoneStatePhoneCompleted) {
            _checkCodeEnable = true;
          }
          if (state is BindPhoneStatePhoneNotCompleted) {
            _checkCodeEnable = false;
          }

          if (state is BindPhoneStateCompleted) {
            _decideEnable = true;
          }

          if (state is BindPhoneStateNotCompleted) {
            _decideEnable = false;
          }

          return Container(
            child: Loading.build(child: Column(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          child: NormalText.normal(text: '+86', fontSize: 15, color: HexColor.fromHex('#E8E8E9')),
                          padding: EdgeInsets.only(right: 15.scale()),
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                                color: HexColor.fromHex('#1A1A1A'),
                                fontSize: 15.scale(),
                                fontWeight: FontWeight.normal,
                                fontFamily: MineUtil.fontFamily
                            ),
                            decoration: InputDecoration(
                              hintText: '请输入手机号',
                              hintStyle: TextStyle(
                                  color: HexColor.fromHex('#696971'),
                                  fontSize: 15.scale(),
                                  fontWeight: FontWeight.normal,
                                  fontFamily: MineUtil.fontFamily
                              ),
                              border: InputBorder.none,
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            keyboardType: TextInputType.number,
                            controller: _codeController,
                            onChanged: (text) {
                              if (text != null && text.length == 4 && _phoneController.text.length == 11) {
                                bloc.add(BindPhoneEventComplete());
                              } else {
                                bloc.add(BindPhoneEventNotComplete());
                              }
                            },
                          ),
                        ),
                        CountDownView(onTap: () {
                          bloc.add(BindPhoneEventCheckCodeGet(phone: _phoneController.text));
                        }, enable: _checkCodeEnable,),
                      ],
                    ),
                  ),
                  height: 57.scale(),
                  margin: EdgeInsets.only(top: 30.scale()),
                ),
                Divider(height: 0.5, color: HexColor.fromHex('#383A43'),),
                Container(
                  child: Center(
                    child: TextField(
                      style: TextStyle(
                          color: HexColor.fromHex('#1A1A1A'),
                          fontSize: 14.scale(),
                          fontWeight: FontWeight.normal,
                          fontFamily: MineUtil.fontFamily
                      ),
                      decoration: InputDecoration(
                        hintText: '请输入验证码',
                        hintStyle: TextStyle(
                            color: HexColor.fromHex('#696971'),
                            fontSize: 15.scale(),
                            fontWeight: FontWeight.normal,
                            fontFamily: MineUtil.fontFamily
                        ),
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      onChanged: (text) {
                        if (text != null && text.length == 11) {
                          bloc.add(BindPhoneEventPhoneComplete());
                        } else {
                          bloc.add(BindPhoneEventPhoneNotComplete());
                        }
                      },
                    ),
                  ),
                  height: 57.scale(),
                  margin: EdgeInsets.only(top: 12.scale()),
                ),
                Divider(height: 0.5, color: HexColor.fromHex('#383A43'),),
                NormalButton(
                  child: NormalText.normal(
                      text: '确定',
                      fontSize: 15,
                      color: HexColor.fromHex('#ffffff'),
                  ),
                  color: _decideEnable ? HexColor.fromHex('#FF324D') :  HexColor.fromHex('#F55E72'),
                  borderRadius: BorderRadius.circular(5.scale()),
                  height: 50.scale(),
                  margin: EdgeInsets.only(top: 45.scale(), bottom: 15.scale()),
                  onTap: () {
                    if (!_decideEnable) {
                      return;
                    }
                    bloc.add(BindPhoneEventUpload(
                        phone: _phoneController.text,
                        checkCode: _codeController.text,
                        weChat: _weChatController.text
                    ));
                  },
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '登录则视为同意',
                      style: TextStyle(
                        color: HexColor.fromHex('#696971'),
                        fontSize: 11.scale(),
                        fontFamily: MineUtil.fontFamily,
                        fontWeight: FontWeight.normal,
                      )
                    ),
                    TextSpan(
                        text: '《爱抖家族服务协议》',
                        style: TextStyle(
                          color: HexColor.fromHex('#C6C6C9'),
                          fontSize: 11.scale(),
                          fontFamily: MineUtil.fontFamily,
                          fontWeight: FontWeight.normal,
                        ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                          print('dffff');
                      }
                    ),
                  ]),
                  textAlign: TextAlign.center,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
            )),

            padding: EdgeInsets.only(left: 25.scale(), right: 25.scale()),
          );
        },
      ),
    );

  }
}