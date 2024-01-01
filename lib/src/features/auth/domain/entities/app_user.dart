import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.email,
    required this.name,
    this.id,
  });

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

  @override
  List<Object?> get props => [id, email, name];
}
