import 'dart:convert';
import 'package:restaurant/model/restaurants.dart';
import 'package:http/http.dart' as http;

class ApiRestaurant {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<CustomRestaurantListPage> restaurantlist() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return CustomRestaurantListPage.fromJson(json.decode(response.body));
    } else {
      throw ('no internet network. please turn on the internet network');
    }
  }

  Future<CustomRestaurantDetailPage> restaurantdetail(id) async {
    final response = await http.get(Uri.parse('${_baseUrl}detail/$id'));
    if (response.statusCode == 200) {
      return CustomRestaurantDetailPage.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'no internet network. please turn on the internet network');
    }
  }

  Future<CustomRestaurantSearch> restaurantsearch(query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return CustomRestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'no internet network. please turn on the internet network');
    }
  }
}
