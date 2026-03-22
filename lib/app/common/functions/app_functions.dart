
import 'package:crypto_lens/app/common/config/config.dart';
import 'package:crypto_lens/app/common/get_it/get_it.dart';
import 'package:crypto_lens/core/helpers/device/device_info_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AppFunctions {
  AppFunctions._();
  static final AppFunctions instance = AppFunctions._();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
    url: "https://okevphqzlonknmwewiuh.supabase.co",
    anonKey: "sb_publishable_fkfKA3ATjdOhcs7dyLZ6qw_n-hyf4tr",
  );

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
