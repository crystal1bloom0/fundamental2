import 'package:flutter/material.dart';
import 'package:restaurant/detail_restaurant.dart';
import 'package:restaurant/model/restaurants.dart';
import 'package:restaurant/provider/custom_provider_restaurant.dart';
import 'package:restaurant/api/api_restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Ristorante Six',
            ),
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/restaurant_search',
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/restaurants.json'),
        builder: (context, snapshot) {
          Colors.black;
          final List<Restaurant> restaurant = parseRestaurant(snapshot.data);
          return ListView.builder(
            itemCount: restaurant.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurant[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Hero(
      tag: restaurant.pictureId,
      child: Image.network(
        restaurant.pictureId,
        width: 100,
      ),
    ),
    title: Text(restaurant.name),
    trailing: Text('rating ${restaurant.rating}'),
    subtitle: Text(restaurant.city),
    onTap: () {
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant);
    },
  );
}
