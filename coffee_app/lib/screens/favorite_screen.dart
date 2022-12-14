import '../widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import '../providers/favorite.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                  backgroundColor: Colors.white,
                ),
              ),
            );
          });
      await Provider.of<Favorite>(context, listen: false)
          .fetchAndSetFavs()
          .then((value) {
        Navigator.of(context).pop();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fav = Provider.of<Favorite>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 21, 32, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: fav.favItems.isEmpty
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Icon(
                      Icons.favorite_border_outlined,
                      size: 40,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Oops! Favorite list is empty.',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) => FavoriteItem(index),
                itemCount: fav.favItems.length),
      ),
    );
  }
}
