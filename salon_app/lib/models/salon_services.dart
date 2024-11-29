class ServicesProvider {
  final int? id;
  final String? providerName;
  final String? salonName;
  final String? address;
  final String? mobileNumber;
  final String? email;
  final int? viewCount;
  final String? serviceNames;
  final String? promoImages;
  double? averageRating; // Make this nullable
  int? totalRatings;     // Make this nullable
  final String? photo;
  final String? imageUrl;

  ServicesProvider({
    this.id,
    this.providerName,
    this.salonName,
    this.address,
    this.mobileNumber,
    this.email,
    this.viewCount,
    this.serviceNames,
    this.promoImages,
    this.averageRating,
    this.totalRatings,
    this.photo,
    this.imageUrl,
  });

  ServicesProvider copyWith({
    int? id,
    String? providerName,
    String? salonName,
    String? address,
    String? mobileNumber,
    String? email,
    int? viewCount,
    String? serviceNames,
    String? promoImages,
    double? averageRating,
    int? totalRatings,
    String? photo,
    String? imageUrl,
  }) =>
      ServicesProvider(
        id: id ?? this.id,
        providerName: providerName ?? this.providerName,
        salonName: salonName ?? this.salonName,
        address: address ?? this.address,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        email: email ?? this.email,
        viewCount: viewCount ?? this.viewCount,
        serviceNames: serviceNames ?? this.serviceNames,
        promoImages: promoImages ?? this.promoImages,
        averageRating: averageRating ?? this.averageRating,
        totalRatings: totalRatings ?? this.totalRatings,
        photo: photo ?? this.photo,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory ServicesProvider.fromJson(Map<String, dynamic> json) => ServicesProvider(
    id: json["id"],
    providerName: json["provider_name"],
    salonName: json["salon_name"],
    address: json["address"],
    mobileNumber: json["mobile_number"],
    email: json["email"],
    viewCount: json["view_count"],
    serviceNames: json["service_names"],
    promoImages: json["promo_images"],
    averageRating: json["average_rating"]?.toDouble(), // Parse averageRating
    totalRatings: json["total_ratings"], // Parse totalRatings
    photo: json['photo'],
    imageUrl: json['image_urls'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider_name": providerName,
    "salon_name": salonName,
    "address": address,
    "mobile_number": mobileNumber,
    "email": email,
    "view_count": viewCount,
    "service_names": serviceNames,
    "promo_images": promoImages,
    "average_rating": averageRating, // Include in toJson
    "total_ratings": totalRatings,     // Include in toJson
    "photo": photo,
    "image_urls": imageUrl,
  };
}
