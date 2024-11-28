class LoginResponse {
  final bool status;
  final String message;
  final String token;
  final bool isSuperuser;
  final UserDetails userDetails;

  LoginResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.isSuperuser,
    required this.userDetails,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      token: json['token'],
      isSuperuser: json['is_superuser'],
      userDetails: UserDetails.fromJson(json['user_details']),
    );
  }
}

class UserDetails {
  final int id;
  final String name;
  final String phone;
  final String mail;

  UserDetails({
    required this.id,
    required this.name,
    required this.phone,
    required this.mail,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      mail: json['mail'],
    );
  }
}
