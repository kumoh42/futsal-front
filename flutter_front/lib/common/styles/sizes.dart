import 'package:flutter/material.dart';

const double _kResponsiveTrigger1920 = 1920;
const double _kResponsiveTrigger1300 = 1300;
const double _kResponsiveTrigger768 = 768;
const double _kResponsiveTrigger586 = 586;
const double _kResponsiveTrigger360 = 360;

double displayWidth = 1440;

bool get kIsWeb => displayWidth > _kResponsiveTrigger1300;

bool get kIsTab => !kIsWeb && displayWidth > _kResponsiveTrigger586;

bool get kIsMobile => displayWidth <= _kResponsiveTrigger586;

double get kLayoutWidthSize => 1368;

double get kMainPageContainerHeightSize =>
    850 / _kResponsiveTrigger1920 * displayWidth > 850
        ? 850 / _kResponsiveTrigger1920 * displayWidth
        : !kIsMobile ? 850 : 900;

double get kNavigationRailSize => !kIsMobile ? 100 : 0;

double get kAppbarHeight => !kIsMobile ? 75 : 50;

double get kContainerWidthSize => !kIsMobile ? 400 : 280;
double get kContainerHeightSize => !kIsMobile ? 461 : 350;

const double kBorderRadiusSize = 12.0;
const double kBorderRadiusMiniSize = 5.0;
const double kBorderSideWidth = 0.5;

Size kOutlinedButtonSize = Size.fromHeight(kTextLargeSize * 2);
Size kOutlinedSmallButtonSize = Size(kTextMiddleSize, kTextMiddleSize);
Size kTextButtonSize = Size.fromHeight(kTextSmallSize);

const double kIconMainSize = 28.0;
const double kIconMiddleSize = 24.0;
const double kIconSmallSize = 20.0;
const double kIconMiniSize = 16.0;

double get kPaddingXLargeSize => !kIsMobile ? 64.0 : 28.0;

double get kPaddingLargeSize => !kIsMobile ? 32.0 : 14.0;

double get kPaddingMiddleSize => !kIsMobile ? 16.0 : 7.0;

double get kPaddingSmallSize => !kIsMobile ? 8.0 : 3.5;

double get kPaddingMiniSize => !kIsMobile ? 4.0 : 1.75;

double get kTextXLargeSize => !kIsMobile ? 44.0 : 28.0;

double get kTextLargeSize => !kIsMobile ? 28.0 : 21.0;

double get kTextMiddleSize => !kIsMobile ? 21.0 : 16.0;

double get kTextSmallSize => !kIsMobile ? 14.0 : 10.5;

double get kTextMiniSize => !kIsMobile ? 10.5 : 7.0;

const double kLineLargeSize = 5.0;
const double kLineSmallSize = 2.0;

const double kTextHeight = 1.4;

double get kSubPageContainerHeightSize => !kIsMobile ? 250 : 200;