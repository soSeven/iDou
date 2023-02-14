
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

class BindPhonePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Bloc.BlocProvider<BindPhoneBloc>(
      create: (context) => BindPhoneBloc(),
      child: _BindPhonePage(),
    );
  }

}

// ignore: must_be_immutable
class _BindPhonePage extends StatelessWidget {

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

          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              child: Loading.build(child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25.scale()),
                    child: NormalText.normal(
                      text: '请绑定手机号',
                      fontSize: 16,
                      color: HexColor.fromHex('#1A1A1A'),
                      textAlign: TextAlign.center,
                      weight: FontWeight.bold,
                    ),
                  ),
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
                          hintText: '手机号',
                          hintStyle: TextStyle(
                              color: HexColor.fromHex('#B7B7B7'),
                              fontSize: 14.scale(),
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
                  ),
                  Divider(height: 0.5, color: HexColor.fromHex('#F0F0F0'),),
                  Container(
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                  color: HexColor.fromHex('#1A1A1A'),
                                  fontSize: 14.scale(),
                                  fontWeight: FontWeight.normal,
                                  fontFamily: MineUtil.fontFamily
                              ),
                              decoration: InputDecoration(
                                hintText: '短信验证码',
                                hintStyle: TextStyle(
                                    color: HexColor.fromHex('#B7B7B7'),
                                    fontSize: 14.scale(),
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
                  ),
                  Divider(height: 0.5, color: HexColor.fromHex('#F0F0F0'),),
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
                          hintText: '请输入微信号',
                          hintStyle: TextStyle(
                              color: HexColor.fromHex('#B7B7B7'),
                              fontSize: 14.scale(),
                              fontWeight: FontWeight.normal,
                              fontFamily: MineUtil.fontFamily
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    height: 57.scale(),
                  ),
                  Divider(height: 0.5, color: HexColor.fromHex('#F0F0F0'),),
                  NormalButton(
                    child: NormalText.normal(
                        text: '确定',
                        fontSize: 15,
                        color: _decideEnable ? HexColor.fromHex('#ffffff') :  HexColor.fromHex('#666666')
                    ),
                    color: _decideEnable ? HexColor.fromHex('#FF324D') :  HexColor.fromHex('#F0F0F0'),
                    borderRadius: BorderRadius.circular(5.scale()),
                    height: 50.scale(),
                    margin: EdgeInsets.only(top: 20.scale(), bottom: 11.scale()),
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
                  NormalText.normal(
                    text: '绑定手机号以防数据丢失',
                    fontSize: 12,
                    color: HexColor.fromHex('#FF324D'),
                    textAlign: TextAlign.center,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
              )),

              padding: EdgeInsets.only(left: 20.scale(), right: 20.scale()),
              width: 300.scale(),
              height: 333.scale(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.scale()),
              ),
            ),
          );
        },
      ),
    );

  }
}