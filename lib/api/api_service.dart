import 'dart:convert';
import 'package:restaurant/model/list.dart';
import 'package:restaurant/model/detail.dart';
import 'package:restaurant/model/search.dart';
import 'package:http/http.dart' as http;

class ApiRestaurant {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantListModel> restaurantlist() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantListModel.fromJson(json.decode(response.body));
    } else {
      throw ('no internet network. please turn on the internet network');
    }
  }

  Future<RestaurantDetailModel> restaurantdetail(id) async {
    final response = await http.get(Uri.parse('${_baseUrl}detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'no internet network. please turn on the internet network');
    }
  }

  Future<RestarantSearchModel> restaurantsearch(query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return RestarantSearchModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'no internet network. please turn on the internet network');
    }
  }
}
