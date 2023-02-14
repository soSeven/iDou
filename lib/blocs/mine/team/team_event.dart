
abstract class TeamEvent {

  const TeamEvent();

}

class TeamEventInitial extends TeamEvent {

  const TeamEventInitial();

}

class TeamEventUser extends TeamEvent {

  final int number;

  const TeamEventUser({this.number});

}

class TeamEventBind extends TeamEvent{

  final int number;

  const TeamEventBind({this.number});

}

class TeamEventVip extends TeamEvent {

  final int number;

  const TeamEventVip({this.number});

}