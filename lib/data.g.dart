// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      (json['Light'] as num).toDouble(),
      json['MotionSensor'] as bool,
      json['OpeningTime'] as bool,
      json['System'] as bool,
      OpenTimeRange.fromJson(json['TimeRange'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Light': instance.Light,
      'MotionSensor': instance.MotionSensor,
      'OpeningTime': instance.OpeningTime,
      'System': instance.System,
      'TimeRange': instance.TimeRange.toJson(),
    };

OpenTimeRange _$OpenTimeRangeFromJson(Map<String, dynamic> json) =>
    OpenTimeRange(
      json['EndHour'] as int,
      json['EndMin'] as int,
      json['StartHour'] as int,
      json['StartMin'] as int,
    );

Map<String, dynamic> _$OpenTimeRangeToJson(OpenTimeRange instance) =>
    <String, dynamic>{
      'EndHour': instance.EndHour,
      'EndMin': instance.EndMin,
      'StartHour': instance.StartHour,
      'StartMin': instance.StartMin,
    };
