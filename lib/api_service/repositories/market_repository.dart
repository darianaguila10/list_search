import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_flutter/models/market_model.dart';

class MarketRepository {
  late final Dio dioClient;

  MarketRepository({
    required this.dioClient,
  });

  Future<List<MarketModel>?> getMarkets({
    required int offset,
    required int limit,
    String? contains,
  }) async {
    try {
      //fetch data
      var filter = (contains == null||contains.isEmpty) ? '' : 'name||cont||$contains';
      
      var response = await dioClient.get('/markets', queryParameters: {
        'offset': offset,
        'limit': limit,
        'sort': 'updatedAt,DESC',
        'filter': filter
      });

      print(response.realUri);
      List data = response.data['data'];

      return data.map((element) => MarketModel.fromJson(element)).toList();
    }
    //catch erros
    on DioError catch (e) {
      print('Error');
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
      } else {
        print(e.message);
      }
    }
  }

  Future<bool> createMarket({required MarketModel market}) async {
    try {
      var response =
          await dioClient.post('/markets', data: jsonEncode(market.toJson()));
      print(response);

      return true;
    }
    //catch erros
    on DioError catch (e) {
      print('Error');
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
      } else {
        print(e.message);
      }
      return false;
    }
  }

  Future<bool> updateMarket({required MarketModel market}) async {
    try {
      print(market.id);

      var response = await dioClient.put('/markets/${market.id}',
          data: jsonEncode(market.toJson()));
      print(response);

      return true;
    }
    //catch erros
    on DioError catch (e) {
      print('Error');
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
      } else {
        print(e.message);
      }
      return false;
    }
  }

  deleteMarket({required int id}) async {
    print(id);
    try {
      var response = await dioClient.delete('/markets/$id');
      print(response);

      return true;
    }
    //catch erros
    on DioError catch (e) {
      print('Error');
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
      } else {
        print(e.message);
      }
      return false;
    }
  }
}
