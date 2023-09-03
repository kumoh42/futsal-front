import 'package:flutter_front/reservation_status/model/entity/pre_reservation/pre_reservation_status_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'progress_reservation_entity.g.dart';

@JsonSerializable()
class ProgressReservationEntity {
  PreReservationStatusEntity date;
  bool isPre;
  ProgressReservationEntity({required this.isPre, required this.date});

  Map<String, dynamic> toJson() => _$ProgressReservationEntityToJson(this);

  factory ProgressReservationEntity.fromJson(Map<String, dynamic> json) =>
      _$ProgressReservationEntityFromJson(json);
}
