
import 'package:idou/bean/mine/team_sub_model.dart';

abstract class TeamSubState {

  const TeamSubState();

}

class TeamSubStateInitial extends TeamSubState {}

class TeamSubStateFailure extends TeamSubState {

  final String error;
  final bool isHeaderRefresh;

  const TeamSubStateFailure({this.error, this.isHeaderRefresh = false});

}

class TeamSubStateSuccess extends TeamSubState {

  final TeamSubModel model;
  final bool isHeaderRefresh;

  const TeamSubStateSuccess({this.model, this.isHeaderRefresh = false});


}