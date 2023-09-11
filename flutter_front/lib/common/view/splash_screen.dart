import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_front/common/layout/default_layout.dart';
import 'package:flutter_front/common/styles/colors.dart';

class SplashScreen extends StatelessWidget {
  static String get routeName => 'splash';

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultLayout(
      backgroundColor: CustomColor.mainColor,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/white_logo.png',
              width: min(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ) /
                  2,
            ),
            const SizedBox(height: 16.0),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
