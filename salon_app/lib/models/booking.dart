import 'dart:convert';

List<Booking> bookingFromJson(String str) => List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

String bookingToJson(List<Booking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Booking {
  final int? id;
  final String? username;
  final DateTime? scheduledDate;
  final String? serviceName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? panelId;
  final int? serviceProviderId;
  final int? status;
  final int? price;
  final String? panelName;
  final int? started;
  final String? startedAt;
  final int? finished;
  final String? finishedAt;
  final String? salonName;
  final String? address;

  Booking({
    this.id,
    this.username,
    this.scheduledDate,
    this.serviceName,
    this.createdAt,
    this.updatedAt,
    this.panelId,
    this.serviceProviderId,
    this.status,
    this.price,
    this.panelName,
    this.started,
    this.startedAt,
    this.finished,
    this.finishedAt,
    this.salonName,
    this.address,
  });

  Booking copyWith({
    int? id,
    String? username,
    DateTime? scheduledDate,
    String? serviceName,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? panelId,
    int? serviceProviderId,
    int? status,
    int? price,
    String? panelName,
    int? started,
    String? startedAt,
    int? finished,
    String? finishedAt,
    String? salonName,
    String? address,
  }) =>
      Booking(
        id: id ?? this.id,
        username: username ?? this.username,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        serviceName: serviceName ?? this.serviceName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        panelId: panelId ?? this.panelId,
        serviceProviderId: serviceProviderId ?? this.serviceProviderId,
        status: status ?? this.status,
        price: price ?? this.price,
        panelName: panelName ?? this.panelName,
        started: started ?? this.started,
        startedAt: startedAt ?? this.startedAt,
        finished: finished ?? this.finished,
        finishedAt: finishedAt ?? this.finishedAt,
        salonName: salonName ?? this.salonName,
        address: address ?? this.address,
      );

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    username: json["username"] ?? '',
    scheduledDate: json["scheduled_date"] == null ? DateTime.now() : DateTime.parse(json["scheduled_date"]),
    serviceName: json["service_name"] ?? '',
    createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? DateTime.now() : DateTime.parse(json["updatedAt"]),
    panelId: json["panel_id"] ?? '' ,
    serviceProviderId: json["service_provider_id"],
    status: json["status"] ?? '',
    price: json["price"] ?? '',
    panelName: json["panel_name"] ?? '',
    started: json["started"] ?? '',          // New field
    startedAt: json["started_at"] ?? '',  // New field
    finished: json["finished"] ?? '',        // New field
    finishedAt: json["finished_at"] ?? '',  // New field
    salonName: json["salon_name"] ?? '',
    address: json['address'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "scheduled_date": scheduledDate?.toIso8601String(),
    "service_name": serviceName,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "panel_id": panelId,
    "service_provider_id": serviceProviderId,
    "status": status,
    "price": price,
    "panel_name": panelName,
    "started": started,          // New field
    "started_at": startedAt.toString(),  // New field
    "finished": finished,        // New field
    "finished_at": finishedAt?.toString(), // New field
    "salon_name": salonName?.toString(),
    "address": address?.toString(),
  };
}

