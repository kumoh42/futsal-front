import 'package:flutter/material.dart';
import 'package:flutter_front/auth/component/custom_container.dart';
import 'package:flutter_front/auth/util/validation_util.dart';
import 'package:flutter_front/common/component/custom_text_button.dart';
import 'package:flutter_front/common/component/custom_text_form_field.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return CustomContainer(
      minWidth: MediaQuery.of(context).size.width * 0.25 >= 500
          ? 500
          : MediaQuery.of(context).size.width * 0.25,
      maxWidth: MediaQuery.of(context).size.width * 0.25 >= 550
          ? MediaQuery.of(context).size.width * 0.25
          : 550,
      minHeight: MediaQuery.of(context).size.height * 0.6 >= 550
          ? 550
          : MediaQuery.of(context).size.height * 0.6,
      maxHeight: MediaQuery.of(context).size.height * 0.6 >= 600
          ? MediaQuery.of(context).size.height * 0.6
          : 600,
      child: Padding(
        padding: const EdgeInsets.all(kPaddingLargeSize).copyWith(top: 0),
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
                  child: CircularProgressIndicator(
                    color: CustomColor.subColor,
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
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                  'https://kumoh42.com/index.php?mid=main&act=dispMemberFindAccount');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            text: 'ID / PW 찾기',
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: kPaddingSmallSize),
                          CustomTextButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                  'https://kumoh42.com/index.php?mid=main&act=dispMemberSignUpForm');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            text: '금오사이 회원가입',
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: kPaddingSmallSize),
                          CustomTextButton(
                            onPressed: () {},
                            text: 'EMPTY',
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.mainColor,
                        minimumSize: const Size(176, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            kBorderRadiusSize,
                          ),
                        ),
                      ),
                      child: const Text(
                        '로그인',
                        style: kTextReverseStyleMiddle,
                      ),
                    ),
                  ],
                ),
            ],
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
