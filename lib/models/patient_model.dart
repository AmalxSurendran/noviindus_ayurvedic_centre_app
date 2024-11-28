class Patient {
  final int id;
  final String user;
  final String payment;
  final String name;
  final String phone;
  final String address;
  final double? price;
  final double totalAmount;
  final double discountAmount;
  final double advanceAmount;
  final double balanceAmount;
  final String? dateNdTime;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final List<TreatmentDetails> patientDetails;
  final Branch branch;

  Patient({
    required this.id,
    required this.user,
    required this.payment,
    required this.name,
    required this.phone,
    required this.address,
    required this.price,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    this.dateNdTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.patientDetails,
    required this.branch,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      user: json['user'] ?? '',
      payment: json['payment'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      price: json['price'] != null ? json['price'].toDouble() : null,
      totalAmount:
          json['total_amount'] != null ? json['total_amount'].toDouble() : 0.0,
      discountAmount: json['discount_amount'] != null
          ? json['discount_amount'].toDouble()
          : 0.0,
      advanceAmount: json['advance_amount'] != null
          ? json['advance_amount'].toDouble()
          : 0.0,
      balanceAmount: json['balance_amount'] != null
          ? json['balance_amount'].toDouble()
          : 0.0,
      dateNdTime: json['date_nd_time'],
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      patientDetails: (json['patientdetails_set'] as List?)
              ?.map((item) => TreatmentDetails.fromJson(item))
              .toList() ??
          [], // Default to empty list if null
      branch: json['branch'] != null
          ? Branch.fromJson(json['branch'])
          : Branch.empty(),
    );
  }
}

class TreatmentDetails {
  final int id;
  final String treatmentName;
  final int patientId;
  final int treatmentId;
  final String male;
  final String female;

  TreatmentDetails({
    required this.id,
    required this.treatmentName,
    required this.patientId,
    required this.treatmentId,
    required this.male,
    required this.female,
  });

  factory TreatmentDetails.fromJson(Map<String, dynamic> json) {
    return TreatmentDetails(
      id: json['id'] ?? 0,
      treatmentName: json['treatment_name'] ?? '',
      patientId: json['patient'] ?? 0,
      treatmentId: json['treatment'] ?? 0,
      male: json['male'] ?? '',
      female: json['female'] ?? '',
    );
  }
}

class Branch {
  final int id;
  final String name;
  final int patientsCount;
  final String location;
  final String phone;
  final String mail;
  final String address;
  final String gst;
  final bool isActive;

  Branch({
    required this.id,
    required this.name,
    required this.patientsCount,
    required this.location,
    required this.phone,
    required this.mail,
    required this.address,
    required this.gst,
    required this.isActive,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      patientsCount: json['patients_count'] ?? 0,
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      mail: json['mail'] ?? '',
      address: json['address'] ?? '',
      gst: json['gst'] ?? '',
      isActive: json['is_active'] ?? true,
    );
  }

  // Empty constructor for fallback
  factory Branch.empty() {
    return Branch(
      id: 0,
      name: '',
      patientsCount: 0,
      location: '',
      phone: '',
      mail: '',
      address: '',
      gst: '',
      isActive: true,
    );
  }
}
