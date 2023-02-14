import 'package:flutter/material.dart';

import 'bloc_provider.dart';

typedef void ValueCallback<T>(T value);

abstract class AppBlocBase implements BlocBase {
  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  @mustCallSuper
  @override
  void dispose() {
    _isDisposed = true;
  }

  Future callApi<T>(Future<T> future, ValueCallback onSuccess,
      {Function(dynamic e) onError}) {
    return future.then((value) {
      // do nothing if already disposed
      if (_isDisposed) {
        return;
      }
      onSuccess(value);
    }).catchError((e) {
      print("####  $e");
      // do nothing if already disposed
      if (_isDisposed) {
        return;
      }
      if (onError != null) onError(e);
    });
  }
}
