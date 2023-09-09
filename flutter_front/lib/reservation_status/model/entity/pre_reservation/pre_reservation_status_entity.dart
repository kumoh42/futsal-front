import 'package:json_annotation/json_annotation.dart';

part 'pre_reservation_status_entity.g.dart';

@JsonSerializable()
class PreReservationStatusEntity {
  String date;
  String time;
  PreReservationStatusEntity({
    required this.date,
    required this.time,
  });
  Map<String, dynamic> toJson() => _$PreReservationStatusEntityToJson(this);

  factory PreReservationStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$PreReservationStatusEntityFromJson(json);
}
