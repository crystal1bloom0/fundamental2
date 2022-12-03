import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/detail_restaurant.dart';
import 'package:restaurant/model/restaurants.dart';
import 'package:restaurant/provider/custom_provider_restaurant.dart';
import 'package:restaurant/api/api_restaurant.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderSearch>(
      create: (_) => ProviderSearch(
        apiRestaurant: ApiRestaurant(),
      ),
      child: Consumer<ProviderSearch>(
        builder: (context, search, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cari restaurant'),
            ),
            body: SafeArea(
                child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: TextFormField(
                    onChanged: ((value) {
                      setState(() {
                        query = value;
                      });
                      search.DataSearch(value);
                    }),
                    decoration: const InputDecoration(
                        suffix: Icon(Icons.search),
                        hintText: 'Cari restaurant...'),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  child: query.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        ))
                      : _buildResult(context),
                )
              ],
            )),
          );
        },
      ),
    );
  }

  Widget _buildResult(BuildContext context) {
    return Consumer<ProviderSearch>(builder: (context, value, _) {
      if (value.state == CustomSearchState.loading) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.blue,
        ));
      } else if (value.state == CustomSearchState.hasData) {
        return Expanded(
          child: ListView.builder(
              itemCount: value.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = value.result.restaurants[index];
                return ResultSearchPage(restaurants: restaurant);
              }),
        );
      } else if (value.state == CustomSearchState.noData) {
        return const Center(
            child: Text(
                'The search you are looking for does not match any restaurant data'));
      } else if (value.state == CustomSearchState.error) {
        return const Center(
          child:
              Text('no internet network. please turn on the internet network'),
        );
      } else {
        return const Text('');
      }
    });
  }
}

class ResultSearchPage extends StatelessWidget {
  final Restaurant restaurants;

  const ResultSearchPage({Key? key, required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RestaurantDetailPage.routeName,
        arguments: restaurants.id,
      ),
      child: ListTile(
          leading: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                "https://restaurant-api.dicoding.dev/images/large/${restaurants.pictureId}",
              ),
            )),
          ),
          title: Text(restaurants.name),
          subtitle: Text(restaurants.city)),
    );
  }
}
