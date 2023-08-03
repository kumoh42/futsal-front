import 'package:flutter_front/common/utils/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_entity.g.dart';

@JsonSerializable()
class ReservationStatusEntity {
  @JsonKey(name: "reservation_srl")
  final int reservationId;
  @JsonKey(name: "place_srl")
  final int? placeId;
  @JsonKey(name: "date", fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime date;
  @JsonKey(name: "time")
  final int time;
  @JsonKey(name: "is_able")
  final String isAble;
  @JsonKey(name: "is_holiday")
  final String isHoliday;
  @JsonKey(name: "regdate", fromJson: _regDateFromJson, toJson: _regDateToJson)
  final DateTime regDate;
  @JsonKey(name: "circle")
  final String circle;
  @JsonKey(name: "major")
  final String major;

  static DateTime _dateFromJson(String date) => defaultDateFormat.parse(date);
  static String _dateToJson(DateTime date) => defaultDateFormat.format(date);

  static DateTime _regDateFromJson(String date) => regDateFormat.parse(date);
  static String _regDateToJson(DateTime date) => regDateFormat.format(date);

  ReservationStatusEntity({
    required this.reservationId,
    required this.placeId,
    required this.date,
    required this.time,
    required this.isAble,
    required this.isHoliday,
    required this.regDate,
    required this.circle,
    required this.major,
  });

  Map<String, dynamic> toJson() => _$ReservationStatusEntityToJson(this);

  factory ReservationStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationStatusEntityFromJson(json);
}
