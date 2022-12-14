import 'package:flutter/material.dart';
import '../widgets/coffee_frame.dart';
import '../providers/coffee.dart';
import '../models/coffee_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Coffee>(context, listen: true).fetchAndSetProducts();
    }
    _isInit = false;
    super.didChangeDependencies();
  }*/
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
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
      await Provider.of<Coffee>(context, listen: false)
          .fetchAndSetProducts()
          .then((value) {
        Navigator.of(context).pop();
      });
    });

    super.initState();
  }

  final searchController = TextEditingController();
  var textIndex;
  List<CoffeeModel>? itemListSearch;
  final FocusNode focusSearch = FocusNode();

  /*void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(focusSearch);
  }*/

  @override
  Widget build(BuildContext context) {
    var cf = Provider.of<Coffee>(context);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: MediaQuery.of(context).size.height * 0.2,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 25),
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Hello Farid!', maxLines: 2),
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.notifications_none,
                              color: Colors.black87),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor:
                                const Color.fromRGBO(239, 227, 200, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(23, 16, 23, 1)),
                    child: TextField(
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            itemListSearch = cf.items
                                .where((element) => element.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                            /*textIndex = cf.items.indexWhere((element) =>
                              element.name.toLowerCase() ==
                              value.toLowerCase());*/
                          });
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'Browse your favorite coffee',
                            contentPadding: const EdgeInsets.only(top: 10),
                            hintStyle: const TextStyle(
                                fontSize: 15, color: Colors.grey))),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color.fromRGBO(32, 21, 32, 1),
            body: (searchController.text.isNotEmpty && itemListSearch!.isEmpty)
                ? SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                color: Colors.white,
                                Icons.search_off,
                                size: 160,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'No result found,\nPlease try different keyword',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(75, 79, 48, 46),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(45))),
                        height: MediaQuery.of(context).size.height * 0.64,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: TextButton(
                                    onPressed: () {},
                                    child: const RotatedBox(
                                      quarterTurns: -1,
                                      child: Text(
                                        'Buy coffee beans',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(
                                                239, 227, 200, 1)),
                                      ),
                                    )),
                              ),
                              Container(
                                child: TextButton(
                                    onPressed: () {},
                                    child: const RotatedBox(
                                      quarterTurns: -1,
                                      child: Text(
                                        'Health Caution',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(
                                                239, 227, 200, 1)),
                                      ),
                                    )),
                              ),
                              Container(
                                child: TextButton(
                                    onPressed: () {},
                                    child: RotatedBox(
                                      quarterTurns: -1,
                                      child: Text(
                                        'About developer',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(
                                                239, 227, 200, 1)),
                                      ),
                                    )),
                              )
                            ]),
                      ),
                      Scrollbar(
                        thickness: 3,
                        radius: const Radius.circular(20),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 4),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.6),
                            itemBuilder: (context, index) =>
                                CoffeeFrame(index, itemListSearch ?? []),
                            itemCount: searchController.text.isNotEmpty
                                ? itemListSearch!.length
                                : cf.items.length,
                          ),
                        ),
                      ),
                    ],
                  )));
  }
}
