
import 'package:idou/bean/mine/invite_post_model.dart';

abstract class InviteEvent {

  const InviteEvent();

}

class InviteFetched extends InviteEvent {

  const InviteFetched();

}

class InviteChangeIndex extends InviteEvent {

  final int index;

  const InviteChangeIndex({this.index});

}

class InviteSaveStart extends InviteEvent {

  const InviteSaveStart();

}

class InviteSave extends InviteEvent {

  final InvitePostModel model;

  const InviteSave({this.model});

}