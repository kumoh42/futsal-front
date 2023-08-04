import 'package:flutter/material.dart';
import 'package:flutter_front/auth/model/service/auth_service.dart';
import 'package:flutter_front/auth/model/state/auth_state.dart';
import 'package:flutter_front/common/const/tabs.dart';
import 'package:flutter_front/common/layout/default_layout.dart';
import 'package:flutter_front/common/styles/styles.dart';
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
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: kPaddingSmallSize,
                                vertical: kPaddingXLargeSize,
                              ),
                              child: Text(
                                "기술 문의\n\nTeam Kumoh-42",
                                style: kTextReverseStyleSmall,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPaddingSmallSize),
                                    child: Text(
                                      "${(ref.read(authServiceProvider) as AuthStateSuccess).data.userName}님 안녕하세요!",
                                      style: kTextReverseStyleSmall,
                                    ),
                                  ),
                                  const SizedBox(height: kPaddingMiddleSize),
                                  OutlinedButton(
                                    onPressed: ref
                                        .read(authServiceProvider.notifier)
                                        .logout,
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: kPaddingMiddleSize,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: const Text(
                                      "로그아웃",
                                      style: kTextReverseStyleMiddle,
                                    ),
                                  ),
                                ],
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
      label: Text(info.label),
    );
  }
}
