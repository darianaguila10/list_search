import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/state_management/market_cubit.dart';
import 'package:test_flutter/state_management/loading_more_state_cubit.dart';
import 'package:test_flutter/user_interface/pages/market_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedTab;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(),
      extendBody: true,
    );
  }

  getPage() {
    return MarketPage();
  }
}
