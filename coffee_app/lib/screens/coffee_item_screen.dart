import 'package:coffee_app/models/coffee_model.dart';
import 'package:coffee_app/providers/coffee.dart';
import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

import 'package:readmore/readmore.dart';
import '../providers/favorite.dart';

// burada datani navigatorun icinden oturecem sonra nese problem olsa deyiserem

class CoffeeItemScreen extends StatelessWidget {
  static const route = '/coffee_item_screen-route';

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as Map;
    final index = ModalRoute.of(context)!.settings.arguments as int;
    final elements = Provider.of<Coffee>(context).items;
    final cartItem = Provider.of<Cart>(context);
    final fav = Provider.of<Favorite>(context);
    return Scaffold(
        backgroundColor: Color.fromRGBO(32, 21, 32, 1),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(children: [
          Container(
            margin: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                  image: NetworkImage(elements[index].imageUrl),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  elements[index].name,
                  style: TextStyle(
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                IconButton(
                  iconSize: 35,
                  onPressed: () {
                    fav.toggleWithFavorite(elements[index]);
                    if (elements[index].isFavorite == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Item added to favorite list',
                          textAlign: TextAlign.center,
                        ),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            fav.toggleWithFavorite(elements[index]);
                          },
                          textColor: Theme.of(context).errorColor,
                        ),
                        duration: Duration(seconds: 2),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Item removed from favorite list',
                          textAlign: TextAlign.center,
                        ),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            fav.toggleWithFavorite(elements[index]);
                          },
                          textColor: Theme.of(context).errorColor,
                        ),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  icon: elements[index].isFavorite
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(
                          color: Color.fromRGBO(239, 227, 200, 1),
                          Icons.favorite_border_outlined,
                        ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  elements[index].info,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  size: 15,
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  elements[index].star.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 45,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ReadMoreText(
                elements[index].metaData,
                trimLines: 2,
                colorClickableText: Colors.white,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Read More',
                trimExpandedText: '...Less',
                style: TextStyle(color: Colors.white),
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decorationColor: Colors.white),
              ),
            ),
          ),
          /*SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),*/
          Padding(
            padding: EdgeInsets.only(left: 10, top: 90),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '\$${elements[index].price}',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.17,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromRGBO(239, 227, 200, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    //Navigator.of(context).pushReplacementNamed('/');
                    cartItem.addCartItem(elements[index]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        action: SnackBarAction(
                            label: 'UNDO',
                            textColor: Colors.red,
                            onPressed: () {
                              cartItem.removeCartItem(elements[index]);
                            }),
                        duration: Duration(seconds: 2),
                        content: Text(
                          'Added item to cart!',
                          textAlign: TextAlign.center,
                        )));

                    // add to chart funtion yaz bura
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(
                            color: Color.fromRGBO(74, 43, 41, 1), fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
