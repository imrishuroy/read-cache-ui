class CreateUserReqDto {
  CreateUserReqDto({
    required this.email,
    required this.name,
  });

  factory CreateUserReqDto.fromJson(Map<String, dynamic> map) {
    return CreateUserReqDto(
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }
  final String email;

  final String name;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'LoginReqDto(email:$email, name:$name)';
  }
}
