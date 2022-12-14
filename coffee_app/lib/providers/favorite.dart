import 'dart:convert';
import '../models/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Favorite with ChangeNotifier {
  List<CoffeeModel> _favItems = [];
  final String authToken;
  Favorite(this.authToken, this._favItems);
  List<CoffeeModel> get favItems {
    return [..._favItems];
  }

  Future<void> fetchAndSetFavs() async {
    final url = Uri.parse(
        'https://coffee-app-b6342-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<CoffeeModel> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        if (prodData['isFavorite']) {
          loadedProducts.add(CoffeeModel(
              isFavorite: prodData['isFavorite'],
              firebaseId: prodId,
              name: prodData['name'],
              price: prodData['price']!,
              imageUrl: prodData['imageUrl'],
              metaData: prodData['metaData'],
              info: prodData['info'],
              star: prodData['star'],
              numberOfCf: prodData['numberOfCf'],
              perCoffeePrice: prodData['perCoffeePrice']));
        }
      });
      _favItems = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //bool isFavorite = false;
  toggleWithFavorite(CoffeeModel element) {
    element.isFavorite = !element.isFavorite;
    final url = Uri.parse(
        'https://coffee-app-b6342-default-rtdb.firebaseio.com/products/${element.firebaseId}.json?auth=$authToken');
    if (!element.isFavorite) {
      _favItems.remove(element);
    }
    http.patch(url, body: json.encode({'isFavorite': element.isFavorite}));
    notifyListeners();
  }

  

  void _removeFavorite(CoffeeModel model) {
    _favItems.remove(model);
    notifyListeners();
  }
}
