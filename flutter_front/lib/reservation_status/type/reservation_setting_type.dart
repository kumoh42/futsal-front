import 'package:flutter_front/common/styles/colors.dart';

enum ReservationSettingType {
  started,
  closed;
}

extension ReservationSettingTypeParsing on ReservationSettingType {
  get color {
    switch(this) {
      case ReservationSettingType.started:
        return CustomColor.mainColor;
      case ReservationSettingType.closed:
        return CustomColor.pointColor;
    }
  }
  
  get value {
    switch(this) {
      case ReservationSettingType.started:
        return "시작됨";
      case ReservationSettingType.closed:
        return "종료됨";
    }
  }
}