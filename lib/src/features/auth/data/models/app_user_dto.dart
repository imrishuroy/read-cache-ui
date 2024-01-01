import 'package:read_cache_ui/src/features/auth/domain/domain.dart';

class AppUserDto extends AppUser {
  const AppUserDto({
    required super.email,
    required super.name,
    super.id,
  });

  factory AppUserDto.fromJson(Map<String, dynamic> map) {
    return AppUserDto(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
