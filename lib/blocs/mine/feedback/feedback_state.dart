import 'package:flutter/cupertino.dart';

abstract class FeedbackState {
  const FeedbackState();
}

class FeedbackStateInitial extends FeedbackState {}

class FeedbackStateFailure extends FeedbackState {
  final String error;
  const FeedbackStateFailure(this.error);
}

class FeedbackStateUploadCompleted extends FeedbackState {}

class FeedbackStateUploadSuccess extends FeedbackState {
  final String url;
  final String path;
  const FeedbackStateUploadSuccess({@required this.url, @required this.path});
}

class FeedbackStateSuccess extends FeedbackState {}
