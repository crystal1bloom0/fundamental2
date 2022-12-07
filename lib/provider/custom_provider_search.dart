import 'package:flutter/material.dart';
import 'package:restaurant/api/api_service.dart';
import 'package:restaurant/model/search.dart';

enum ResultSearchState { loading, noData, hasData, error }

class ProviderSearch extends ChangeNotifier {
  final ApiRestaurant apiService;

  ProviderSearch({required this.apiService}) {
    DataSearch(query);
  }

  late RestarantSearchModel _searchRestaurant;
  late ResultSearchState _state;
  String _message = '';
  String _query = '';

  String get message => _message;

  String get query => _query;

  RestarantSearchModel get result => _searchRestaurant;

  ResultSearchState get state => _state;

  Future<dynamic> DataSearch(query) async {
    try {
      _state = ResultSearchState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantsearch(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultSearchState.noData;
        notifyListeners();
        return _message = 'Data masih kosong';
      } else {
        _state = ResultSearchState.hasData;
        notifyListeners();
        return _searchRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultSearchState.error;
      notifyListeners();
      return _message =
          'no internet network. please turn on the internet network';
    }
  }
}
