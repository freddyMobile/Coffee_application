import '../providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemFrame extends StatelessWidget {
  int i;
  final String imageUrl;
  final String name;
  final String info;
  final dynamic price;
  dynamic number;

  CartItemFrame({
    required this.i,
    required this.imageUrl,
    required this.name,
    required this.info,
    required this.price,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    var cartClass = Provider.of<Cart>(context, listen: true);
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'No',
                          style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 16),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 16),
                        )),
                  ],
                ));
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartClass.removeCartItem(cartClass.cartItem[i]);
      },
      key: ValueKey(cartClass.cartItem[i]),
      background: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).errorColor,
        ),
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.65),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(255, 255, 255, 0.1),
        ),
        margin: EdgeInsets.only(bottom: 15, right: 5),
        //padding: EdgeInsets.only(left: 30),
        height: MediaQuery.of(context).size.height * 0.16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(imageUrl)))),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      info,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      '\$$price',
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
              //margin: EdgeInsets.only(left: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(255, 255, 255, 0.08)),
              height: 35,
              width: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(239, 227, 200, 1)),
                      child: IconButton(
                        onPressed: () {
                          cartClass.decrease(
                              number, i); //burada provider ile qoy
                        },
                        icon: Icon(
                          Icons.remove,
                        ),
                        iconSize: 20,
                      )),
                  Text(
                    cartClass.cartItem[i].numberOfCf.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(239, 227, 200, 1)),
                      child: IconButton(
                        onPressed: () {
                          cartClass.increment(i);
                        },
                        icon: Icon(Icons.add),
                        iconSize: 20,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
