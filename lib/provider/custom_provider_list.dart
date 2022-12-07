import 'package:flutter/material.dart';
import 'package:restaurant/api/api_service.dart';
import 'package:restaurant/model/list.dart';

enum ResultListState { loading, noData, hasData, error }

class ProviderList extends ChangeNotifier {
  final ApiRestaurant apiService;

  ProviderList({required this.apiService}) {
    DataList();
  }

  late RestaurantListModel _restaurantResult;
  late ResultListState _state;
  String _message = '';

  String get message => _message;

  RestaurantListModel get result => _restaurantResult;

  ResultListState get state => _state;

  Future<dynamic> DataList() async {
    try {
      _state = ResultListState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantlist();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultListState.noData;
        notifyListeners();
        return _message = 'Data masih kosong';
      } else {
        _state = ResultListState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultListState.error;
      notifyListeners();
      return _message =
          'no internet network. please turn on the internet network';
    }
  }
}
