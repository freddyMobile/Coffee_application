import 'package:coffee_app/models/coffee_model.dart';
import 'package:coffee_app/providers/favorite.dart';
import 'package:coffee_app/screens/tab_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './providers/cart.dart';
import './providers/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/coffee_item_screen.dart';
import './screens/cart_screen.dart';
import './screens/onboardingg_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './providers/cart.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(myApp(showHome: showHome));
}

class myApp extends StatelessWidget {
  final bool showHome;
  const myApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Coffee>(
            create: (ctx) => Coffee("", []),
            update: (ctx, auth, previousCoffee) =>
                Coffee(auth.token ?? "", previousCoffee?.items ?? []),
          ),

          ChangeNotifierProxyProvider<Auth, Cart>(
            create: (ctx) => Cart("", []),
            update: (ctx, auth, previousCart) =>
                Cart(auth.token ?? "", previousCart!.cartItem),
          ),
          ChangeNotifierProxyProvider<Auth, Favorite>(
            create: (ctx) => Favorite("", []),
            update: (context, auth, previousFav) =>
                Favorite(auth.token ?? "", previousFav?.favItems ?? []),
          ), //var response = await http.get(url);
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            home: showHome
                ? (auth.isAuth ? TabScreen() : AuthScreen())
                : const OnBoardingScreeen(),
            routes: {
              AuthScreen.route: (context) => AuthScreen(),
              TabScreen.route: (context) => TabScreen(),
              CoffeeItemScreen.route: (context) => CoffeeItemScreen(),
              CartScreen.route: (context) => CartScreen(),
            },
            title: 'Drinks',
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}
