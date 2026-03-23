import 'package:crypto_lens/app/common/constants/app_theme_data.dart';
import 'package:crypto_lens/app/common/functions/app_functions.dart';
import 'package:crypto_lens/app/common/get_it/get_it.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_event.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_event.dart';
import 'package:crypto_lens/app/features/presentation/login/view/login_view.dart';
import 'package:crypto_lens/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:crypto_lens/core/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppFunctions.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // main.dart içindeki providers kısmı
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>()..add(const FetchHomeData()),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) =>
              getIt<FavoritesBloc>()..add(const FetchFavoritesData()),

          // Kendi event ismini yaz
        ),
      ],
      child: MaterialApp(
        navigatorKey: Navigation.navigationKey,
        theme: AppThemeData.themeData,
        scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,

        debugShowCheckedModeBanner: false,
        home: const LoginView(),
      ),
    );
  }
}
