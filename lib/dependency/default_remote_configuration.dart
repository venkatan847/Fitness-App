import 'dart:async';

import 'package:template_package/template_package.dart';

class DefaultRemoteConfig implements RemoteConfiguration {
  DefaultRemoteConfig();

  @override
  String getString(String key) {
    throw UnimplementedError();
  }

  @override
  bool getBool(String key) {
    throw UnimplementedError();
  }

  @override
  Future<bool> fetchLatest() async {
    throw UnimplementedError();
  }

  @override
  double getDouble(String key) {
    throw UnimplementedError();
  }

  @override
  int getInt(String key) {
    throw UnimplementedError();
  }
}
