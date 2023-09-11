import 'package:flutter/material.dart';
import 'package:flutter_front/auth/component/custom_container.dart';
import 'package:flutter_front/common/utils/validation_util.dart';
import 'package:flutter_front/common/component/custom_text_button.dart';
import 'package:flutter_front/common/component/custom_text_form_field.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginView extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(loginViewModelProvider);
    return CustomContainer(
      maxWidth: !kIsMobile ? 500 : 450,
      maxHeight: !kIsMobile ? 600 : 400,
      child: Padding(
        padding: EdgeInsets.all(kPaddingLargeSize).copyWith(top: 0),
        child: Form(
          key: viewModel.loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _Title(),
              SizedBox(height: kPaddingLargeSize),
              CustomTextFormField(
                labelText: "아이디",
                hintText: '아이디를 입력해주세요',
                controller: viewModel.idTextController,
                validator: validateId,
              ),
              SizedBox(height: kPaddingLargeSize),
              CustomTextFormField(
                labelText: "비밀번호",
                hintText: '비밀번호를 입력해주세요',
                keyboardType: TextInputType.visiblePassword,
                controller: viewModel.passwordTextController,
                validator: validatePassword,
              ),
              SizedBox(height: kPaddingXLargeSize),
              if (viewModel.state is LoadingState)
                SizedBox(
                  width: !kIsMobile ? 76 : null,
                  height: !kIsMobile ? 76 : null,
                  child: const CircularProgressIndicator(
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
                            onPressed: () {
                              viewModel
                                  .launch(dotenv.get("KUMOH42_FIND_ACCOUNT"));
                            },
                            text: 'ID / PW 찾기',
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: kPaddingSmallSize),
                          CustomTextButton(
                            onPressed: () async {
                              viewModel.launch(dotenv.get('KUMOH42_REGISTER'));
                            },
                            text: '금오사이 회원가입',
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: kPaddingSmallSize),
                          CustomTextButton(
                            onPressed: () {},
                            text: '관리자에게 문의하기',
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
                      child: Text(
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
