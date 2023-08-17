import 'package:flutter/material.dart';
import 'package:flutter_front/auth/model/service/auth_service.dart';
import 'package:flutter_front/auth/model/state/auth_state.dart';
import 'package:flutter_front/common/const/tabs.dart';
import 'package:flutter_front/common/layout/default_layout.dart';
import 'package:flutter_front/common/styles/styles.dart';
import 'package:flutter_front/common/utils/custom_dialog_utils.dart';
import 'package:flutter_front/common/view/construction_screen.dart';
import 'package:flutter_front/reservation_status/view/reservation_status_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with TickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: TABS.length,
      animationDuration: Duration.zero,
      vsync: this,
    );
    controller.addListener(tabListener);
  }

  void tabListener() => setState(() => index = controller.index);

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '풋살장 예약 시스템 관리자 페이지',
      leading: Image.asset(
        'assets/image/text_logo.png',
        fit: BoxFit.fitWidth,
      ),
      appbarHeight: kAppbarHeight,
      leadingWidth: kNavigationRailSize,
      backgroundColor: CustomColor.backgroundMainColor,
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${(ref.read(authServiceProvider) as AuthStateSuccess).data.userName}님 안녕하세요!",
              style: kTextReverseStyleMiddle,
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 15,
            top: 2,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            iconSize: 20,
            splashRadius: 25,
            color: CustomColor.textReverseColor,
            onPressed: () {
              CustomDialogUtil.showCustomDialog(
                context: context,
                dialog: CustomDialog(
                  onPressed: ref.read(authServiceProvider.notifier).logout,
                  accept: "logout",
                  content: const Text(
                    "정말 로그아웃 하시겠습니까?",
                    style: kTextNormalStyleMiddle,
                  ),
                ),
              );
            },
          ),
        ),
      ],
      /*bottomNavigationBar: MediaQuery.of(context).size.width > 700 ? null : BottomNavigationBar(
        backgroundColor: CustomColor.mainColor,
        selectedItemColor: CustomColor.backGroundSubColor,
        unselectedItemColor: CustomColor.disabledColor.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) => setState(() => controller.animateTo(index)),
        currentIndex: index,
        items: TABS
            .map((e) => BottomNavigationBarItem(
          icon: Icon(e.icon),
          label: e.label,
        ))
            .toList(),
      ),*/
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            /*if(MediaQuery.of(context).size.width > 700)*/
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                width: kNavigationRailSize,
                child: IntrinsicHeight(
                  child: NavigationRail(
                    backgroundColor: CustomColor.subColor,
                    useIndicator: true,
                    indicatorColor: CustomColor.backgroundMainColor,
                    selectedLabelTextStyle:
                        const TextStyle(color: CustomColor.backgroundMainColor),
                    unselectedLabelTextStyle: TextStyle(
                        color: CustomColor.disabledColor.withOpacity(0.5)),
                    selectedIconTheme:
                        const IconThemeData(color: CustomColor.subColor),
                    unselectedIconTheme: IconThemeData(
                        color: CustomColor.disabledColor.withOpacity(0.5)),
                    destinations: TABS.map((e) => _destination(e)).toList(),
                    selectedIndex: index,
                    onDestinationSelected: controller.animateTo,
                    extended: true,
                    trailing: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(kPaddingSmallSize),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kPaddingSmallSize,
                                vertical: kPaddingXLargeSize,
                              ),
                              child: Text(
                                "기술 문의\n\nTeam Kumoh-42",
                                style: kTextReverseStyleMiddle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ReservationStatusScreen(),
                  ConstructionScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  NavigationRailDestination _destination(TabInfo info) {
    return NavigationRailDestination(
      indicatorShape: const RoundedRectangleBorder(),
      icon: Icon(info.icon),
      label: Text(
        info.label,
        style: kTextReverseStyleMiddle.copyWith(fontSize: 18),
      ),
    );
  }
}
