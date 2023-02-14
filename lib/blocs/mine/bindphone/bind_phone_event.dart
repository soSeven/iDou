import 'package:flutter/cupertino.dart';

abstract class BindPhoneEvent {
  const BindPhoneEvent();
}

class BindPhoneEventPhoneComplete extends BindPhoneEvent {
  const BindPhoneEventPhoneComplete();
}

class BindPhoneEventPhoneNotComplete extends BindPhoneEvent {
  const BindPhoneEventPhoneNotComplete();
}

class BindPhoneEventCheckCodeGet extends BindPhoneEvent {
  final String phone;
  const BindPhoneEventCheckCodeGet({@required this.phone});
}

class BindPhoneEventComplete extends BindPhoneEvent {
  const BindPhoneEventComplete();
}

class BindPhoneEventNotComplete extends BindPhoneEvent {
  const BindPhoneEventNotComplete();
}

class BindPhoneEventUpload extends BindPhoneEvent {
  final String phone;
  final String checkCode;
  final String weChat;
  const BindPhoneEventUpload({@required this.phone, this.checkCode, this.weChat});
}