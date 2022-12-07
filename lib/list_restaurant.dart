import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/widget/card_restaurant.dart';
import 'package:restaurant/provider/custom_provider_list.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/page_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 208, 0),
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
                  '/page_search',
                );
              },
            ),
          ],
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<ProviderList>(
      builder: (context, state, _) {
        if (state.state == ResultListState.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color.fromARGB(255, 255, 208, 0),
          ));
        } else if (state.state == ResultListState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return RestaurantList(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultListState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultListState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(),
          );
        }
      },
    );
  }
}
