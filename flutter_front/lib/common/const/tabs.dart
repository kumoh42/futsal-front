import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  const TabInfo({required this.icon, required this.label});
}

// ignore: constant_identifier_names
const TABS = [
  TabInfo(icon: Icons.search, label: '예약조회 및 설정'),
  TabInfo(icon: Icons.person_search, label: "사용자 조회"),
];
