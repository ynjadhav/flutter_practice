import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var onBoardingData = [
    {
      "image": "assets/onboarding/screen1.png",
      "title": "Title one",
      "description": "Description one"
    },
    {
      "image": "assets/onboarding/screen2.png",
      "title": "Title Two",
      "description": "Description Two"
    },
    {
      "image": "assets/onboarding/screen3.png",
      "title": "Title Three",
      "description": "Description Three"
    }
  ];

  Color whiteColor = Colors.white;
  Color textColor = Colors.black;

  PageController pageController = PageController();

  int currentPage = 0;

  void onChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: onSkip,
            child: Text(
              'Skip',
              style: TextStyle(color: textColor),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              itemCount: onBoardingData.length,
              onPageChanged: onChange,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(onBoardingData[index]['image']!),
                    Text(
                      onBoardingData[index]['title']!,
                      style: TextStyle(color: textColor, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      onBoardingData[index]['description']!,
                      style: TextStyle(color: textColor, fontSize: 20),
                    )
                  ],
                );
              }),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (currentPage == (onBoardingData.length - 1))
                    ? ElevatedButton(
                    onPressed: onSkip, child: const Text('Continue'))
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(onBoardingData.length, (index) {
                    return AnimatedContainer(
                      duration: Duration(microseconds: 20),
                      height: 10,
                      width: (index == currentPage) ? 20 : 10,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == currentPage)
                              ? Colors.deepOrange
                              : Colors.grey
                      ),
                    );
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> onSkip() async {

    final SharedPreferences preferences = await _prefs;
    preferences.setBool("isOnBoarded", true);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) =>
                MyHome()));
  }
}
