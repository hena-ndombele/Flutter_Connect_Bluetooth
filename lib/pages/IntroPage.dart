import 'package:app_bluetooth/pages/AppareilPage.dart';
import 'package:app_bluetooth/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../utils/ColorPages.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: IntroductionScreen(
          globalBackgroundColor: ColorPages.COLOR_BLANCHE,
          scrollPhysics: BouncingScrollPhysics(),
          pages: [
            PageViewModel(
                titleWidget: const Text(
                  "Mes appareils",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: ColorPages.COLOR_PRINCIPALE,
                      fontFamily: 'Schyler'
                    // color: Color.fromRGBO(158, 79, 194, 0)
                  ),
                ),
                body: "Rechecher des appareils à proximité...",
                image: Image.asset(
                  "images/image1.png",
                  height: 400,
                  width: 600,
                )),
          ],
          onDone: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ListeAppareilPage()));
          },
          next: const Icon(
            Icons.arrow_forward,
            color: ColorPages.COLOR_PRINCIPALE,
          ),
          done: Container(
            child: Text(
              "Appareils",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ColorPages.COLOR_PRINCIPALE,
                fontFamily: 'Schyler',
              ),
            ),
          ),
          dotsDecorator: DotsDecorator(
              size: Size.square(7.0),
              activeSize: Size(15.0, 10.0),
              color: Colors.black26,
              activeColor: ColorPages.COLOR_PRINCIPALE,
              spacing: EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              )),
        ),
      ),
    );
  }
}
