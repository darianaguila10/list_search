import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/notification_service.dart';
import 'package:test_flutter/state_management/market_cubit.dart';

import 'package:test_flutter/user_interface/pages/home_page.dart';
import 'package:routemaster/routemaster.dart';

import 'state_management/loading_more_state_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

final routes = RouteMap(
  routes: {
    '/': (_) => MaterialPage(child: HomePage()),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      key: ValueKey<String>("MarketPage"),
      providers: [
        BlocProvider(
          create: (context) => MarketCubit()..loadMarkets(),
        ),
        BlocProvider(
          create: (context) => LoadingMoreStateCubit(),
        ),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: NotificationService.messengerKey,
        theme: ThemeData(
          primaryColor: Color(0xFF3882E4),
       
          appBarTheme: AppBarTheme(brightness: Brightness.dark),
        ),
        routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
        routeInformationParser: RoutemasterParser(),
      ),
    );
  }
}
