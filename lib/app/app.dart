import 'package:counter_frezeed/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final readBlc = context.read<CounterBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
        centerTitle: true,

        // evento que pone al estado en su versión inicial
        leading: TextButton(
          child: const Icon(Icons.refresh_rounded),
          onPressed: () {
            readBlc.add(const CounterEvent.refreshInitial());
          },
        ),
        actions: [
          //
          // eventos que hace el incremento del texto
          TextButton(
            child: const Icon(Icons.add_rounded),
            onPressed: () {
              readBlc.add(const CounterEvent.increment());
            },
          ),
          //
          // evento que hace el decremento del text
          TextButton(
            child: const Icon(Icons.remove_rounded),
            onPressed: () {
              readBlc.add(const CounterEvent.decrement());
            },
          ),
        ],
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          //
          // retornas un wedget por estado del bloc
          return Center(
            child: state.when(
              initial: () => Text(
                '0',
                style: textStyle(),
              ),
              loading: () => const CircularProgressIndicator.adaptive(),
              running: (number) {
                return Text(
                  '$number',
                  style: textStyle(),
                );
              },
            ),
          );
        },
      ),
    );
  }

  //
  // método perzonalizado para el tex style

  TextStyle textStyle() {
    return const TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.w600,
    );
  }
}
