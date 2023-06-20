import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/api_service/client.dart';
import 'package:test_flutter/api_service/repositories/market_repository.dart';
import 'package:test_flutter/models/market_model.dart';

class MarketCubit extends Cubit<List<MarketModel>?> {
  //to perform lazy loading
  final int limit = 20;

  MarketCubit() : super(null);

  Future<void> loadMarkets({String? contains}) async {
    List<MarketModel>? response = await MarketRepository(dioClient: dioClient)
        .getMarkets(offset: 0, limit: limit, contains: contains);

    if (response != null) {
      emit(response);
    }
  }

  Future<void> loadMoreMarkets({String? contains}) async {
    int offset = state?.length ?? 0;
    print("loading more");
    List<MarketModel>? response = await MarketRepository(dioClient: dioClient)
        .getMarkets(offset: offset, limit: limit, contains: contains);
    if (response != null) {
      if (state != null) {
        List<MarketModel> newState = state! + response;
        emit(newState);
      } else {
        emit(response);
      }
    }
  }

  Future<bool> createMarket(MarketModel market) async {
    bool response = await MarketRepository(dioClient: dioClient)
        .createMarket(market: market);
    if (response == true) loadMarkets();

    return response;
  }
  updateMarket(MarketModel market) async {
        bool response = await MarketRepository(dioClient: dioClient)
        .updateMarket(market: market);
    if (response == true) loadMarkets();

    return response;
  }

 
  clear() {
    emit(null);
  }

  deleteMarket(int id) async {
     bool response = await MarketRepository(dioClient: dioClient)
        .deleteMarket(id:id);
    if (response == true) loadMarkets();

    return response;
  }

}
