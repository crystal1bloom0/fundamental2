import 'package:flutter/material.dart';
import 'package:restaurant/model/restaurants.dart';
import 'package:restaurant/detail_restaurant.dart';

class RestaurantList extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantList({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        leading: Hero(
          tag:
              "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
            width: 200,
            height: 400,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.place,
                  color: Colors.blue,
                  size: 10,
                ),
                Expanded(
                  child: Text(restaurant.city),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 39, 110, 176),
                  size: 25,
                ),
                Expanded(
                  child: Text(restaurant.rating.toString()),
                ),
              ],
            )
          ],
        ),
        onTap: () => Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurant.id,
        ),
      ),
    );
  }
}
