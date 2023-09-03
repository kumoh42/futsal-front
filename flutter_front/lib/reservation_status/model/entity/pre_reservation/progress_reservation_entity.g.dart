// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_reservation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgressReservationEntity _$ProgressReservationEntityFromJson(
        Map<String, dynamic> json) =>
    ProgressReservationEntity(
      isPre: json['isPre'] as bool,
      date: PreReservationStatusEntity.fromJson(
          json['date'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProgressReservationEntityToJson(
        ProgressReservationEntity instance) =>
    <String, dynamic>{
      'date': instance.date,
      'isPre': instance.isPre,
    };
