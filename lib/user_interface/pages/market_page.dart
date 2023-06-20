import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

import 'package:test_flutter/models/market_model.dart';
import 'package:test_flutter/state_management/market_cubit.dart';
import 'package:test_flutter/state_management/loading_more_state_cubit.dart';
import 'package:test_flutter/user_interface/pages/create_market_page.dart';
import 'package:test_flutter/user_interface/widgets/market_card.dart';
import 'package:test_flutter/user_interface/widgets/empty_list_widget.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  late bool searching;
  late Duration transitionDuration;
  late Curve transitionCurve;
  late TextEditingController searchController;
  String lastSearchQuery = "";

  @override
  void initState() {
    searching = false;
    transitionDuration = Duration(milliseconds: 250);
    transitionCurve = Curves.decelerate;
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = searching ? "Search" : "Markets";
    String titleKey = searching ? "title2" : "title1";
    String emptyListWidgetKey =
        searching ? "emptyListWidgetKey2" : "emptyListWidgetKey1";

    TextStyle titleStyle = TextStyle(fontSize: 18);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateMarketPage(),
              ));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: AppBar(
              title: AnimatedSwitcher(
                duration: transitionDuration,
                switchInCurve: transitionCurve,
                switchOutCurve: transitionCurve,
                layoutBuilder:
                    (Widget? currentChild, List<Widget> previousChildren) {
                  return Stack(
                    children: <Widget>[
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                    alignment: Alignment.topLeft,
                  );
                },
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  key: ValueKey<String>(titleKey),
                  style: titleStyle,
                ),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: transitionDuration,
                    switchInCurve: transitionCurve,
                    switchOutCurve: transitionCurve,
                    transitionBuilder: (child, animation) {
                      return FadeScaleTransition(
                        child: child,
                        animation: animation,
                      );
                    },
                    child: searching
                        ? Icon(
                            Icons.close,
                            key: ValueKey<String>("icon2"),
                          )
                        : Icon(
                            Icons.search,
                            key: ValueKey<String>("icon1"),
                          ),
                  ),
                  onPressed: () {
                    if (searching) {
                      searchController.clear();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (lastSearchQuery.isNotEmpty) {
                        lastSearchQuery = "";
                        reloadMarkets();
                      }
                    }
                    setState(() {
                      searching = !searching;
                    });
                  },
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                )
              ],
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            clipBehavior: Clip.none,
            height: searching ? 70 : 0,
            duration: transitionDuration,
            curve: transitionCurve,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: searchController,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.white.withOpacity(0.8),
                    cursorWidth: 1,
                    cursorHeight: 18,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 14),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (contains) {
                      lastSearchQuery = contains;
                      reloadMarkets();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      fillColor: Colors.black.withOpacity(0.3),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: BlocBuilder<MarketCubit, List<MarketModel>?>(
                    builder: (context, marketsList) {
                      if (marketsList == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (marketsList.isEmpty) {
                        return Center(
                          child: AnimatedSwitcher(
                            duration: transitionDuration,
                            switchInCurve: transitionCurve,
                            switchOutCurve: transitionCurve,
                            child: searching
                                ? emptySearchListIndicator(emptyListWidgetKey)
                                : emptyMarketsListIndicator(emptyListWidgetKey),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Expanded(
                            child:
                                NotificationListener<ScrollUpdateNotification>(
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 10, bottom: 60),
                                physics: AlwaysScrollableScrollPhysics(),
                                // itemCount = marketsList.length + 1 to build the loading-more indicator widget at the end of the list
                                itemCount: marketsList.length + 1,
                                itemBuilder: (context, index) {
                                  // loading-more indicator widget is built at the last index
                                  if (index == marketsList.length) {
                                    return loadingWidget();
                                  }
                                  return MarketCard(
                                    market: marketsList[index],
                                  );
                                },
                              ),
                              onNotification:
                                  (ScrollUpdateNotification notification) {
                                //para cargar más eventos al llegar al final de la lista
                                var metrics = notification.metrics;
                                if (metrics.extentAfter < 40 &&
                                    metrics.pixels != 0) {
                                  loadMoreMarkets();
                                }
                                return true;
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
              ),
              onRefresh: () async {
                if (searching) {
                  searchController.text = lastSearchQuery;
                }
                await reloadMarkets();
              },
            ),
          ),
        ],
      ),
    );
  }

  // loading indicator displayed at de end of the list when loadMoreMarkets() is called
  Widget loadingWidget() {
    return BlocBuilder<LoadingMoreStateCubit, bool>(
      builder: (context, loading) {
        return loading
            ? ProfileShimmer(
                isDisabledAvatar: true,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.5),
                  Theme.of(context).primaryColor.withOpacity(0.3),
                  Theme.of(context).primaryColor.withOpacity(0.1),
                ],
                hasCustomColors: true,
              )
            : Container();
      },
    );
  }

  Future<void> reloadMarkets() async {
    var marketsCubit = context.read<MarketCubit>();
    marketsCubit.clear();
    await marketsCubit.loadMarkets(
      contains: lastSearchQuery,
    );
  }

  Future<void> loadMoreMarkets() async {
    var loadingMoreStateCubit = context.read<LoadingMoreStateCubit>();
    if (!loadingMoreStateCubit.state) {
      loadingMoreStateCubit.startLoading();
      await context.read<MarketCubit>().loadMoreMarkets(
            contains: lastSearchQuery,
          );
      loadingMoreStateCubit.finishLoading();
    }
  }

  //widget displayed when search result is empty
  Widget emptySearchListIndicator(String emptyListWidgetKey) {
    return EmptyListWidget(
      key: ValueKey<String>(emptyListWidgetKey),
     
      text: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "There are no results for this search.",
            style: TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.transparent,
          ),
          Text(
            " Try searching another word.",
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  //widget displayed when markets list is empty
  Widget emptyMarketsListIndicator(String emptyListWidgetKey) {
    return EmptyListWidget(
      key: ValueKey<String>(emptyListWidgetKey),
      text: Text(
        "There is no market yet",
        style: TextStyle(color: Color(0xFF1F2937), fontSize: 14),
      ),
    );
  }
}
