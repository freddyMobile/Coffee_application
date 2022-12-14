import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(32, 21, 32, 1),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(239, 227, 200, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
            padding: const EdgeInsets.only(left: 15, top: 70, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Center(
                  child: Text(
                    'Farid Ahmadov',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(15),
                  child: ListTile(
                    onTap: () {},
                    splashColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: const Text('Payment Methods'),
                    leading: const Icon(Icons.payment_outlined),
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(15),
                  child: ListTile(
                    onTap: () {},
                    splashColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: const Text('Notifications'),
                    leading: const Icon(Icons.notifications_none),
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(15),
                  child: ListTile(
                    onTap: () {},
                    splashColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: const Text('Change Password'),
                    leading: const Icon(Icons.lock_outline),
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(15),
                  child: ListTile(
                    onTap: () {},
                    splashColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: const Text('Logout'),
                    leading: const Icon(Icons.logout_outlined),
                    iconColor: Colors.black,
                    textColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/168/168879.png'))),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.55),
                  height: 120,
                  width: 120,
                  alignment: Alignment.bottomRight,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 77, top: 77),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(32, 21, 32, 1),
                  ),
                  clipBehavior: Clip.none,
                  height: 50,
                  width: 50,
                  child: IconButton(
                      iconSize: 26,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Color.fromRGBO(239, 227, 200, 1),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
