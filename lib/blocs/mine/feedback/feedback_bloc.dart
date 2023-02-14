import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idou/blocs/mine/feedback/feedback_event.dart';
import 'package:idou/blocs/mine/feedback/feedback_state.dart';
import 'dart:async';
import 'package:idou/network/mine/mine_api.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {


  FeedbackBloc() : super(FeedbackStateInitial());

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    if (event is FeedbackEventUploadComplete) {
      yield FeedbackStateUploadCompleted();
    }
    if (event is FeedbackEventUploadImage) {
      try {
        final url = await MineApi.uploadImg(event.image.path);
        yield FeedbackStateUploadSuccess(url: url, path: event.image.path);
      } catch (e) {
        yield FeedbackStateFailure('上传图片失败');
      }
    }
    if (event is FeedbackEventUpload) {
      try {
        final s = await MineApi.postWithFeedback(event.content, event.pic, event.contact);
        yield FeedbackStateSuccess();
      } catch (e) {
        yield FeedbackStateFailure(e is String ? e : '提交失败');
      }
    }
  }
}