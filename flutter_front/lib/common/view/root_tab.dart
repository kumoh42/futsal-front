import 'package:flutter/material.dart';
import 'package:flutter_front/common/const/tabs.dart';
import 'package:flutter_front/common/layout/default_layout.dart';
import 'package:flutter_front/common/styles/colors.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/reservation_status/view/reservation_status_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with TickerProviderStateMixin {
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
      child: Row(
        children: [
          /*if(MediaQuery.of(context).size.width > 700)*/ SizedBox(
            width: kNavigationRailSize,
            child: NavigationRail(
              backgroundColor: CustomColor.mainColor,
              useIndicator: true,
              indicatorColor: CustomColor.backGroundSubColor,
              selectedLabelTextStyle: const TextStyle(color: CustomColor.backGroundSubColor),
              unselectedLabelTextStyle: TextStyle(color: CustomColor.disabledColor.withOpacity(0.5)),
              selectedIconTheme: const IconThemeData(color: CustomColor.mainColor),
              unselectedIconTheme: IconThemeData(color: CustomColor.disabledColor.withOpacity(0.5)),
              destinations: TABS.map((e) => _destination(e)).toList(),
              selectedIndex: index,
              onDestinationSelected: controller.animateTo,
              extended: true,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              // TODO : Add Tab Screen
              children: const [
                ReservationStatusScreen(),
                ReservationStatusScreen(),
              ],
            ),
          ),
        ],
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
