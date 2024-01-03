part of 'cache_bloc.dart';

abstract class CacheState extends Equatable {
  const CacheState();  

  @override
  List<Object> get props => [];
}
class CacheInitial extends CacheState {}
