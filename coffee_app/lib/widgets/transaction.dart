import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class Transaction extends StatefulWidget {
  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  //final formKey = GlobalKey<FormState>();
  var userCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String coupon = 'farid';

    var crt = Provider.of<Cart>(context, listen: true);
    double finalAmount = crt.totalPrice + crt.waiterTip + crt.taxes;
    return Container(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(125, 109, 73, 14),
                  Color.fromRGBO(184, 159, 160, 0.3),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.transparent)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Exit',
                                    style: TextStyle(
                                        color: Theme.of(context).errorColor),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    if (userCode.text == coupon) {
                                      setState(() {
                                        crt.taxes = 0;
                                        crt.waiterTip = 0;
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    'Apply',
                                    style: TextStyle(color: Colors.green),
                                  )),
                            ],
                            title: const Text('Enter Coupon code!'),
                            content: Form(
                              //key: formKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: TextFormField(
                                controller: userCode,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter here',
                                ),
                                validator: (value) {
                                  if (value != null && value.length < 5) {
                                    return 'More character is needed';
                                  } else if (value!.length >= 5 &&
                                      coupon != value) {
                                    return 'Coupon does not exist';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ));
                },
                child:const Text(
                  'Apply Coupon ',
                  style: TextStyle(fontSize: 16),
                )),
          ),
        const  SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child:const Text(
                    'Waiter Tip',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  child: Text(
                    '\$${crt.waiterTip}',
                    style:const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        const  SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    'Taxes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  child: Text(
                    '\$${crt.taxes}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        const  SizedBox(
            height: 10,
          ),
        const  Divider(
            color: Color.fromRGBO(255, 255, 255, 0.2),
            thickness: 2,
          ),
        const  SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    'Total Price',
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
                 Container(
                   child: Text(
                      '\$$finalAmount',
                      style:const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                 ),
                
              ],
            ),
          ),
        const  SizedBox(
            height: 10,
          ),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              margin:const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  style:const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromRGBO(239, 227, 200, 1))),
                  onPressed: () {},
                  child:const Text(
                    'PAY NOW',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(74, 43, 41, 1)),
                  ))),
        ],
      ),
    );
  }
}
