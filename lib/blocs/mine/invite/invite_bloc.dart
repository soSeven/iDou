
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idou/blocs/mine/invite/invite_event.dart';
import 'package:idou/blocs/mine/invite/invite_state.dart';
import 'dart:async';
import 'package:idou/network/mine/mine_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class InviteBloc extends Bloc<InviteEvent, InviteState> {

  InviteBloc() : super(InviteInitial());

  @override
  Stream<InviteState> mapEventToState(InviteEvent event) async* {
    if (event is InviteFetched) {
      try {
        final messages = await MineApi.postWithPostList();
        if (messages == null) {
          yield InviteFailure();
        } else {
          yield InviteSuccess(result: messages);
        }
      } catch (e) {
        yield InviteFailure();
      }
    }
    if (event is InviteChangeIndex) {
      yield InviteIndex(index: event.index);
    }
    if (event is InviteSave) {
      try {
        final result = await _saveImage(event.model.bgImg);
        yield result ? InviteSaveSuccess() : InviteSaveFailure();
      } catch (e) {
        yield InviteSaveFailure();
      }
    }
  }

  Future<bool> _saveImage(String url) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    final s = statuses[Permission.storage];
    if (s == PermissionStatus.granted) {
      var appDocDir = await getTemporaryDirectory();
      String savePath = appDocDir.path + "/temp.png";
      String fileUrl = url;
      await Dio().download(fileUrl, savePath);
      final result = await ImageGallerySaver.saveFile(savePath);
      if (result is bool) {
        return result;
      }
      return false;
    } else {
      return false;
    }

  }

}