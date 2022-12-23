import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_event.dart';
part 'counter_state.dart';
part 'counter_bloc.freezed.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const _Initial()) {
    on<CounterEvent>((event, emit) async {
      if (state is _Initial) {
        emit(const CounterState.running(number: 0));
      }
      if (state is _Running) {
        final number = (state as _Running).number;
        emit(const CounterState.loading());

        emit(await event.when(
          increment: () {
            // await Future.delayed(const Duration(seconds: 1));
            return CounterState.running(number: number + 1);
          },
          decrement: () {
            // await Future.delayed(const Duration(seconds: 1));
            return CounterState.running(number: number - 1);
          },
          refreshInitial: () async {
            await Future.delayed(const Duration(seconds: 1));
            return const CounterState.running(number: 0);
          },
        ));
      }

      // emit(state.when(
      //   initial: () => const CounterState.running(0),
      //   loading: () => const CounterState.loading(),
      //   running: (number) {
      //     return event.when(
      //       increment: () => CounterState.running(number + 1),
      //       decrement: () => CounterState.running(number == 0 ? 0 : number - 1),
      //       refreshInitial: () => const CounterState.running(0),
      //     );
      //   },
      // ));
    });
  }
}
