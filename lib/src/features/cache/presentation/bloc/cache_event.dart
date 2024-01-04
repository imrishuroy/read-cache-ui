part of 'cache_bloc.dart';

abstract class CacheEvent extends Equatable {
  const CacheEvent();

  @override
  List<Object> get props => [];
}

class CacheListLoaded extends CacheEvent {}
