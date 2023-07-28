import 'package:flutter_front/reservation_status/model/entity/reservation_member_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_entity.g.dart';

@JsonSerializable()
class ReservationStatusEntity {
  final DateTime date;
  final String time;
  final String reservationId;
  final ReservationMemberEntity member;

  ReservationStatusEntity({
    required this.date,
    required this.time,
    required this.reservationId,
    required this.member,
  });

  Map<String, dynamic> toJson() => _$ReservationStatusEntityToJson(this);

  factory ReservationStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$ReservationStatusEntityFromJson(json);
}
