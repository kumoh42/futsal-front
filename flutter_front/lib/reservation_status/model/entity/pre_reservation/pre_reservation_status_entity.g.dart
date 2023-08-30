// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_reservation_status_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreReservationStatusEntity _$PreReservationStatusEntityFromJson(
        Map<String, dynamic> json) =>
    PreReservationStatusEntity(
      dates: json['dates'] as String,
      times: json['times'] as String,
    );

Map<String, dynamic> _$PreReservationStatusEntityToJson(
        PreReservationStatusEntity instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'times': instance.times,
    };
