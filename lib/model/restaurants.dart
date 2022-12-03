import 'dart:convert';

CustomRestaurantListPage padangListPageFromJson(String str) =>
    CustomRestaurantListPage.fromJson(json.decode(str));

String padangListPageToJson(CustomRestaurantListPage data) =>
    json.encode(data.toJson());

CustomRestaurantSearch restaurantSearchPageFromJson(String str) =>
    CustomRestaurantSearch.fromJson(json.decode(str));

String restaurantSearchPageToJson(CustomRestaurantSearch data) =>
    json.encode(data.toJson());

CustomRestaurantDetailPage restaurantDetailPageFromJson(String str) =>
    CustomRestaurantDetailPage.fromJson(json.decode(str));

String restaurantDetailPageToJson(CustomRestaurantDetailPage data) =>
    json.encode(data.toJson());

class CustomRestaurantDetailPage {
  CustomRestaurantDetailPage({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  final bool error;
  final String message;
  final Restaurant restaurant;

  factory CustomRestaurantDetailPage.fromJson(Map<String, dynamic> json) =>
      CustomRestaurantDetailPage(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}

class CustomRestaurantSearch {
  CustomRestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  final List<Restaurant> restaurants;

  factory CustomRestaurantSearch.fromJson(Map<String, dynamic> json) =>
      CustomRestaurantSearch(
        error: json["eror"],
        founded: json["ditemukan"],
        restaurants: List<Restaurant>.from(
            json["restaurant"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "eror": error,
        "ditemukan": founded,
        "restaurant": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class CustomRestaurantListPage {
  CustomRestaurantListPage({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  factory CustomRestaurantListPage.fromJson(Map<String, dynamic> json) =>
      CustomRestaurantListPage(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      city: json["city"],
      rating: json["rating"].toDouble(),
      menus: Menus.fromJson(json["menus"]),
    );
  }

  get length => null;

  Map<String, Object> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Drink> foods;
  List<Drink> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class Drink {
  Drink({
    required this.name,
  });

  String name;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
