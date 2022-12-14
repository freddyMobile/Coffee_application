import 'package:coffee_app/models/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cart with ChangeNotifier {
  
  List<CoffeeModel> _cartItem = [];
  final String authToken;
  Cart(this.authToken,this._cartItem);
  List<CoffeeModel> get cartItem {
    return [..._cartItem];
  }

  Future<void> addCartItem(CoffeeModel element) async {
    final url = Uri.parse(
        'https://coffee-app-b6342-default-rtdb.firebaseio.com/cart.json?auth=$authToken');
    try {
      // you should add logic here
      if (!_cartItem.contains(element)) {
        _cartItem.add(element);
        await http.post(url,
            body: json.encode({
              "firebaseId": element.firebaseId,
              "imageUrl": element.imageUrl,
              "info": element.info,
              "isFavorite": element.isFavorite,
              "metaData": element.metaData,
              "name": element.name,
              "numberOfCf": element.numberOfCf,
              "perCoffeePrice": element.perCoffeePrice,
              "price": element.price,
              "star": element.star,
            }));
        notifyListeners();
      } else {
        return;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetCart() async {
    //_cartItem = [];
    final url = Uri.parse(
        'https://coffee-app-b6342-default-rtdb.firebaseio.com/cart.json?auth=$authToken');
    try {
      var response = await http.get(url);
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (_cartItem.isEmpty && extractedData.isEmpty) {
        _cartItem = _cartItem;
        notifyListeners();
      } else {
        var response = await http.get(url);
        var extractedData = json.decode(response.body) as Map<String, dynamic>;
        List<CoffeeModel> loadedProds = [];
        extractedData.forEach((cyripticId, cyripticData) {
          loadedProds.add(CoffeeModel(
              firebaseId: cyripticId,
              name: cyripticData['name'],
              price: cyripticData['price'],
              imageUrl: cyripticData['imageUrl'],
              metaData: cyripticData['metaData'],
              info: cyripticData['info'],
              star: cyripticData['star'],
              numberOfCf: cyripticData['numberOfCf'],
              perCoffeePrice: cyripticData['perCoffeePrice']));
        });

        _cartItem = loadedProds;
        notifyListeners();
      }
    } catch (error) {
      _cartItem = [];
    }
  }

  void removeCartItem(CoffeeModel element) async {
    _cartItem.remove(element);
    final url = Uri.parse(
        'https://coffee-app-b6342-default-rtdb.firebaseio.com/cart/${element.firebaseId}.json?auth=$authToken');
    await http.delete(url);

    notifyListeners();
  }

  double get totalPrice {
    return sumTotal1();
  }

  double sumTotal1() {
    double totalPrice = 0;
    //it is for when the cart page firstly loads...
    CoffeeModel element;
    for (element in cartItem) {
      totalPrice += element.perCoffeePrice;
    }

    //notifyListeners();  it is not allowed to use it...
    return totalPrice;
  }

  void increment(index) {
    dynamic totalPrice = 0;

    cartItem[index].numberOfCf += 1;
    dynamic _perCoffeePrice =
        cartItem[index].price * cartItem[index].numberOfCf;

    cartItem.elementAt(index).perCoffeePrice = _perCoffeePrice;
    CoffeeModel element;
    //burada default 0 goturme!!! gelecekde bir sey fikirles

    for (element in cartItem) {
      totalPrice += element.perCoffeePrice;
    }

    notifyListeners();
  }

  void decrease(number, index) {
    if (cartItem[index].numberOfCf > 1) {
      dynamic totalPrice = 0;
      cartItem[index].numberOfCf -= 1;

      dynamic _perCoffeePrice =
          cartItem[index].price * cartItem[index].numberOfCf;
      cartItem.elementAt(index).perCoffeePrice = _perCoffeePrice;
      CoffeeModel element;

      for (element in cartItem) {
        totalPrice += element.perCoffeePrice;
      }
    }
    notifyListeners();
  }

  // burada total amount hesablamaq lazimdir
  double taxes = 5;
  double waiterTip = 3;
}
