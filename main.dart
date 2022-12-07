import 'package:flutter/material.dart';
import 'package:restaurant/home_restaurant.dart';
import 'package:restaurant/styles.dart';
import 'package:restaurant/list_restaurant.dart';
import 'package:restaurant/detail_restaurant.dart';
import 'package:restaurant/search_restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ristorante Six',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.white,
              secondary: secondaryColor,
              onBackground: Colors.black,
            ),
      ),
      initialRoute: RestaurantHomePage.routeName,
      routes: {
        RestaurantHomePage.routeName: (context) => RestaurantHomePage(),
        RestaurantListPage.routeName: (context) => RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
        RestaurantSearchPage.routeName: (context) => RestaurantSearchPage(),
      },
    );
  }
}
