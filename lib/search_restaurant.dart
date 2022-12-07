import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/model/search.dart';
import 'package:restaurant/provider/custom_provider_search.dart';
import 'package:restaurant/detail_restaurant.dart';
import 'package:restaurant/api/api_service.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/page_search';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPage();
}

class _RestaurantSearchPage extends State<RestaurantSearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderSearch>(
      create: (_) => ProviderSearch(
        apiService: ApiRestaurant(),
      ),
      child: Consumer<ProviderSearch>(
        builder: (context, search, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cari restaurant?'),
            ),
            body: SafeArea(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextFormField(
                    onChanged: ((value) {
                      setState(() {
                        query = value;
                      });
                      search.DataSearch(value);
                    }),
                    decoration: const InputDecoration(
                      focusColor: Colors.black,
                      hintText: 'Ketik nama restaurant...',
                    ),
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
      if (value.state == ResultSearchState.loading) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      } else if (value.state == ResultSearchState.hasData) {
        return Expanded(
          child: ListView.builder(
              itemCount: value.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = value.result.restaurants[index];
                return ResultPencarian(restaurants: restaurant);
              }),
        );
      } else if (value.state == ResultSearchState.noData) {
        return const Center(
            child: Text(
                'The search you are looking for does not match any restaurant data'));
      } else if (value.state == ResultSearchState.error) {
        return const Center(
          child:
              Text("no internet network. please turn on the internet network"),
        );
      } else {
        return const Text('');
      }
    });
  }
}

class ResultPencarian extends StatelessWidget {
  final Restaurant restaurants;

  const ResultPencarian({Key? key, required this.restaurants})
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
