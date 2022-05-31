// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable(explicitToJson: true)
class Data {
  int Human;
  double Light;
  bool MotionSensor;
  bool OpeningTime;
  bool System;
  OpenTimeRange TimeRange;
  Data(
    this.Human,
    this.Light,
    this.MotionSensor,
    this.OpeningTime,
    this.System,
    this.TimeRange,
  );
  //Constructor and Function from package 'json_serializable'
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class OpenTimeRange {
  int EndHour;
  int EndMin;
  int StartHour;
  int StartMin;
  OpenTimeRange(
    this.EndHour,
    this.EndMin,
    this.StartHour,
    this.StartMin,
  );
  //Constructor and Function from package 'json_serializable'
  factory OpenTimeRange.fromJson(Map<String, dynamic> json) =>
      _$OpenTimeRangeFromJson(json);
  Map<String, dynamic> toJson() => _$OpenTimeRangeToJson(this);

  TimeOfDay get start {
    return TimeOfDay(hour: StartHour, minute: StartMin);
  }

  TimeOfDay get end {
    return TimeOfDay(hour: EndHour, minute: EndMin);
  }
}
