// To parse this JSON data, do
//
//     final salonTiming = salonTimingFromJson(jsonString);

import 'dart:convert';

List<SalonTiming> salonTimingFromJson(String str) => List<SalonTiming>.from(json.decode(str).map((x) => SalonTiming.fromJson(x)));

String salonTimingToJson(List<SalonTiming> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalonTiming {
  final int? id;
  final int? salonId;
  final String? day;
  final String? startTime;
  final String? endTime;
  final String? lunchStart;
  final String? lunchEnd;

  SalonTiming({
    this.id,
    this.salonId,
    this.day,
    this.startTime,
    this.endTime,
    this.lunchStart,
    this.lunchEnd,
  });

  SalonTiming copyWith({
    int? id,
    int? salonId,
    String? day,
    String? startTime,
    String? endTime,
    String? lunchStart,
    String? lunchEnd,
  }) =>
      SalonTiming(
        id: id ?? this.id,
        salonId: salonId ?? this.salonId,
        day: day ?? this.day,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        lunchStart: lunchStart ?? this.lunchStart,
        lunchEnd: lunchEnd ?? this.lunchEnd,
      );

  factory SalonTiming.fromJson(Map<String, dynamic> json) => SalonTiming(
    id: json["id"],
    salonId: json["salon_id"],
    day: json["day"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    lunchStart: json["lunch_start"],
    lunchEnd: json["lunch_end"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "salon_id": salonId,
    "day": day,
    "start_time": startTime,
    "end_time": endTime,
    "lunch_start": lunchStart,
    "lunch_end": lunchEnd,
  };
}
