import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../screens/auth_screen.dart';

class OnBoardingScreeen extends StatefulWidget {
  const OnBoardingScreeen({super.key});

  @override
  State<OnBoardingScreeen> createState() => _OnBoardingScreeenState();
}

class _OnBoardingScreeenState extends State<OnBoardingScreeen> {
  var controller1 = PageController();
  var controller2 = PageController();

  bool isLastPage = false;
  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  controller: controller1,
                  onPageChanged: (index) {
                    controller2.jumpTo(controller1.offset);
                    setState(() => isLastPage = index == 2);
                  },
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/onboarding/asset1.jpg'))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/onboarding/asset2.jpg'))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/onboarding/asset3.png'))),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: SmoothPageIndicator(
                    controller: controller1,
                    count: 3,
                    onDotClicked: (index) => controller1.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn),
                    effect: WormEffect(
                      spacing: 16,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.teal.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 100,
            width: double.infinity,
            child: PageView(
                controller: controller2,
                onPageChanged: (index) {
                  controller2.jumpTo(controller1.offset);
                },
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Coffee is always a good idea...',
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'With coffee work,live,and earn efficiently...',
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'Pay attention to dose,overdrinking can damage your heart...',
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
          ),
          isLastPage
              ? Container(
                  height: 45,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF89410f)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showHome', true);
                        Navigator.of(context)
                            .pushReplacementNamed(AuthScreen.route);
                      },
                      child: Text(
                        'Order Coffee!',
                        style: TextStyle(fontSize: 16),
                      )),
                )
              : Container(
                  height: 45,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF89410f)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      onPressed: () {
                        controller1.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 16),
                      )),
                ),
          isLastPage
              ? const SizedBox()
              : TextButton(
                  onPressed: () {
                    controller1.jumpToPage(2);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 16, color: Color(0xFF89410f)),
                  )),
        ],
      ),
    );
  }
}
