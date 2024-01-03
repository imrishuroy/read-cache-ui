import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.email,
    required this.name,
    this.id,
  });

  factory AppUser.fromJson(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  final String? id;
  final String? email;
  final String? name;

  AppUser copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, email, name];
}
