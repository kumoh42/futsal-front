import 'package:flutter/material.dart';
import 'package:flutter_front/common/component/base_dialog.dart';
import 'package:flutter_front/common/component/container/designed_container.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/styles/text_styles.dart';
import 'package:flutter_front/reservation_status/component/designed_button.dart';
import 'package:flutter_front/user_management/model/entity/user_info_entity.dart';
import 'package:flutter_front/user_management/model/state/wating_user_list_state.dart';
import 'package:flutter_front/user_management/view/user_info_content.dart';
import 'package:flutter_front/user_management/viewmodel/user_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AwaitingApprovalListDialog extends ConsumerStatefulWidget {
  const AwaitingApprovalListDialog({super.key});

  @override
  ConsumerState<AwaitingApprovalListDialog> createState() =>
      _AwaitingApprovalListDialogState();
}

class _AwaitingApprovalListDialogState
    extends ConsumerState<AwaitingApprovalListDialog> {
  @override
  void initState() {
    super.initState();
    Future(
      () => ref.read(userListViewmodelProvider.notifier).getAwaitingUserList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = ref.watch(userListViewmodelProvider);

    return BaseDialog(
      title: "사용자 승인 대기 명단",
      child: SizedBox(
        width: ResponsiveData.kIsMobile
            ? ResponsiveSize.M(500)
            : ResponsiveSize.W(500),
        height: ResponsiveData.kIsMobile
            ? ResponsiveSize.M(500)
            : ResponsiveSize.W(500),
        child: viewmodel.watingState is WatingUserListStateLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : viewmodel.watingState is WatingUserListStateSuccess
                ? viewmodel.awaitingUsers!.isEmpty
                    ? Center(
                        child: Text(
                          "대기자가 없습니다",
                          style: kTextNormalStyle.copyWith(
                            fontSize: kTextMiddleSize,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) => AwaitingUser(
                          user: viewmodel.awaitingUsers![index],
                          onPressedApprove: () => viewmodel.approve(
                              viewmodel.awaitingUsers![index], context),
                          onPressedReject: () => viewmodel.reject(
                              viewmodel.awaitingUsers![index], context),
                        ),
                        itemCount: viewmodel.awaitingUsers!.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: kPaddingSmallSize,
                        ),
                      )
                : Center(
                    child: Text(
                      "대기자가 없습니다",
                      style: kTextNormalStyle.copyWith(
                        fontSize: kTextMiddleSize,
                      ),
                    ),
                  ),
      ),
    );
  }
}

class AwaitingUser extends StatelessWidget {
  final UserInfo user;
  final Function() onPressedApprove;
  final Function() onPressedReject;

  const AwaitingUser({
    super.key,
    required this.user,
    required this.onPressedApprove,
    required this.onPressedReject,
  });

  @override
  Widget build(BuildContext context) {
    return DesignedContainer(
      title: "사용자",
      actions: [
        DesignedButton(
          onPressed: onPressedReject,
          icon: Icons.close,
          color: kPointColor,
          text: "거절",
        ),
        SizedBox(
          width: kPaddingMiniSize,
        ),
        DesignedButton(
          onPressed: onPressedApprove,
          icon: Icons.person_add_sharp,
          text: "승인",
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kWPaddingSmallSize,
          vertical: kWPaddingMiniSize,
        ),
        child: UserInfoContent(
          user: user,
          isShow: true,
        ),
      ),
    );
  }
}
