part of 'cache_bloc.dart';

abstract class CacheEvent extends Equatable {
  const CacheEvent();

  @override
  List<Object> get props => [];
}

class CacheListLoaded extends CacheEvent {}

class CacheCreated extends CacheEvent {
  const CacheCreated({
    required this.title,
    required this.link,
  });

  final String title;
  final String link;

  @override
  List<Object> get props => [title, link];
}
