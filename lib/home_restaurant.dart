import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/api/api_service.dart';
import 'package:restaurant/provider/custom_provider_list.dart';
import 'package:restaurant/list_restaurant.dart';

class RestaurantHomePage extends StatelessWidget {
  static const routeName = '/page_home';

  const RestaurantHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChangeNotifierProvider<ProviderList>(
                create: (_) => ProviderList(apiService: ApiRestaurant()),
                child: const RestaurantListPage())));
  }
}
