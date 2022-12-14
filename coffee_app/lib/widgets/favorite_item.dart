import 'package:flutter/material.dart';
import '../providers/favorite.dart';
import 'package:provider/provider.dart';

class FavoriteItem extends StatelessWidget {
  int i;
  FavoriteItem(this.i);
  @override
  Widget build(BuildContext context) {
    var fav = Provider.of<Favorite>(context, listen: true);
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(255, 255, 255, 0.1),
        ),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.only(left: 10),
        height: MediaQuery.of(context).size.height * 0.16,
        width: 120,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              height: 70,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(fav.favItems[i].imageUrl)))),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Text(
                  fav.favItems[i].name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    fav.favItems[i].info,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    '\$${fav.favItems[i].price}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(239, 227, 200, 1)),
              height: 50,
              width: 110,
              child: IconButton(
                  onPressed: () {
                    fav.toggleWithFavorite(fav.favItems[i]);
                  },
                  icon: fav.favItems[i].isFavorite
                      ? Icon(
                          Icons.favorite,
                          size: 35,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.favorite_border_outlined,
                          size: 35,
                        )))
        ]));
  }
}
