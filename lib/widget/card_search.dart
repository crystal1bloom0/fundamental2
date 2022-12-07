import 'package:flutter/material.dart';
import 'package:restaurant/model/search.dart';

class RestaurantSearch extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantSearch({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
            width: 100,
            height: 100,
          ),
        ),
        title: Text(restaurant.name),
        trailing: Text('rating ${restaurant.rating}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      restaurant.city,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 208, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () => Navigator.pushNamed(
          context,
          '/page_detail',
          arguments: restaurant.id,
        ),
      ),
    );
  }
}
