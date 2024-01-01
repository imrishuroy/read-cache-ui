class SignUpReqDto {
  SignUpReqDto({
    required this.email,
    required this.password,
    required this.name,
  });

  factory SignUpReqDto.fromJson(Map<String, dynamic> map) {
    return SignUpReqDto(
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
    );
  }
  final String email;
  final String password;
  final String name;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'LoginReqDto(email:$email, password:$password, name:$name)';
  }
}
