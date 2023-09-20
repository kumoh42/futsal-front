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
            constraints: ResponsiveData.kIsMobile
                ? BoxConstraints(
                    maxWidth: ResponsiveSize.M(750),
                    maxHeight: ResponsiveSize.M(750),
                  )
                : const BoxConstraints(maxWidth: 500, maxHeight: 500),
            child: Padding(
              padding: EdgeInsets.all(
                ResponsiveData.kIsMobile
                    ? ResponsiveSize.S(kWPaddingXLargeSize)
                    : kWPaddingXLargeSize,
              ).copyWith(top: 0),
              child: Form(
                key: viewModel.loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Title(),
                    const SizedBox(height: kWPaddingLargeSize),
                    CustomTextFormField(
                      labelText: "아이디",
                      hintText: '아이디를 입력해주세요',
                      controller: viewModel.idTextController,
                      validator: validateId,
                    ),
                    const SizedBox(height: kWPaddingLargeSize),
                    CustomTextFormField(
                      labelText: "비밀번호",
                      hintText: '비밀번호를 입력해주세요',
                      keyboardType: TextInputType.visiblePassword,
                      controller: viewModel.passwordTextController,
                      validator: validatePassword,
                    ),
                    const SizedBox(height: kWPaddingXLargeSize),
                    if (viewModel.state is LoadingState)
                      SizedBox(
                        width: ResponsiveData.kIsMobile
                            ? ResponsiveSize.M(76)
                            : 76,
                        height: ResponsiveData.kIsMobile
                            ? ResponsiveSize.M(76)
                            : 76,
                        child:
                            const CircularProgressIndicator(color: kMainColor),
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
                                const SizedBox(height: kWPaddingSmallSize),
                                CustomTextButton(
                                  onPressed: () async {
                                    viewModel
                                        .launch(dotenv.get('KUMOH42_REGISTER'));
                                  },
                                  text: '금오사이 회원가입',
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: kWPaddingSmallSize),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: viewModel.login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor,
                              minimumSize: Size(
                                ResponsiveData.kIsMobile
                                    ? ResponsiveSize.M(200)
                                    : 176,
                                ResponsiveData.kIsMobile
                                    ? ResponsiveSize.M(80)
                                    : 60,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  kWBorderRadiusSize,
                                ),
                              ),
                            ),
                            child: Text(
                              '로그인',
                              style: kTextReverseStyle.copyWith(
                                fontSize: ResponsiveData.kIsMobile
                                    ? ResponsiveSize.M(kWTextLargeSize)
                                    : kWTextMiddleSize,
                              ),
                            ),
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
    return Row(
      children: [
        Image(
          image: const AssetImage("assets/image/black_logo.png"),
          width: ResponsiveData.kIsMobile ? ResponsiveSize.M(150) : 100,
          height: ResponsiveData.kIsMobile ? ResponsiveSize.M(150) : 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Text(
            'Administrator Login\n- 체육시설 예약 시스템 -',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveData.kIsMobile
                  ? ResponsiveSize.M(kWTextLargeSize)
                  : kWTextMiddleSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
