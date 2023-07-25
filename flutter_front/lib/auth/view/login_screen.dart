import 'package:flutter/material.dart';
import 'package:flutter_front/auth/view/login_view.dart';
import 'package:flutter_front/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          width: width,
          constraints: BoxConstraints(minHeight: height),
          // TODO : 이미지 추가
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     fit: BoxFit.cover,
          //     image: AssetImage('assets/image/background.png'),
          //   ),
          // ),
          child: const Center(child: LoginView()),
        ),
      ),
    );
  }
}
