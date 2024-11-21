// To parse this JSON data, do
//
//     final favorite = favoriteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Favorite> favoriteFromJson(String str) => List<Favorite>.from(json.decode(str).map((x) => Favorite.fromJson(x)));

String favoriteToJson(List<Favorite> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorite {
  int serviceProviderId;
  String salonName;
  String address;
  String photo;
  String averageRating;

  Favorite({
    required this.serviceProviderId,
    required this.salonName,
    required this.address,
    required this.photo,
    required this.averageRating,
  });

  Favorite copyWith({
    int? serviceProviderId,
    String? salonName,
    String? address,
    String? photo,
    String? averageRating,
  }) =>
      Favorite(
        serviceProviderId: serviceProviderId ?? this.serviceProviderId,
        salonName: salonName ?? this.salonName,
        address: address ?? this.address,
        photo: photo ?? this.photo,
        averageRating: averageRating ?? this.averageRating,
      );

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    serviceProviderId: json["service_provider_id"],
    salonName: json["salon_name"],
    address: json["address"],
    photo: json["photo"],
    averageRating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "service_provider_id": serviceProviderId,
    "salon_name": salonName,
    "address": address,
    "photo": photo,
    "average_rating": averageRating,
  };
}
