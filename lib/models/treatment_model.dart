class Treatment {
  final int id;
  final List<String> branches; // Assuming branches is a list of strings
  final String name;
  final String duration;
  final String price;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Constructor
  Treatment({
    required this.id,
    required this.branches,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Treatment object from JSON
  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'],
      branches: List<String>.from(json['branches'] ?? []),
      name: json['name'],
      duration: json['duration'],
      price: json['price'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert Treatment object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branches': branches,
      'name': name,
      'duration': duration,
      'price': price,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
