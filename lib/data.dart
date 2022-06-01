// ignore_for_file: non_constant_identifier_names
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable(explicitToJson: true)
class Data {
  double Light;
  bool MotionSensor;
  bool OpeningTime;
  bool System;
  OpenTimeRange TimeRange;
  bool update;
  Data(
    this.Light,
    this.MotionSensor,
    this.OpeningTime,
    this.System,
    this.TimeRange,
    this.update,
  );
  //Constructor and Function from package 'json_serializable'
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  Future<void> save() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update(toJson());
  }
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

  @JsonKey(ignore: true)
  TimeOfDay get start {
    return TimeOfDay(hour: StartHour, minute: StartMin);
  }

  set start(TimeOfDay time) {
    StartHour = time.hour;
    StartMin = time.minute;
  }

  @JsonKey(ignore: true)
  TimeOfDay get end {
    return TimeOfDay(hour: EndHour, minute: EndMin);
  }

  set end(TimeOfDay time) {
    EndHour = time.hour;
    EndMin = time.minute;
  }
}
