import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:test_flutter/core/notification_service.dart';

import 'package:test_flutter/models/market_model.dart';
import 'package:test_flutter/state_management/market_cubit.dart';
import 'package:test_flutter/user_interface/pages/edit_market_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketDetailPage extends StatefulWidget {
  static const String routeName = "marketDetail";

  final MarketModel market;

  const MarketDetailPage({
    Key? key,
    required this.market,
  }) : super(key: key);

  @override
  _MarketDetailPageState createState() => _MarketDetailPageState();
}

class _MarketDetailPageState extends State<MarketDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [     IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        title: Text("Delete market"),
                        content: Text("¿Are you sure to delete market?"),
                        actionsPadding: EdgeInsets.all(5),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text("cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text("accept"),
                            onPressed: () async {
                              var marketsCubit = context.read<MarketCubit>();
                              bool resp = await marketsCubit
                                  .deleteMarket(widget.market.id!);
                              if (resp) {
                                NotificationService.showSnackBar(
                                    "The new market has been successfully delete.");
                              } else {
                                NotificationService.showSnackBar(
                                    "There has been an error in the insertion. Try again");
                              }
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              })
       ,
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                Navigator.of(context).pop();
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditMarketPage(
                        market: widget.market,
                      ),
                    ));
              })
        ],
        title: Text(
          widget.market.symbol!,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Material(
                  elevation: 10,
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                    top: Radius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.market.name ?? "-",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7F8CDB)),
                        ),
                        Divider(
                          height: 32,
                          color: Color(0xFFE5E7EB),
                          thickness: 1,
                        ),
                        ...getMargetDetails(widget.market),
                        Divider(
                          height: 32,
                          color: Color(0xFFE5E7EB),
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF6B7280),
                              size: 20,
                            ),
                            VerticalDivider(
                              color: Colors.transparent,
                              width: 10,
                            ),
                            Text(
                              widget.market.createdAt != null
                                  ? DateFormat.yMMMMd('en_US')
                                      .format(widget.market.createdAt!)
                                  : "-",
                              style: TextStyle(
                                  color: Color(0xFF6B7280), fontSize: 14),
                            ),
                            VerticalDivider(
                              color: Colors.transparent,
                              width: 26,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

getMargetDetails(MarketModel market) {
  Map map = market.toMap();
  List<Widget> lis = [];

  map.forEach((key, value) {
    lis.add(rowGenerate(key, value));
  });
  return lis;
}

rowGenerate(String? left, String? right) {
  return Column(children: [
    Row(
      children: [
        Text(
          left != null ? left.toString() + ": " : "-",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        Flexible(
          child: Text(
            right != null ? right.toString() : "-",
            style: TextStyle(
              fontSize: 15,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    Divider(
      height: 15,
      color: Colors.transparent,
      thickness: 1,
    ),
  ]);
}
