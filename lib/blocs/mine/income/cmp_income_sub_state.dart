import 'package:idou/bean/mine/cpm_income_model.dart';

abstract class CmpInComeSubState {

  const CmpInComeSubState();

}

class CmpInComeSubStateInitial extends CmpInComeSubState {}

class CmpInComeSubStateFailure extends CmpInComeSubState {

  final String error;
  final bool isHeaderRefresh;

  const CmpInComeSubStateFailure({this.error, this.isHeaderRefresh = false});

}

class CmpInComeSubStateSuccess extends CmpInComeSubState {

  final CpmIncomeModel model;
  final bool isHeaderRefresh;

  const CmpInComeSubStateSuccess({this.model, this.isHeaderRefresh = false});


}