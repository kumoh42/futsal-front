import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/common/utils/validation_util.dart';
import 'package:flutter_front/common/component/custom_text_button.dart';
import 'package:flutter_front/common/component/custom_text_form_field.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginView extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(loginViewModelProvider);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/image/login_background.png'),
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: kBackgroundMainColor,
              borderRadius: BorderRadius.circular(kBorderRadiusSize),
            ),
            constraints: const BoxConstraints(
              maxWidth: 500,
              maxHeight: 500,
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                kPaddingXLargeSize,
              ).copyWith(top: 0),
              child: Form(
                key: viewModel.loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _Title(),
                    const SizedBox(height: kPaddingLargeSize),
                    CustomTextFormField(
                      labelText: "아이디",
                      hintText: '아이디를 입력해주세요',
                      controller: viewModel.idTextController,
                      validator: validateId,
                    ),
                    const SizedBox(height: kPaddingLargeSize),
                    CustomTextFormField(
                      labelText: "비밀번호",
                      hintText: '비밀번호를 입력해주세요',
                      keyboardType: TextInputType.visiblePassword,
                      controller: viewModel.passwordTextController,
                      validator: validatePassword,
                    ),
                    const SizedBox(height: kPaddingXLargeSize),
                    if (viewModel.state is LoadingState)
                      const SizedBox(
                        width: 76,
                        height: 76,
                        child: CircularProgressIndicator(color: kMainColor),
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CustomTextButton(
                                  onPressed: () {
                                    viewModel.launch(
                                        dotenv.get("KUMOH42_FIND_ACCOUNT"));
                                  },
                                  text: 'ID / PW 찾기',
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: kPaddingSmallSize),
                                CustomTextButton(
                                  onPressed: () async {
                                    viewModel
                                        .launch(dotenv.get('KUMOH42_REGISTER'));
                                  },
                                  text: '금오사이 회원가입',
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: kPaddingSmallSize),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: viewModel.login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor,
                              minimumSize: const Size(176, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  kBorderRadiusSize,
                                ),
                              ),
                            ),
                            child: const Text('로그인',
                                style: kTextReverseStyleMiddle),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
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
              image: AssetImage("assets/image/black_logo.png"),
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
