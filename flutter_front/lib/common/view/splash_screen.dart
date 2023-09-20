import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/default_container.dart';
import 'package:flutter_front/common/styles/colors.dart';

class SplashScreen extends StatelessWidget {
  static String get routeName => 'splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      isExpanded: true,
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/image/white_logo.png', width: 500),
          const SizedBox(height: 16.0),
          const CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }
}
