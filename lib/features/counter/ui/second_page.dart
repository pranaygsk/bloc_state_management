import 'package:bloc_state_management/features/counter/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatefulWidget {
  final CounterBloc counterBloc;

  const SecondPage({super.key, required this.counterBloc});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterBloc, CounterState>(
      bloc: widget.counterBloc,
      listenWhen: (previous, current) => current is CounterActionState,
      buildWhen: (previous, current) => current is! CounterActionState,
      listener: (context, state) {
        if (state is CounterIncrementActionState ||
            state is CounterDecrementActionState ||
            state is CounterResetActionState) {
          setState(() {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Second Page",
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.counterBloc.count.toString(),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.counterBloc.add(
                      CounterIncrementEvent(),
                    );
                  },
                  child: const Text("Increment"),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.counterBloc.add(
                      CounterDecrementEvent(),
                    );
                  },
                  child: const Text("Decrement"),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.counterBloc.add(
                      CounterResetEvent(),
                    );
                  },
                  child: const Text("Reset"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
