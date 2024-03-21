import 'dart:convert';
import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

class RemoteConfigController extends GetxController {
  Map<String, dynamic> remoteConfigData = {};

  Future<Map<String, dynamic>> fetchRemoteConfig({
    BuildContext? context,
  }) async {
    RemoteConfigValue remoteValue;
    try {
      final baseRemoteConfig = BaseRemoteConfig();
      final remoteConfig = await baseRemoteConfig.initRemoteConfig();

      String configKey = dotenv.env['ENV'] == 'DEV'
          ? ConstantRemoteConfigValue.configKeyDev
          : ConstantRemoteConfigValue.configKeyProd;

      remoteValue = remoteConfig.getValue(configKey);
      remoteConfigData = json.decode(remoteValue.asString());
      return remoteConfigData;
    } catch (e) {
      log(e.toString());
    }
    return remoteConfigData;
  }

  Map<String, String>? get en {
    return Map.from(remoteConfigData["language"]?["en"] ?? {});
  }

  Map<String, String>? get km {
    return Map.from(remoteConfigData["language"]?["km"] ?? {});
  }

  bool get isUpdateLanguage {
    return false;
  }

}

class BaseRemoteConfig {
  late FirebaseRemoteConfig baseRemoteConfig;

  BaseRemoteConfig() {
    baseRemoteConfig = FirebaseRemoteConfig.instance;
  }

  Future<FirebaseRemoteConfig> initRemoteConfig() async {
    await baseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await baseRemoteConfig.fetchAndActivate();
    return baseRemoteConfig;
  }
}
