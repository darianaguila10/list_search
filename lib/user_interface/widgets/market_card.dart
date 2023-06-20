import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter/models/market_model.dart';
import 'package:test_flutter/user_interface/pages/market_detail_page.dart';

class MarketCard extends StatefulWidget {
  final MarketModel market;

  const MarketCard({
    Key? key,
    required this.market,
  }) : super(key: key);

  @override
  _MarketCardState createState() => _MarketCardState();
}

class _MarketCardState extends State<MarketCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MarketDetailPage(
                  market: widget.market,
                ),
              ));
          if (mounted) {
            setState(() {});
          }
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.market.symbol!,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[500]),
              ),
              Divider(
                height: 15,
                color: Color(0xFFE5E7EB),
                thickness: 1,
              ),
              Text(
                widget.market.name!,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
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
                    style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                  ),
                      SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
