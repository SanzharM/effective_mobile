import 'package:effective_mobile/core/constants/app_colors.dart';
import 'package:effective_mobile/domain/blocs/main_screen/main_screen_bloc.dart';
import 'package:effective_mobile/ui/screens/main_screen/main_screen.dart';
import 'package:effective_mobile/ui/screens/nav_bar.dart';
import 'package:effective_mobile/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.lightGrey,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Concept',
      theme: AppTheme().defaultTheme,
      // navigatorKey: navigatrKey,
      home: BlocProvider<MainScreenBloc>(
        create: (_) => MainScreenBloc(),
        child: const NavBar(),
      ),
    );
  }
}
