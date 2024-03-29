import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/provider/custom_provider_detail.dart';
import 'package:restaurant/api/api_service.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/page_detail';

  final String id;

  RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderDetail>(
      create: (_) => ProviderDetail(apiService: ApiRestaurant(), id: id),
      child: Scaffold(body: Consumer<ProviderDetail>(
        builder: (context, state, child) {
          if (state.state == ResultDetailState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultDetailState.hasData) {
            final restaurant = state.result?.restaurant;
            return Scaffold(
                backgroundColor: Colors.black,
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Color.fromARGB(255, 255, 208, 0),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  const FavoriteButton(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Hero(
                          tag: restaurant!.pictureId,
                          child: Image.network(
                              "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}")),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                restaurant.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 208, 0),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    restaurant.city,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star_border_rounded,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    ' ${restaurant.rating}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: const Text(
                                "Deskripsi Restaurant",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              restaurant.description,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Menu makanan : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 208, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              height: 66,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: restaurant.menus.foods.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: Colors.transparent,
                                      child: Center(
                                        child: Text(
                                          restaurant.menus.foods[index].name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            const Text(
                              "Menu minuman : ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 208, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 26),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              height: 66,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: restaurant.menus.drinks.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: Colors.transparent,
                                      child: Center(
                                        child: Text(
                                          restaurant.menus.drinks[index].name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      const LikeButton(),
                      const DoesntLikeButton(),
                    ],
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.miniEndFloat,
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {},
                  shape: const StadiumBorder(
                      side: BorderSide(
                          color: Color.fromARGB(255, 255, 208, 0), width: 2)),
                  elevation: 1.5,
                  child: const Icon(
                    Icons.add_shopping_cart_rounded,
                    color: Color.fromARGB(255, 255, 208, 0),
                  ),
                ));
          } else if (state.state == ResultDetailState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultDetailState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      )),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButton createState() => _FavoriteButton();
}

class _FavoriteButton extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  _LikeButton createState() => _LikeButton();
}

class _LikeButton extends State<LikeButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite
            ? Icons.thumb_up_off_alt_rounded
            : Icons.thumb_up_off_alt_outlined,
        color: Colors.blue[600],
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

class DoesntLikeButton extends StatefulWidget {
  const DoesntLikeButton({Key? key}) : super(key: key);

  @override
  _DoesntLikeButtonState createState() => _DoesntLikeButtonState();
}

class _DoesntLikeButtonState extends State<DoesntLikeButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite
            ? Icons.thumb_down_alt_rounded
            : Icons.thumb_down_alt_outlined,
        color: Colors.blue[600],
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
