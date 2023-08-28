import 'package:json_annotation/json_annotation.dart';

part 'reservation_cancle_entity.g.dart';

@JsonSerializable()
class ReservationCancelEntity {
  @JsonKey(name: "date")
  String date;
  @JsonKey(name: "time")
  List<int> time;
  @JsonKey(name: "isPre")
  bool isPre;
  ReservationCancelEntity(
      {required this.date, required this.isPre, required this.time});
  Map<String, dynamic> toJson() => _$ReservationCancelEntityToJson(this);
}
