import 'package:coffee_app/providers/coffee.dart';
import 'package:flutter/material.dart';
import 'homepage_screen.dart.dart';
import '../screens/cart_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/profile_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import 'package:badges/src/badge.dart' as badge;

import 'package:badges/badges.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  static const route = '/tab-screen';

  //const TabScreen({super.key});   bura key qosub yoxlayarsan gor scrollingde ferq edir?
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _pages = [
    MyHomePage(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  int _selectedIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _selectPage,
          elevation: 15,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromRGBO(34, 21, 31, 1),
          selectedItemColor: const Color.fromRGBO(239, 227, 200, 1),
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? Icons.home : Icons.home_outlined),
                label: 'home'),
            BottomNavigationBarItem(
                icon: cart.cartItem.isEmpty
                    ? Icon(_selectedIndex == 1
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined)
                    : badge.Badge(
                        animationType: BadgeAnimationType.fade,
                        badgeColor: Colors.red,
                        position:
                            BadgePosition.bottomStart(bottom: 7, start: 20),
                        badgeContent: Text(
                          '${cart.cartItem.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        child: Icon(_selectedIndex == 1
                            ? Icons.shopping_cart
                            : Icons.shopping_cart_outlined),
                      ),
                label: 'cart'),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 2
                    ? Icons.favorite
                    : Icons.favorite_outline),
                label: 'favorite'),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? Icons.person : Icons.person_outline),
                label: 'profile'),
          ]),
    );
  }
}
