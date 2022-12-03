import 'package:flutter/material.dart';
import 'package:restaurant/model/restaurants.dart';

class RestaurantSearch extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantSearch({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.place,
                    color: Colors.blue,
                    size: 15,
                  ),
                  Expanded(
                    child: Text(restaurant.city),
                  ),
                ],
              ),
            ),
            Container(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.blue,
                  size: 15,
                ),
                Expanded(
                  child: Text(restaurant.rating.toString()),
                ),
              ],
            )),
          ],
        ),
        onTap: () => Navigator.pushNamed(
          context,
          '/restaurant_detail',
          arguments: restaurant.id,
        ),
      ),
    );
  }
}
