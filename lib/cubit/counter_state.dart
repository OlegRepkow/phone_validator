part of 'counter_cubit.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CountryLoadingState extends CounterState {}

class CountryHasDataState extends CounterState {
  CountryHasDataState(this.countryCode);

  final List<Country> countryCode;

  @override
  List<Object> get props => [countryCode];
  
}
class CountryHasSeatchDataState extends CounterState {
  CountryHasSeatchDataState(this.countryCode);

  final List<Country> countryCode;

  @override
  List<Object> get props => [countryCode];
  
}
