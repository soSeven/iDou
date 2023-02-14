
import 'package:idou/bean/mine/invite_post_model.dart';

abstract class InviteState {

  const InviteState();

}

class InviteInitial extends InviteState {}

class InviteFailure extends InviteState {}

class InviteSuccess extends InviteState {

  final List<InvitePostModel> result;

  const InviteSuccess({this.result});

}

class InviteIndex extends InviteState {

  final int index;

  const InviteIndex({this.index});

}

class InviteSaveLoading extends InviteState {}

class InviteSaveFailure extends InviteState {}

class InviteSaveSuccess extends InviteState {}