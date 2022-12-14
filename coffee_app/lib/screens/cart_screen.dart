import 'package:coffee_app/models/coffee_model.dart';

import '../providers/cart.dart';
import '../widgets/cart_item_frame.dart';
import '../widgets/transaction.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {

  static const route = 'cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
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

      await Provider.of<Cart>(context, listen: false)
          .fetchAndSetCart()
          .then((_) => Navigator.of(context).pop());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var crtItem = Provider.of<Cart>(context, listen: true).cartItem;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 21, 32, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: crtItem.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: const [
                    SizedBox(
                      height: 40,
                    ),
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 40,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Oops! Cart is empty.',
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 17),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => CartItemFrame(
                              i: index, //buradaki indexi oturmek vacib idi bizim ucun
                              number: crtItem[index].numberOfCf, //default
                              imageUrl: crtItem[index].imageUrl,
                              name: crtItem[index].name,
                              info: crtItem[index].info,
                              price: crtItem[index].price,
                            ),
                        itemCount: crtItem.length),
                  ),
                  const Divider(
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                    thickness: 2,
                  ),
                  Transaction(),
                ],
              ),
            ),
    );
  }
}
