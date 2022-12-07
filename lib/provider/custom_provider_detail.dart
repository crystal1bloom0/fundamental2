import 'package:flutter/material.dart';
import 'package:restaurant/api/api_service.dart';
import 'package:restaurant/model/detail.dart';

enum ResultDetailState { loading, noData, hasData, error }

class ProviderDetail extends ChangeNotifier {
  final ApiRestaurant apiService;
  final String id;

  ProviderDetail({required this.apiService, required this.id}) {
    DataDetail(id);
  }

  late RestaurantDetailModel? _restaurantResults;
  ResultDetailState _state = ResultDetailState.noData;
  String _message = '';

  String get message => _message;

  RestaurantDetailModel? get result => _restaurantResults;

  ResultDetailState get state => _state;

  Future<dynamic> DataDetail(id) async {
    try {
      _state = ResultDetailState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantdetail(id);

      _state = ResultDetailState.hasData;
      notifyListeners();
      return _restaurantResults = restaurant;
    } catch (e) {
      _state = ResultDetailState.error;
      notifyListeners();
      return _message =
          'no internet network. please turn on the internet network';
    }
  }
}
