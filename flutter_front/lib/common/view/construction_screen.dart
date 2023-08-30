import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/view/default_tab_bar_view.dart';

class ConstructionScreen extends StatelessWidget {
  const ConstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabBarView(
      isExpanded: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/black_logo.png",
              width: 300,
              height: 300,
            ),
            const Text(
              "해당 기능은 공사중 입니다. 빠른시일 내에 오픈하겠습니다.",
              style: kTextMainStyleLarge,
            ),
            const SizedBox(height: kPaddingXLargeSize),
          ],
        ),
      ),
    );
  }
}
