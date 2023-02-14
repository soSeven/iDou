import 'package:flutter/cupertino.dart';

abstract class BindPhoneState {
  const BindPhoneState();
}

class BindPhoneStateInitial extends BindPhoneState {}

class BindPhoneStateFailure extends BindPhoneState {
  final String error;
  const BindPhoneStateFailure(this.error);
}

class BindPhoneStatePhoneNotCompleted extends BindPhoneState {}

class BindPhoneStatePhoneCompleted extends BindPhoneState {}

class BindPhoneStateCheckCodeGetSuccess extends BindPhoneState {}

class BindPhoneStateCheckCodeGetFailure extends BindPhoneState {}

class BindPhoneStateCompleted extends BindPhoneState {}

class BindPhoneStateNotCompleted extends BindPhoneState {}

class BindPhoneStateSuccess extends BindPhoneState {}
