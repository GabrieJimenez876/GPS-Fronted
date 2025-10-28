class SyndicateModel {
  final String id;
  final String name;
  final String description;
  final String contactNumber;
  final List<String> routeIds;

  SyndicateModel({
    required this.id,
    required this.name,
    required this.description,
    required this.contactNumber,
    required this.routeIds,
  });

  factory SyndicateModel.fromJson(Map<String, dynamic> json) {
    return SyndicateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      contactNumber: json['contactNumber'] as String,
      routeIds: List<String>.from(json['routeIds'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'contactNumber': contactNumber,
      'routeIds': routeIds,
    };
  }
}
