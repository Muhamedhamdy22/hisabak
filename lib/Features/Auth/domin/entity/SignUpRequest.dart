class SignUpRequest {
  final String name;
  final String phone;
  final String password;

  SignUpRequest({
    required this.name,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'password': password,
  };
}