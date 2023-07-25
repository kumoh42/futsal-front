// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationStatusEntity _$ReservationStatusEntityFromJson(
        Map<String, dynamic> json) =>
    ReservationStatusEntity(
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      reservationId: json['reservationId'] as String,
      member: json['member'] as String,
    );

Map<String, dynamic> _$ReservationStatusEntityToJson(
        ReservationStatusEntity instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'time': instance.time,
      'reservationId': instance.reservationId,
      'member': instance.member,
    };
