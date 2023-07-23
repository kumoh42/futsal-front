import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/custom_text_button.dart';
import 'package:flutter_front/common/component/custom_text_form_field.dart';
import 'package:flutter_front/common/layout/default_layout.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/user/viewmodel/login_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider);
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: _LoginContainer(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingLargeSize).copyWith(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _Title(),
                const SizedBox(height: kPaddingLargeSize),
                CustomTextFormField(
                  labelText: "아이디",
                  hintText: '아이디를 입력해주세요',
                  controller: viewModel.idTextController,
                ),
                const SizedBox(height: kPaddingLargeSize),
                CustomTextFormField(
                  labelText: "비밀번호",
                  hintText: '비밀번호를 입력해주세요',
                  keyboardType: TextInputType.visiblePassword,
                  controller: viewModel.passwordTextController,
                ),
                const SizedBox(height: kPaddingXLargeSize),
                if (viewModel.state is LoadingState)
                  const SizedBox(
                    width: 76,
                    height: 76,
                    child: CircularProgressIndicator(
                      color: CustomColor.buttonSubColor,
                    ),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CustomTextButton(
                              onPressed: () {},
                              text: 'ID / PW 찾기',
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: kPaddingSmallSize),
                            CustomTextButton(
                              onPressed: () {},
                              text: '금오사이 회원가입',
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: kPaddingSmallSize),
                            CustomTextButton(
                              onPressed: () {},
                              text: '관리자 권한 요청',
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: viewModel.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.buttonSubColor,
                          minimumSize: const Size(176, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              kBorderRadiusSize,
                            ),
                          ),
                        ),
                        child: const Text('로그인'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginContainer extends StatelessWidget {
  final Widget child;

  const _LoginContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          // TODO : 이미지 추가
          // image: DecorationImage(
          //   fit: BoxFit.cover,
          //   image: AssetImage('assets/image/background.png'),
          // ),
          ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.6,
          constraints: const BoxConstraints(
            maxWidth: 550,
            minWidth: 500,
            maxHeight: 600,
            minHeight: 550,
          ),
          child: Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
            width: 100,
            height: 100,
            child: Image(
              image: AssetImage("assets/image/logo.png"),
              fit: BoxFit.cover,
            )),
        Expanded(
          child: Text(
            'Administrator Login\n- 체육시설 예약 시스템 -',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
