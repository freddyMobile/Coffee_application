import 'dart:convert';
import 'package:coffee_app/providers/cart.dart';
import 'package:flutter/material.dart';
import '../models/coffee_model.dart';
import 'package:http/http.dart' as http;

class Coffee with ChangeNotifier {
  List<CoffeeModel> _items = [];
  final String authToken;
  Coffee(this.authToken, this._items);

  List<CoffeeModel> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://coffee-app-b6342-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<CoffeeModel> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(CoffeeModel(
          firebaseId: prodId,
          isFavorite: prodData['isFavorite'],
          name: prodData['name'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          metaData: prodData['metaData'],
          info: prodData['info'],
          star: prodData['star'],
          numberOfCf: prodData['numberOfCf'],
          perCoffeePrice: prodData['perCoffeePrice'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
