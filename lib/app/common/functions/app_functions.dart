
import 'package:crypto_lens/app/common/config/config.dart';
import 'package:crypto_lens/app/common/get_it/get_it.dart';
import 'package:crypto_lens/core/helpers/device/device_info_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class AppFunctions {
  AppFunctions._();
  static final AppFunctions instance = AppFunctions._();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(
    //     widgetsBinding: ensureInitialized); //Splash'te silmelisin
    await DeviceInfoHelper.instance.init();
    Config.currentEnvironment = Environment.development;
//ServiceLocator().setup();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
