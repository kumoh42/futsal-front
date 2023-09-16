import 'package:flutter/material.dart';
import 'package:flutter_front/common/view/construction_screen.dart';
import 'package:flutter_front/reservation_status/view/pre_reservation_setting_view.dart';
import 'package:flutter_front/reservation_status/view/reservation_status_view.dart';

class TabInfo {
  final String label;
  final Widget tab;

  const TabInfo({required this.label, required this.tab});
}

const TABS = [
  TabInfo(label: '예약 현황 관리', tab: ReservationStatusView()),
  TabInfo(label: '사전 예약 설정', tab: PreReservationSettingView()),
  TabInfo(label: "사용자 관리", tab: ConstructionScreen()),
];
