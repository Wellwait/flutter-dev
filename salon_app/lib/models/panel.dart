import 'dart:convert';

// To parse this JSON data, do
// final panel = panelFromJson(jsonString);

List<Panel> panelFromJson(String str) => List<Panel>.from(json.decode(str).map((x) => Panel.fromJson(x)));

String panelToJson(List<Panel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Panel {
  final int? id;  // Added id field
  final String? name;
  final String? description;
  final int? price;
  final int? serviceProviderId;
  final String? serviceList;
  int? queueCount;

  Panel({
    this.id, // Include id in the constructor
    this.name,
    this.description,
    this.price,
    this.serviceProviderId,
    this.serviceList,
  });

  Panel copyWith({
    int? id,  // Add id to the copyWith method
    String? name,
    String? description,
    int? price,
    int? serviceProviderId,
    String? serviceList,
  }) =>
      Panel(
        id: id ?? this.id,  // Set id if provided, otherwise use existing
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        serviceProviderId: serviceProviderId ?? this.serviceProviderId,
        serviceList: serviceList ?? this.serviceList,
      );

  factory Panel.fromJson(Map<String, dynamic> json) => Panel(
    id: json["id"],  // Parse id from JSON
    name: json["name"],
    description: json["description"],
    price: json["price"],
    serviceProviderId: json["service_provider_id"],
    serviceList: json["service_list"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,  // Include id in the JSON output
    "name": name,
    "description": description,
    "price": price,
    "service_provider_id": serviceProviderId,
    "service_list": serviceList,
  };
}
