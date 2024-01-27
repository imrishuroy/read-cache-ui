// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cache.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Cache _$CacheFromJson(Map<String, dynamic> json) {
  return _Cache.fromJson(json);
}

/// @nodoc
mixin _$Cache {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String? get owner => throw _privateConstructorUsedError;
  @DateTimeConverter()
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CacheCopyWith<Cache> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CacheCopyWith<$Res> {
  factory $CacheCopyWith(Cache value, $Res Function(Cache) then) =
      _$CacheCopyWithImpl<$Res, Cache>;
  @useResult
  $Res call(
      {String title,
      String content,
      @JsonKey(includeIfNull: false) int? id,
      @JsonKey(includeToJson: false) String? owner,
      @DateTimeConverter()
      @JsonKey(name: 'created_at', includeToJson: false)
      DateTime? createdAt});
}

/// @nodoc
class _$CacheCopyWithImpl<$Res, $Val extends Cache>
    implements $CacheCopyWith<$Res> {
  _$CacheCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? id = freezed,
    Object? owner = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CacheImplCopyWith<$Res> implements $CacheCopyWith<$Res> {
  factory _$$CacheImplCopyWith(
          _$CacheImpl value, $Res Function(_$CacheImpl) then) =
      __$$CacheImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String content,
      @JsonKey(includeIfNull: false) int? id,
      @JsonKey(includeToJson: false) String? owner,
      @DateTimeConverter()
      @JsonKey(name: 'created_at', includeToJson: false)
      DateTime? createdAt});
}

/// @nodoc
class __$$CacheImplCopyWithImpl<$Res>
    extends _$CacheCopyWithImpl<$Res, _$CacheImpl>
    implements _$$CacheImplCopyWith<$Res> {
  __$$CacheImplCopyWithImpl(
      _$CacheImpl _value, $Res Function(_$CacheImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? id = freezed,
    Object? owner = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CacheImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CacheImpl implements _Cache {
  const _$CacheImpl(
      {required this.title,
      required this.content,
      @JsonKey(includeIfNull: false) this.id,
      @JsonKey(includeToJson: false) this.owner,
      @DateTimeConverter()
      @JsonKey(name: 'created_at', includeToJson: false)
      this.createdAt});

  factory _$CacheImpl.fromJson(Map<String, dynamic> json) =>
      _$$CacheImplFromJson(json);

  @override
  final String title;
  @override
  final String content;
  @override
  @JsonKey(includeIfNull: false)
  final int? id;
  @override
  @JsonKey(includeToJson: false)
  final String? owner;
  @override
  @DateTimeConverter()
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Cache(title: $title, content: $content, id: $id, owner: $owner, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, content, id, owner, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheImplCopyWith<_$CacheImpl> get copyWith =>
      __$$CacheImplCopyWithImpl<_$CacheImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CacheImplToJson(
      this,
    );
  }
}

abstract class _Cache implements Cache {
  const factory _Cache(
      {required final String title,
      required final String content,
      @JsonKey(includeIfNull: false) final int? id,
      @JsonKey(includeToJson: false) final String? owner,
      @DateTimeConverter()
      @JsonKey(name: 'created_at', includeToJson: false)
      final DateTime? createdAt}) = _$CacheImpl;

  factory _Cache.fromJson(Map<String, dynamic> json) = _$CacheImpl.fromJson;

  @override
  String get title;
  @override
  String get content;
  @override
  @JsonKey(includeIfNull: false)
  int? get id;
  @override
  @JsonKey(includeToJson: false)
  String? get owner;
  @override
  @DateTimeConverter()
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CacheImplCopyWith<_$CacheImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
