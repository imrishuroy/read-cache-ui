import 'package:equatable/equatable.dart';

class Cache extends Equatable {
  const Cache({
    required this.title,
    required this.link,
    this.id,
    this.owner,
    this.createdAt,
  });

  final int? id;
  final String? owner;
  final String? title;
  final String? link;
  final DateTime? createdAt;

  Cache copyWith({
    int? id,
    String? owner,
    String? title,
    String? link,
    DateTime? createdAt,
  }) {
    return Cache(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      title: title ?? this.title,
      link: link ?? this.link,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      owner,
      title,
      link,
      createdAt,
    ];
  }
}
