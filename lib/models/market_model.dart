// To parse this JSON data, do
//
//     final market = marketFromJson(jsonString);

import 'dart:convert';

List<MarketModel> marketFromJson(String str) => List<MarketModel>.from(
    json.decode(str).map((x) => MarketModel.fromJson(x)));

String marketToJson(List<MarketModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarketModel {
  MarketModel({
    this.symbol,
    this.name,
    this.country,
    this.industry,
    this.ipoYear,
    this.marketCap,
    this.sector,
    this.volume,
    this.netChange,
    this.netChangePercent,
    this.lastPrice,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String? symbol;
  String? name;
  String? country;
  String? industry;
  int? ipoYear;
  int? marketCap;
  String? sector;
  double? volume;
  double? netChange;
  double? netChangePercent;
  double? lastPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? id;

  factory MarketModel.fromJson(Map<String, dynamic> json) => MarketModel(
        symbol: json["symbol"],
        name: json["name"],
        country: json["country"],
        industry: json["industry"],
        ipoYear: json["ipoYear"],
        marketCap: json["marketCap"],
        sector: json["sector"],
        volume: json["volume"] != null ? json["volume"].toDouble() : 0,
        netChange: json["netChange"]!=null?json["netChange"].toDouble():0,
        netChangePercent: json["netChangePercent"]!=null?json["netChangePercent"].toDouble():0,
        lastPrice:json["lastPrice"]!=null? json["lastPrice"].toDouble():0,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "country": country,
        "industry": industry,
        "ipoYear":  ipoYear,
        "marketCap": marketCap,
        "sector": sector,
        "volume": volume,
        "netChange": netChange,
        "netChangePercent": netChangePercent,
        "lastPrice": lastPrice,
        "id": id,
      };
  Map<String, dynamic> toMap() => {
        "country": country,
        "industry": industry,
        "ipoYear": ipoYear.toString(),
        "marketCap": marketCap.toString(),
        "sector": sector.toString(),
        "volume": volume.toString(),
        "netChange": netChange.toString(),
        "netChangePercent": netChangePercent.toString(),
        "lastPrice": lastPrice.toString(),
        "id": lastPrice.toString()
      };
}
