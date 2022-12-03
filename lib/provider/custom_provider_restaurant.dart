import 'package:flutter/material.dart';
import 'package:restaurant/api/api_restaurant.dart';
import 'package:restaurant/model/restaurants.dart';

enum CustomDetailState { loading, noData, hasData, error }

enum CustomListState { loading, noData, hasData, error }

enum CustomSearchState { loading, noData, hasData, error }

class ProviderSearch extends ChangeNotifier {
  final ApiRestaurant apiRestaurant;

  ProviderSearch({required this.apiRestaurant}) {
    DataSearch(query);
  }

  late CustomRestaurantSearch _searchRestaurant;
  late CustomSearchState _state;
  String _message = '';
  String _query = '';

  String get message => _message;

  String get query => _query;

  CustomRestaurantSearch get result => _searchRestaurant;

  CustomSearchState get state => _state;

  Future<dynamic> DataSearch(query) async {
    try {
      _state = CustomSearchState.loading;
      notifyListeners();
      final restaurant = await apiRestaurant.restaurantsearch(query);
      if (restaurant.restaurants.isEmpty) {
        _state = CustomSearchState.noData;
        notifyListeners();
        return _message = 'Data masih kosong';
      } else {
        _state = CustomSearchState.hasData;
        notifyListeners();
        return _searchRestaurant = restaurant;
      }
    } catch (e) {
      _state = CustomSearchState.error;
      notifyListeners();
      return _message =
          'no internet network. please turn on the internet network';
    }
  }
}

class ProviderList extends ChangeNotifier {
  final ApiRestaurant apiRestaurant;
  final Restaurant restaurant;

  ProviderList(this.restaurant, {required this.apiRestaurant}) {
    DataList();
  }

  late CustomRestaurantListPage _restaurantResult;
  late CustomListState _state;
  String _message = '';

  String get message => _message;

  CustomRestaurantListPage get result => _restaurantResult;

  CustomListState get state => _state;

  Future<dynamic> DataList() async {
    try {
      _state = CustomListState.loading;
      notifyListeners();
      final restaurant = await apiRestaurant.restaurantlist();
      if (restaurant.restaurants.isEmpty) {
        _state = CustomListState.noData;
        notifyListeners();
        return _message = 'Data masih kosong';
      } else {
        _state = CustomListState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = CustomListState.error;
      notifyListeners();
      return _message =
          'no internet network. please turn on the internet network';
    }
  }
}

class ProviderDetail extends ChangeNotifier {
  final ApiRestaurant apiRestaurant;
  final Restaurant restaurant;

  String _message = '';

  String get message => _message;

  ProviderDetail(this.restaurant, {required this.apiRestaurant}) {
    DataDetail(restaurant);
  }

  late CustomRestaurantDetailPage? _restaurantResults;
  CustomDetailState _state = CustomDetailState.noData;

  CustomRestaurantDetailPage? get result => _restaurantResults;

  CustomDetailState get state => _state;

  Future<dynamic> DataDetail(id) async {
    try {
      _state = CustomDetailState.loading;
      notifyListeners();
      final restaurant = await apiRestaurant.restaurantdetail(id);

      _state = CustomDetailState.hasData;
      notifyListeners();
      return _restaurantResults = restaurant;
    } catch (e) {
      _state = CustomDetailState.error;
      notifyListeners();
      return _message =
          'no internet network. please turn on the internet network';
    }
  }
}
