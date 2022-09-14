import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task/bloc/login_bloc/login_cubit.dart';
import 'package:task/bloc/register_bloc/register_cubit.dart';
import 'package:task/modules/home/home_screen.dart';
import 'package:task/modules/login/login_screen.dart';
import 'package:task/network/local/local.dart';
import 'package:task/network/remote/remote.dart';
import 'package:task/shared/constances.dart/constances.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CachHelper.init();
  DioHelper.init();

  AppConstances.token = await CachHelper.getData(key: 'token');
  Widget? startWidget;

  if (AppConstances.token != null) {
    startWidget = const HomeScreen();
  } else {
    startWidget = const LoginScreen();
  }

  runApp(MyApp(
    widget: startWidget,
  ));
}

//////computer
class MyApp extends StatelessWidget {
  final Widget? widget;
  const MyApp({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        supportedLocales: const [Locale('ar')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        builder: (context, child) {
          return  MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
        },
        home: widget,
      ),
    );
  }
}
