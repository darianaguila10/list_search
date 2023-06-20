import 'package:flutter/material.dart';
import 'package:test_flutter/core/notification_service.dart';
import 'package:test_flutter/models/market_model.dart';
import 'package:test_flutter/state_management/market_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditMarketPage extends StatefulWidget {
  static const String routeName = "EditMarketPage";
  final MarketModel market;
  const EditMarketPage({required this.market});

  @override
  _EditMarketPageState createState() => _EditMarketPageState();
}

class _EditMarketPageState extends State<EditMarketPage> {
  GlobalKey<FormState> _keyForm = new GlobalKey();

  MarketModel market = new MarketModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
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
        ],
        title: Text('Edit market ${widget.market.name}'),
      ),
      body: getForm(),
    );
  }

  getForm() {
    return Container(
      child: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(22),
        child: Form(
            key: _keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  initialValue: (widget.market.name != null)
                      ? widget.market.name.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validate,
                  maxLength: 20,
                  onSaved: (value) {
                    market.name = value;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "Name",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.symbol != null)
                      ? widget.market.symbol.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validate,
                  maxLength: 20,
                  onSaved: (value) {
                    market.symbol = value;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "Symbol",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.country != null)
                      ? widget.market.country.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  onSaved: (value) {
                    market.country = value;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "Country",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.industry != null)
                      ? widget.market.industry.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  onSaved: (value) {
                    market.industry = value;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "Industry",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.ipoYear != null)
                      ? widget.market.ipoYear.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value != null && value.length > 0)
                      market.ipoYear = int.parse(value);
                    else
                      market.ipoYear = 0;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "IpoYear",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.marketCap != null)
                      ? widget.market.marketCap.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value != null && value.length > 0)
                      market.marketCap = int.parse(value);
                    else
                      market.marketCap = 0;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "MarketCap",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.sector != null)
                      ? widget.market.sector.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  onSaved: (value) {
                    market.sector = value;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "Sector",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.volume != null)
                      ? widget.market.volume.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value != null && value.length > 0)
                      market.volume = double.parse(value);
                    else
                      market.volume = 0;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "Volume",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.netChange != null)
                      ? widget.market.netChange.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value != null && value.length > 0)
                      market.netChange = double.parse(value);
                    else
                      market.netChange = 0;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "NetChange",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.netChangePercent != null)
                      ? widget.market.netChangePercent.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value != null && value.length > 0)
                      market.netChangePercent = double.parse(value);
                    else
                      market.netChangePercent = 0;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "netChangePercent",
                      icon: Icon(Icons.description_outlined)),
                ),
                TextFormField(
                  initialValue: (widget.market.lastPrice != null)
                      ? widget.market.lastPrice.toString()
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value != null && value.length > 0)
                      market.lastPrice = double.parse(value);
                    else
                      market.lastPrice = 0;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: "LastPrice",
                      icon: Icon(Icons.description_outlined)),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                    SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text("accept"),
                        onPressed: () {
                          createMarket(context);
                        })
                  ],
                )
              ],
            )),
      )),
    );
  }

  Future<void> createMarket(BuildContext context) async {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      var marketsCubit = context.read<MarketCubit>();
      market.id=widget.market.id;
      bool resp = await marketsCubit.updateMarket(market);
      if (resp) {
        NotificationService.showSnackBar(
            "The new market has been successfully edited.");
        Navigator.of(context).pop();
      } else {
        NotificationService.showSnackBar(
            "There has been an error in the insertion. Try again");
      }
    } else {
      NotificationService.showSnackBar("Check, there are empty fields.");
    }
  }

  String? validate(String? value) {
    if (value != null && value.length == 0) return "Is empty";

    return null;
  }
}
