import 'package:crypto_lens/app/common/config/config.dart';
import 'package:crypto_lens/app/common/get_it/get_it.dart';
import 'package:crypto_lens/core/helpers/device/device_info_helper.dart';
import 'package:crypto_lens/core/services/hive/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AppFunctions {
  AppFunctions._();
  static final AppFunctions instance = AppFunctions._();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Supabase.initialize(
      url: "https://okevphqzlonknmwewiuh.supabase.co",
      anonKey: "sb_publishable_fkfKA3ATjdOhcs7dyLZ6qw_n-hyf4tr",
    );

    ServiceLocator.setup();
    await dotenv.load(fileName: ".env");
    await DeviceInfoHelper.instance.init();
    Config.currentEnvironment = Environment.development;
    await getIt<HiveService>().init();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
