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

      /* LayoutBuilder->부모 위젯의 크기와 제약 조건에 따라 자식 위젯의 레이아웃을 동적으로 조정
       constraints 변수를 통해 부모 위젯의 제약 조건에 접근 */
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            /*if(MediaQuery.of(context).size.width > 700)*/
            // SingleChildScrollView 이 부분이 tab 부분
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  // root tab의 세로 높이.
                  minHeight: constraints.maxHeight,
                ),
                // root tab의 가로 너비
                width: kNavigationRailSize,

                /* IntrinsicHeight->자식 위젯들의 최소한의 크기를 감지하여 
                부모 위젯의 높이를 자식 위젯들 중 가장 큰 크기로 조정하는 데 사용 */
                child: IntrinsicHeight(
                  // NavigationRail->수직 또는 수평 방향의 네비게이션 메뉴를 생성하는 데 사용되는 위젯
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
                    // destinations 실제 메뉴에 나타날 위젯들
                    destinations: TABS.map((e) => _destination(e)).toList(),
                    selectedIndex: index,
                    // tab controller로 화면 전환
                    onDestinationSelected: controller.animateTo,
                    // 레일의 너비를 확장하거나 축소하는 것을 제어할 수 있음
                    extended: true,
                    // trailing ->보통 오른쪽 또는 아래쪽에 위치한 것, 해당 요소의 뒷쪽이나 끝에 위치하는 내용을 의미
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
            // 이 부분이 실제 tab 화면 부분
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
