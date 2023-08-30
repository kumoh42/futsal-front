import 'package:json_annotation/json_annotation.dart';

part 'pre_reservation_status_entity.g.dart';

@JsonSerializable()
class PreReservationStatusEntity {
  String dates;
  String times;
  PreReservationStatusEntity({
    required this.dates,
    required this.times,
  });
  Map<String, dynamic> toJson() => _$PreReservationStatusEntityToJson(this);

  factory PreReservationStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$PreReservationStatusEntityFromJson(json);
}
