import 'package:coffee_app/models/coffee_model.dart';

import '../providers/cart.dart';
import 'package:coffee_app/screens/coffee_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coffee.dart';

class CoffeeFrame extends StatelessWidget {
  int i;
  List<CoffeeModel> listSearch;

  CoffeeFrame(this.i, this.listSearch);
  @override
  Widget build(BuildContext context) {
    var itemsCoffee = Provider.of<Coffee>(context, listen: true).items;
    var cart = Provider.of<Cart>(context);
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(CoffeeItemScreen.route, arguments: i),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(255, 255, 255, 0.1)),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(listSearch.isEmpty
                                    ? itemsCoffee[i].imageUrl
                                    : listSearch[i].imageUrl))),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(65, 65, 65, 0.9),
                            borderRadius: BorderRadius.only(
                                //bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        width: 50,
                        height: 25,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              size: 18,
                              Icons.star,
                              color: Color.fromRGBO(211, 166, 1, 1),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${itemsCoffee[i].star}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Text(
                    listSearch.isEmpty
                        ? itemsCoffee[i].name
                        : listSearch[i].name,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 255, 255, 0.08),
                    ),
                    height: 45,
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          listSearch.isEmpty
                              ? '\$${itemsCoffee[i].price}'
                              : '\$${listSearch[i].price}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(239, 227, 200, 1),
                          ),
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              cart.addCartItem(listSearch.isEmpty
                                  ? itemsCoffee[i]
                                  : listSearch[i]);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      action: SnackBarAction(
                                          label: 'UNDO',
                                          textColor: Colors.red,
                                          onPressed: () {
                                            cart.removeCartItem(
                                                listSearch.isEmpty
                                                    ? itemsCoffee[i]
                                                    : listSearch[i]);
                                          }),
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                        'Added item to cart!',
                                        textAlign: TextAlign.center,
                                      )));
                            },
                            icon: Icon(
                              Icons.shopping_cart_rounded,
                            ),
                            iconSize: 24,
                          ),
                          margin: EdgeInsets.only(left: 30),
                          //color: Color.fromRGBO(239, 227, 200, 1),
                          height: 45,
                          width: 45,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
