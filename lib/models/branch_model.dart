class Branch {
  final int id;
  final String name;

  Branch({required this.id, required this.name});

  // Factory constructor to create a Branch object from JSON
  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
    );
  }
}
