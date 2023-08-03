import 'package:flutter/material.dart';
import 'package:flutter_front/auth/component/custom_container.dart';
import 'package:flutter_front/common/component/custom_text_button.dart';
import 'package:flutter_front/common/component/custom_text_form_field.dart';
import 'package:flutter_front/common/state/state.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  static String get routeName => 'login';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider);
    return CustomContainer(
      minWidth: MediaQuery.of(context).size.width * 0.25 >= 500 ? 500 : MediaQuery.of(context).size.width * 0.25,
      maxWidth: MediaQuery.of(context).size.width * 0.25 >= 550 ? MediaQuery.of(context).size.width * 0.25 : 550,
      minHeight: MediaQuery.of(context).size.height * 0.6 >= 550 ? 550 : MediaQuery.of(context).size.height * 0.6,
      maxHeight: MediaQuery.of(context).size.height * 0.6 >= 600 ? MediaQuery.of(context).size.height * 0.6 : 600,
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
                      backgroundColor: CustomColor.mainColor,
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
