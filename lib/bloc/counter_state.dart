part of 'counter_bloc.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState.initial() = _Initial;
  const factory CounterState.loading() = _Loading;
  const factory CounterState.running({required int number}) = _Running;
}
