import 'package:flutter/material.dart';

class CoffeeModel {
  final String firebaseId;
  final String name;
  final dynamic price;
  final String imageUrl;
  final String info;
  final String metaData;
  final dynamic star;
  dynamic numberOfCf;
  dynamic perCoffeePrice;
  bool isFavorite;

  CoffeeModel({
    required this.firebaseId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.metaData,
    required this.info,
    required this.star,
    required this.numberOfCf,
    required this.perCoffeePrice,
    this.isFavorite = false,
  });
}
